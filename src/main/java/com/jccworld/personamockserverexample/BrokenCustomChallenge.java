package com.jccworld.personamockserverexample;

import com.jccworld.personamockserver.challenge.Challenge;
import com.jccworld.personamockserver.challenge.CustomResponse;
import spark.Request;
import spark.Response;

/**
 * @author johncrossley
 * @see <a href="https://github.com/JohnCrossley/PersonaMockServerExample">https://github.com/JohnCrossley/PersonaMockServerExample</a>
 */
public class BrokenCustomChallenge implements Challenge {
    public CustomResponse perform(Request request, Response response) throws Exception {
        final String die = request.queryParams("die");

        if (die != null) {
            if (die.equals("exception")) {
                throw new IllegalArgumentException("Oh no!");
            } else if (die.equals("wrongInstance")) {
                return new CustomResponse() {
                    @Override
                    public int hashCode() {
                        return 123;
                    }
                };
            }
        }

        return null;//no CustomResponse - logic error
    }
}
