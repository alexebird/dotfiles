use "format"
use "options"

actor Main
  let _program: String = "scan"
  let _env: Env
  // Some values we can set via command line options
  var _a_string: String = "default"
  var _a_number: USize = 0
  var _a_float: Float = F64(0.0)
  var _a_foo: Bool = false
  embed _some_args: Array[String ref]

  new create(env: Env) =>
    _some_args = _some_args.create(100)
    _env = env

    try
      arguments()
    end

    _env.out.print("The String is " + _a_string)
    _env.out.print("The Number is " + _a_number.string())
    _env.out.print("The Float is " + _a_float.string())
    _env.out.print("The Foo is " + _a_foo.string())

    for arg in _some_args.values() do
      _env.out.print(arg.string())
    end

  fun ref arguments() ? =>
    var options = Options(_env.args)

    options
      .add("string", "t", StringArgument)
      .add("number", "i", I64Argument)
      .add("float", "c", F64Argument)
      .add("foo", "f", None)

    for option in options do
      match option
      | ("string", let arg: String) => _a_string = arg
      | ("number", let arg: I64) => _a_number = arg.usize()
      | ("float", let arg: F64) => _a_float = arg
      | ("foo", let arg: None) => _a_foo = true
      | let err: ParseError => err.report(_env.out) ; usage() ; error
      end
    end

    let rem: Array[String ref] = options.remaining()
    for arg in rem.slice(1, rem.size()).values() do
      _some_args.push(arg.clone())
    end

  fun ref usage() =>
    _env.out.print(
      _program +
      """
       [OPTIONS]
        --string      N   a string argument. Defaults to 'default'.
        --number      N   a number argument. Defaults to 0.
        --float       N   a floating point argument. Defaults to 0.0.
        --foo             a boolean arg. Defaults to false.
      """
    )
