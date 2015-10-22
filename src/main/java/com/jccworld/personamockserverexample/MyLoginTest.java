package com.jccworld.personamockserverexample;

import com.jccworld.personamockserver.route.persona.LoginTest;
import com.jccworld.personamockserver.route.persona.PersonaSessionHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import spark.Request;

import java.util.HashMap;
import java.util.Map;

/**
 * @author johncrossley
 * @see <a href="https://github.com/JohnCrossley/PersonaMockServerExample">https://github.com/JohnCrossley/PersonaMockServerExample</a>
 */
public class MyLoginTest implements LoginTest {

    private final Logger logger = LoggerFactory.getLogger(MyLoginTest.class);

    private static final Map<String,String> APPROVED_USERS = new HashMap<String, String>() {{
        put("persona_session", "password123");
        put("brian", "password123");
        put("sally", "password123");
        put("peter", "password123");
    }};

    public void handleLoginRequest(final PersonaSessionHandler personaSessionHandler,
                                   final Request request) {

        //very trivial login system for sake of brevity
        if (request.url().contains("/login")) {
            final String usernameEntered = (request.queryParams("username") != null) ? request.queryParams("username") : "";
            final String passwordEntered = (request.queryParams("password") != null) ? request.queryParams("password") : "";

            if (APPROVED_USERS.containsKey(usernameEntered) && APPROVED_USERS.get(usernameEntered).equals(passwordEntered)) {
                logger.debug("Logged in as: ``" + usernameEntered + "''");
                personaSessionHandler.login(request.session(), usernameEntered);
            } else {
                logger.debug("Not a valid login!!: " + usernameEntered + " / " + passwordEntered);
                personaSessionHandler.logout(request.session());
            }
        }
    }

    public void handleLogoutRequest(PersonaSessionHandler personaSessionHandler, Request request) {
        if (request.url().contains("/logout")) {
            logger.debug("Logged out");
            personaSessionHandler.logout(request.session());
        }
    }
}
