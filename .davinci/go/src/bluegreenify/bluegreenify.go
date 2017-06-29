package main

import (
    "bytes"
    "fmt"
    "io"
    "os"
    "path/filepath"
    "strings"
    "strconv"
    "encoding/gob"
    "errors"

    "github.com/hashicorp/hcl"
    "github.com/hashicorp/hcl/hcl/ast"
    "github.com/hashicorp/hcl/hcl/printer"
    "github.com/hashicorp/hcl/hcl/token"

    //"github.com/davecgh/go-spew/spew"
    "gopkg.in/urfave/cli.v1"
)

type Options struct {
    ShouldAddDistinctHosts bool
    DefaultCount           string
    BlueCount              string
    GreenCount             string
}

func NewOptions() Options {
    opts := Options{}
    opts.ShouldAddDistinctHosts = true
    opts.DefaultCount           = "1"
    opts.BlueCount              = ""
    opts.GreenCount             = ""
    return opts
}

func parseHcl(inputFile io.Reader) (*ast.ObjectList, error) {
    var buf bytes.Buffer
    if _, err := io.Copy(&buf, inputFile); err != nil {
        return nil, err
    }

    root, err := hcl.Parse(buf.String())
    if err != nil {
        return nil, err
    }
    buf.Reset()

    var topLevel *ast.ObjectList
    var ok bool
    topLevel, ok = root.Node.(*ast.ObjectList)
    if !ok {
        panic("not ok")
    }

    return topLevel, nil
}

func cloneObjectItem(item *ast.ObjectItem) *ast.ObjectItem {
    var mod bytes.Buffer
    enc := gob.NewEncoder(&mod)
    dec := gob.NewDecoder(&mod)

    err := enc.Encode(item)
    if err != nil {
        panic(err)
    }

    var newItem *ast.ObjectItem
    err = dec.Decode(&newItem)
    if err != nil {
        panic(err)
    }

    return newItem
}

func makePos(offset int, line int, col int) token.Pos {
    return token.Pos{"", offset, line, col}
}

func addConstraint(objectList *ast.ObjectItem, pairs ...string) {
    var pairsAST []*ast.ObjectItem = make([]*ast.ObjectItem, 0, len(pairs)/2)

    for i := 0; i < len(pairs) / 2; i++ {
        iK, iV := i*2, i*2+1
        pos := makePos(i, i+1, i+2)
        key, val := pairs[iK], pairs[iV]
        //fmt.Printf("%d: %s, %s\n", i, key, val)
        //i++

        pairsAST = append(pairsAST,
            &ast.ObjectItem{
                Keys: []*ast.ObjectKey{
                    &ast.ObjectKey{
                        Token: token.Token{
                            Type: token.IDENT,
                            Pos:  pos,
                            Text: key,
                        },
                    },
                },
                Assign: pos,
                Val: &ast.LiteralType{
                    Token: token.Token{
                        Type: token.STRING,
                        Pos:  pos,
                        Text: val,
                    },
                },
            },
        )
    }

    constraint := &ast.ObjectItem{
        Keys: []*ast.ObjectKey{
            &ast.ObjectKey{
                Token: token.Token{
                    Type: token.IDENT,
                    Text: "constraint",
                },
            },
        },
        Val: &ast.ObjectType{
            List: &ast.ObjectList{
                Items: pairsAST,
            },
        },
    }

    insertChild(objectList, constraint, 0)
}

func createEmptyGroup(name string) *ast.ObjectItem {
    var newGroup *ast.ObjectItem = &ast.ObjectItem{
        Keys: []*ast.ObjectKey{
            &ast.ObjectKey{Token: token.Token{Type: token.IDENT, Text: "group"}},
            &ast.ObjectKey{Token: token.Token{Type: token.STRING, Text: name}},
        },
        Val: &ast.ObjectType{
            List: &ast.ObjectList{
                Items: []*ast.ObjectItem{},
            },
        },
    }

    return newGroup
}

func createNumberLiteralType(key string, value string) *ast.ObjectItem {
    return &ast.ObjectItem{
        Keys: []*ast.ObjectKey{
            &ast.ObjectKey{
                Token: token.Token{
                    Type: token.IDENT,
                    Pos: token.Pos{"", 0, 1, 2},
                    Text: key,
                },
            },
        },
        Assign: token.Pos{"", 0, 1, 2},
        Val: &ast.LiteralType{
            Token: token.Token{
                Type: token.NUMBER,
                Pos: token.Pos{"", 0, 1, 2},
                Text: value,
            },
        },
    }
}

func typeOfObject(objectItem *ast.ObjectItem) string {
    return keyTokenValue(objectItem, 0)
}

func nameOfObject(objectItem *ast.ObjectItem) string {
    return keyTokenValue(objectItem, 1)
}

func keyTokenValue(objectItem *ast.ObjectItem, i int) string {
    return objectItem.Keys[i].Token.Value().(string)
}

func objectItemLiteralValue(objectItem *ast.ObjectItem) string {
    return objectItem.Val.(*ast.LiteralType).Token.Text
}

func quote(str string) string {
    return fmt.Sprintf("\"%s\"", str)
}

func wrapTasksInGroup(job *ast.ObjectItem) {
    var jobChildren *ast.ObjectList = children(job)
    var groupName string = quote(nameOfObject(job))
    var newGroup *ast.ObjectItem = createEmptyGroup(groupName)
    var i int = 0
    var item *ast.ObjectItem

    for _, item = range jobChildren.Items {
        var itemType string = typeOfObject(item)

        if itemType == "task" {
            removeChildAtIndex(job, i)
            insertChild(newGroup, item, len(children(newGroup).Items))
        } else {
            // only increment i when we don't remove a child, thus changing the list size
            i++
        }
    }

    insertChild(job, newGroup, len(jobChildren.Items))
}

func insertChild(parent *ast.ObjectItem, child *ast.ObjectItem, idx int) {
    var childs *ast.ObjectList = children(parent)
    // create new before/after slices here, because if one of the slices is empty, or idx is zero,
    // it will be the same (in memory) as the original slice
    var beforeItems []*ast.ObjectItem = append([]*ast.ObjectItem{}, childs.Items[:idx]...)
    var afterItems []*ast.ObjectItem = append([]*ast.ObjectItem{}, childs.Items[idx:]...)
    childs.Items = append(beforeItems, child)
    childs.Items = append(childs.Items, afterItems...)
}

func removeChildAtIndex(parent *ast.ObjectItem, idx int) {
    var childs *ast.ObjectList = children(parent)
    var beforeItems []*ast.ObjectItem = childs.Items[:idx]
    var afterItems []*ast.ObjectItem = childs.Items[idx+1:]
    childs.Items = append(beforeItems, afterItems...)
}

// returns an ObjectList of ObjectItems matching the specified keys
func filter(o *ast.ObjectList, keys ...string) *ast.ObjectList {
    var result ast.ObjectList
    for _, item := range o.Items {
        // If there aren't enough keys, then ignore this
        if len(item.Keys) < len(keys) {
            continue
        }

        match := true
        for i, key := range item.Keys[:len(keys)] {
            key := key.Token.Value().(string)
            if key != keys[i] && !strings.EqualFold(key, keys[i]) {
                match = false
                break
            }
        }
        if !match {
            continue
        }

        result.Add(item)
    }

    return &result
}

// returns an ObjectList of children of the specified ObjectItem
func children(node *ast.ObjectItem) *ast.ObjectList {
    var childs *ast.ObjectList = node.Val.(*ast.ObjectType).List
    return childs
}

func getJob(topLevel *ast.ObjectList) *ast.ObjectItem {
    var job *ast.ObjectItem = filter(topLevel, "job").Items[0]
    return job
}

func hasGroup(job *ast.ObjectList) bool {
    var groups *ast.ObjectList = filter(job, "group")
    return len(groups.Items) > 0
}

func hasDistinctHostsConstraint(group *ast.ObjectItem) bool {
    var constraints *ast.ObjectList = filter(children(group), "constraint")

    for _, constraint := range constraints.Items {
        var attrs *ast.ObjectList = filter(children(constraint), "operator")

        if len(attrs.Items) > 0 && getAttrStringVal(attrs.Items[0]) == "distinct_hosts" {
            return true
        }
    }

    return false
}

func getAttrStringVal(item *ast.ObjectItem) string {
    return item.Val.(*ast.LiteralType).Token.Value().(string)
}

func getName(group *ast.ObjectItem) string {
    return group.Keys[1].Token.Value().(string)
}

func addSuffixToName(name string, color string) string {
    return quote(fmt.Sprintf("%s-%s", name, color))
}

func setName(item *ast.ObjectItem, name string) {
    item.Keys[1].Token.Text = name
}

func ensureDistinctHosts(group *ast.ObjectItem) {
    if !hasDistinctHostsConstraint(group) {
        addConstraint(group,
            "operator", quote("distinct_hosts"),
            "value", quote("true"),
        )
    }
}

func getCount(group *ast.ObjectItem) *ast.ObjectItem {
    var constraints *ast.ObjectList = filter(children(group), "count")
    if len(constraints.Items) == 1 {
        return constraints.Items[0]
    } else if len(constraints.Items) == 0 {
        return nil
    } else {
        panic(errors.New("found more than one count in a group"))
    }
}

func ensureCount(group *ast.ObjectItem, count string) {
    if countConstraint := getCount(group); countConstraint == nil {
        var newCount *ast.ObjectItem = createNumberLiteralType("count", count)
        insertChild(group, newCount, 0)
    } else {
        countConstraint.Val.(*ast.LiteralType).Token.Text = count
    }
}

func decorateGroup(group *ast.ObjectItem, opts Options, forceCount string, color string) {
	var countVal string = opts.DefaultCount
	var currCount *ast.ObjectItem = getCount(group)

	if opts.ShouldAddDistinctHosts {
		ensureDistinctHosts(group)
	}

	// decide to what value the count should be set
	if forceCount != "" {
		// if we are explictly setting a count, do that
		countVal = forceCount
	} else if currCount != nil {
		// if we are not explictly setting a count, and the group already has a count
		countVal = objectItemLiteralValue(currCount)
	}

	ensureCount(group, countVal)

	if color != "" {
		var existingName string = getName(group)
		if !strings.HasSuffix(existingName, color) {
			var newName string = addSuffixToName(existingName, color)
			setName(group, newName)
		}

		addConstraint(group,
			"attribute", quote("${meta.color}"),
			"operator", quote("="),
			"value", quote(color),
		)
	}
}

func groupCommand(topLevel *ast.ObjectList, c *cli.Context) {
    var opts Options = NewOptions()
    opts.ShouldAddDistinctHosts = !c.Bool("no-distinct-hosts")

    if cnt := c.Int("default-count"); cnt != -1 {
        opts.DefaultCount = strconv.Itoa(cnt)
    }

    if cnt := c.Int("blue-count"); cnt != -1 {
        opts.BlueCount = strconv.Itoa(cnt)
    }

    if cnt := c.Int("green-count"); cnt != -1 {
        opts.GreenCount = strconv.Itoa(cnt)
    }

	jobVer := c.String("job-version")

    var job *ast.ObjectItem = getJob(topLevel)
    var jobChildren *ast.ObjectList = children(job)
    var group *ast.ObjectItem

    // for the tasks that aren't in a group, put them in a group
    if !hasGroup(jobChildren) {
        wrapTasksInGroup(job)
    }

	if jobVer != "" {
		var existingName string = getName(job)
		var newName string = addSuffixToName(existingName, jobVer)
		setName(job, newName)
	}

    // operate on every group in the job
    for _, group = range filter(jobChildren, "group").Items {
		// clone the original group first, before we mutate it.
        var clonedGroup *ast.ObjectItem = cloneObjectItem(group)
        jobChildren.Add(clonedGroup)

		decorateGroup(
			group,
			opts,
			opts.BlueCount,
			"blue",
		)

		decorateGroup(
			clonedGroup,
			opts,
			opts.GreenCount,
			"green",
		)
    }
}

func jobCommand(topLevel *ast.ObjectList, c *cli.Context) {
    var opts Options = NewOptions()
    opts.ShouldAddDistinctHosts = !c.Bool("no-distinct-hosts")
	var forceCount string
	var color string = ""

    if cnt := c.Int("default-count"); cnt != -1 {
        opts.DefaultCount = strconv.Itoa(cnt)
    }

    if cnt := c.Int("count"); cnt != -1 {
        forceCount = strconv.Itoa(cnt)
    }

    if color = c.String("color"); color == "" {
		panic("must set a color")
    }

    var job *ast.ObjectItem = getJob(topLevel)
    var jobChildren *ast.ObjectList = children(job)
    var group *ast.ObjectItem

	// colorize the job's name
	var existingName string = getName(job)
	var newName string = addSuffixToName(existingName, color)
	setName(job, newName)

    // for the tasks that aren't in a group, put them in a group
    if !hasGroup(jobChildren) {
        wrapTasksInGroup(job)
    }

    // operate on every group in the job
    for _, group = range filter(jobChildren, "group").Items {
		decorateGroup(
			group,
			opts,
			forceCount,
			color,
		)
    }
}

func getInputReader(firstArg string) io.Reader {
    var inputIO io.Reader

    if firstArg == "" {
        inputIO = os.Stdin
    } else {
        path, err := filepath.Abs(firstArg)
        if err != nil {
            panic(err)
        }

        inputFile, err := os.Open(path)
        if err != nil {
            panic(err)
        }

        inputIO = inputFile
    }

    return inputIO
}

func parsingBasedCommand(c *cli.Context, cmdFunc func(topLevel *ast.ObjectList, c *cli.Context)) error {
    var topLevel *ast.ObjectList
    var err error
    //var firstArg string = c.Args().Get(0)
    var inputIO io.Reader = getInputReader("")

    topLevel, err = parseHcl(inputIO)
    if err != nil {
        panic(err)
    }

	// used for cloning AST nodes, encoding and decoding requires this registration
    gob.Register(&ast.ObjectType{})
    gob.Register(&ast.LiteralType{})
    gob.Register(&ast.ListType{})

    cmdFunc(topLevel, c)
    printer.Fprint(os.Stdout, topLevel)
    fmt.Print("\n")

    return nil
}

func main() {
    app := cli.NewApp()
    app.Name = "bluegreenify"
    app.Usage = "make nomad jobs blue/green"
    app.Version = "0.1.0"

    app.Flags = []cli.Flag {
        cli.BoolFlag{
            Name: "no-distinct-hosts",
            Usage: "disable adding of distinct_hosts operator to groups",
        },
		//cli.IntFlag{
			//Name: "default-count",
			//Value: -1,
			//Usage: "the value to use for a groups count if it doesnt already have a count",
		//},
    }

	app.Commands = []cli.Command{
		{
			Name:   "group",
			Usage:  "transform to blue/green at the group level",
			Action: func(c *cli.Context) error {
				parsingBasedCommand(c, groupCommand)
				return nil
			},
			Flags: []cli.Flag {
				cli.IntFlag{
					Name: "blue-count, b",
					Value: -1,
					Usage: "use this value for the count of blue groups",
				},
				cli.IntFlag{
					Name: "green-count, g",
					Value: -1,
					Usage: "use this value for the count of green groups",
				},
				cli.StringFlag{
					Name: "job-version",
					Value: "",
					Usage: "adds the specified string to the job name",
				},
			},
		},
		{
			Name:   "job",
			Usage:  "transform to blue/green at the job level",
			Action: func(c *cli.Context) error {
				parsingBasedCommand(c, jobCommand)
				return nil
			},
			Flags: []cli.Flag {
				cli.IntFlag{
					Name: "count, c",
					Value: -1,
					Usage: "use this value for the count of all groups",
				},
				cli.StringFlag{
					Name: "color, C",
					Value: "",
					Usage: "coloration of the job",
				},
			},
		},
	}

    app.Run(os.Args)
}
