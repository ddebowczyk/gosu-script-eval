package sample.eval;

import gw.config.CommonServices;
import gw.lang.Gosu;
import gw.lang.parser.*;
import gw.lang.parser.exceptions.ParseResultsException;
import gw.lang.reflect.java.JavaTypes;
import gw.util.GosuExceptionUtil;

public class GosuEvaluator00
{
    public static void main( String[] args )
    {
        Gosu.init();

        try {
            String content = "print('Java calls Gosu script from string')";

            GosuParserFactory
                    .createProgramParser()
                    .parseExpressionOrProgram(
                            content,
                            new StandardSymbolTable(true),
                            new ParserOptions()
                    )
                    .getProgram()
                    .getProgramInstance()
                    .evaluate(null);
        } catch (ParseResultsException e) {
            throw GosuExceptionUtil.forceThrow(e);
        }
    }
}
