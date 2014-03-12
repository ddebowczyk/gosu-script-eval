classpath "."

uses gw.config.CommonServices
uses gw.lang.parser.*
uses gw.lang.parser.exceptions.ParseResultsException
uses gw.lang.reflect.java.JavaTypes
uses gw.util.GosuExceptionUtil

Gosu.init()
try {
  var st = new StandardSymbolTable()
  st.putSymbol(CommonServices.getGosuIndustrialPark().createSymbol("var_a", JavaTypes.STRING(), "Ala ma kota"))

  var content = "print('Hello')\nprint(var_a)"

  GosuParserFactory
      .createProgramParser()
      .parseExpressionOrProgram(
      content,
          st,
          new ParserOptions()
      )
      .getProgram()
      .getProgramInstance()
      .evaluate(new ExternalSymbolMapSymbolTableWrapper(st, true));
} catch (e : ParseResultsException) {
  throw GosuExceptionUtil.forceThrow(e)
}
