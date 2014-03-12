classpath "."

uses gw.config.CommonServices
uses gw.lang.parser.*
uses gw.lang.parser.exceptions.ParseResultsException
uses gw.lang.reflect.java.JavaTypes
uses gw.util.GosuExceptionUtil
uses gw.util.StreamUtil
uses gw.lang.reflect.TypeSystem

Gosu.init()

try {
    var symbolTable = new StandardSymbolTable()
    symbolTable.putSymbol(
        CommonServices
            .getGosuIndustrialPark()
            .createSymbol("a", JavaTypes.STRING(), "test value")
    )

    var resource = TypeSystem.GosuClassLoader.ActualLoader.Class.getResource("/test.gsp")
    var content = new String(StreamUtil.getContent(resource.openStream()))

    print("Calling external Gosu script from Gosu")

    GosuParserFactory
        .createProgramParser()
        .parseExpressionOrProgram(
            content,
            symbolTable,
            new ParserOptions()
        )
        .getProgram()
        .getProgramInstance()
        .evaluate(new ExternalSymbolMapSymbolTableWrapper(symbolTable, true));
} catch (e : ParseResultsException) {
    throw GosuExceptionUtil.forceThrow(e)
}
