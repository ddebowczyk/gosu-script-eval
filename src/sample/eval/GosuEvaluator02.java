package sample.eval;

import gw.config.CommonServices;
import gw.lang.Gosu;
import gw.lang.parser.*;
import gw.lang.parser.exceptions.ParseResultsException;
import gw.lang.reflect.java.JavaTypes;
import gw.util.GosuExceptionUtil;
import gw.util.StreamUtil;

import java.io.IOException;
import java.net.URL;

public class GosuEvaluator02
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

            URL resource = GosuEvaluator02.class.getResource("/test.gsp");
            String content = new String(StreamUtil.getContent(resource.openStream()));

            System.out.println("Calling external Gosu script from Java");

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
                );
        } catch (IOException e) {
            throw GosuExceptionUtil.forceThrow(e);
        } catch (ParseResultsException e) {
            throw GosuExceptionUtil.forceThrow(e);
        }
    }
}
