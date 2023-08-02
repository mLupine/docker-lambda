package pl.lupin.lambda;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.s3.model.PutObjectResult;

import pl.lupin.lambda.DumpJava17;

public class DumpJava17_x86_64 implements RequestHandler<Object, PutObjectResult> {
    @Override
    public PutObjectResult handleRequest(Object input, Context context) {
        DumpJava17 dump = new DumpJava17();
        return dump.handle(input, context, "x86_64");
    }
}
