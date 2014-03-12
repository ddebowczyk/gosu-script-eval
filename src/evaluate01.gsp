classpath "."

uses gw.config.CommonServices
uses gw.lang.parser.*
uses gw.lang.parser.exceptions.ParseResultsException
uses gw.lang.reflect.java.JavaTypes
uses gw.util.GosuExceptionUtil

Gosu.init()

try {
    var symbolTable = new StandardSymbolTable()
    symbolTable.putSymbol(
        CommonServices
            .getGosuIndustrialPark()
            .createSymbol("a", JavaTypes.STRING(), "test value")
    )

    var content = "print('Hello - evaluating Gosu code from string with variable value set externally')\nprint('A = ' + a)"

    GosuParserFactory
        .createProgramParser()
        .parseExpressionOrProgram(
            content,
            symbolTable,
            new ParserOptions()
        )
        .getProgram()
        .getProgramInstance()
        .evaluate(
            new ExternalSymbolMapSymbolTableWrapper(symbolTable, true)
        )
} catch (e : ParseResultsException) {
    throw GosuExceptionUtil.forceThrow(e)
}
