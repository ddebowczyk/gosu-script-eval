package sample.eval;

import gw.config.CommonServices;
import gw.lang.Gosu;
import gw.lang.parser.*;
import gw.lang.parser.exceptions.ParseResultsException;
import gw.lang.reflect.java.JavaTypes;
import gw.util.GosuExceptionUtil;

public class GosuEvaluator01
{
    public static void main( String[] args )
    {
        Gosu.init();

        try {
            StandardSymbolTable symbolTable = new StandardSymbolTable();
            symbolTable.putSymbol(
                CommonServices
                    .getGosuIndustrialPark()
                    .createSymbol("a", JavaTypes.STRING(), "test value")
            );
            
            StringBuffer content = new StringBuffer();
            content.append("print('Java calls Gosu script from string with variable value set in externally in Java')");
            content.append("\n");
            content.append("print('A = ' + a)");

            GosuParserFactory
                .createProgramParser()
                .parseExpressionOrProgram(
                    content.toString(),
                    symbolTable,
                    new ParserOptions()
                )
                .getProgram()
                .getProgramInstance()
                .evaluate(
                    new ExternalSymbolMapSymbolTableWrapper(symbolTable, true)
                );
        } catch (ParseResultsException e) {
            throw GosuExceptionUtil.forceThrow(e);
        }
    }
}
