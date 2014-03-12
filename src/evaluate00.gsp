classpath "."

uses gw.lang.parser.*
uses gw.lang.parser.exceptions.ParseResultsException
uses gw.util.GosuExceptionUtil

Gosu.init()

try {
    var content = "print('Hello - evaluating Gosu code from string')"

    GosuParserFactory
        .createProgramParser()
        .parseExpressionOrProgram(
              content,
              new StandardSymbolTable(true),
              new ParserOptions()
        )
        .getProgram()
        .getProgramInstance()
        .evaluate(null)
} catch (e : ParseResultsException) {
    throw GosuExceptionUtil.forceThrow(e)
}
