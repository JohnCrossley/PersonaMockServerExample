package com.jccworld.personamockserverexample;

import com.jccworld.personamockserver.RouteRegistrar;
import com.jccworld.personamockserver.io.OutputWriter;
import com.jccworld.personamockserver.route.config.ConfigReader;
import com.jccworld.personamockserver.route.persona.LoginTest;
import com.jccworld.personamockserver.route.persona.PersonaReader;
import com.jccworld.personamockserver.route.persona.PersonaSessionHandler;

import java.util.ArrayList;
import java.util.List;

/**
 * @author johncrossley
 * @see <a href="https://github.com/JohnCrossley/PersonaMockServerExample">https://github.com/JohnCrossley/PersonaMockServerExample</a>
 */
public class MainController {

    private static final String PERSONA_PATH = "./web/personas";
    private static String BASE_URL = "https://www.example.com";

    private final static List<String> ignorePaths = new ArrayList<String>() {{
        add("/web/");
        add("/content/");
        add("/personas/");
    }};

    public static void main(String[] args) {
        final ConfigReader configReader = new ConfigReader();
        final OutputWriter outputWriter = new OutputWriter();
        final LoginTest loginTest = new MyLoginTest();
        final PersonaReader personaReader = new PersonaReader(PERSONA_PATH);
        final PersonaSessionHandler personaSessionHandler = new PersonaSessionHandler();
        final RouteRegistrar routeRegistrar =
                new RouteRegistrar(configReader, outputWriter, personaReader, personaSessionHandler, loginTest);

        routeRegistrar.registerExternalStaticFileLocation("./web");

        routeRegistrar.registerPost("login", null, null);
        routeRegistrar.registerPost("logout", null, null);

        //simple cases
        routeRegistrar.registerGet("simple", "simple.txt", null);
        routeRegistrar.registerGet("headers", "headers.txt", "headers.cfg");
        routeRegistrar.registerGet("delay", "delay.txt", "delay.cfg");
        routeRegistrar.registerGet("redirect", null, "redirect.cfg");
        routeRegistrar.registerGet("pdfinline", "AdobeXMLFormsSamples.pdf", "pdfinline.cfg");
        routeRegistrar.registerGet("pdfdownload", "AdobeXMLFormsSamples.pdf", "pdfdownload.cfg");
        routeRegistrar.registerGet("html", "html.html", "html.cfg");
        routeRegistrar.registerGet("xml", "xml.xml", "xml.cfg");
        routeRegistrar.registerGet("json", "json.json", "json.cfg");

        //persona simple case
        routeRegistrar.registerGet("news", "news.html", null);

        //has three responses based on how it is invoked
        routeRegistrar.registerGet("challenge", new MyCustomChallenge());

        //persona based
        routeRegistrar.registerGet("persona", "persona.txt", null);
        routeRegistrar.registerPost("persona", "persona.txt", null);
        routeRegistrar.registerPost("personaNoDefault", "this_does_not_exist.txt", null);

        //error cases
        routeRegistrar.registerGet("brokenCustomChallenge", new BrokenCustomChallenge());
        routeRegistrar.registerGet("badConfig", null, "bad_config.cfg");

        routeRegistrar.registerCatchAll(BASE_URL, ignorePaths);
    }
}

