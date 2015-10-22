package com.jccworld.personamockserverexample;

import com.jccworld.personamockserver.challenge.Challenge;
import com.jccworld.personamockserver.challenge.CustomResponse;
import com.jccworld.personamockserver.challenge.DataCustomResponse;
import com.jccworld.personamockserver.challenge.FileCustomResponse;
import com.jccworld.personamockserver.route.config.Config;
import spark.Request;
import spark.Response;

/**
 * @author johncrossley
 * @see <a href="https://github.com/JohnCrossley/PersonaMockServerExample">https://github.com/JohnCrossley/PersonaMockServerExample</a>
 */
public class MyCustomChallenge implements Challenge {
    public CustomResponse perform(final Request request, final Response response) throws Exception {
        String type = request.queryParams("type");

        if (type.equals("simple")) {
            return new FileCustomResponse("simple.txt", null);//use a known persona

        } else if (type.equals("pdfinline")) {
            return new FileCustomResponse("AdobeXMLFormsSamples.pdf", "pdfinline.cfg");//use a known persona

        } else if (type.equals("bespoke")) {

            //completely custom response
            final Config config = new Config();
            config.setStatus(200);//example

            final String responseBody = "<html><body><h1>This is entirely in code</h1></body></html>";

            return new DataCustomResponse(config, responseBody);

        } else {
            return new FileCustomResponse();
        }
    }
}
