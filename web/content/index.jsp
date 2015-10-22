<html>

<head>
    <title>Persona Mock Server</title>
    <script src="/content/ajax.js" type="text/javascript"></script>

    <style>
        .outer {
            float : left;
            width: 100%;
        }

        .inner {
            float : left;
            width: 50%;
        }

        .innerLarge {
            float: left;
            width: 100%;
            margin-top : 10px;
            margin-bottom : 10px;
            text-align: center;
        }

        .innerSmall {
            float: left;
            width: 33%;
            text-align: center;
        }
    </style>
</head>
<body>

    <h1>Really simple paths</h1>

    <p>These are used when the output is well defined and doesn't change per request.  Although it will change based on who's logged in (see personas below).</p>

    <table border="1">
        <tr>
            <th>Route</th>
            <th>Description</th>
            <th>Response Data</th>
            <th>Response Config</th>
        </tr>
        <tr>
            <td><a href="/simple" target="_blank">Simple</a></td>
            <td>The simplest setup - just a data response when the route is hit.  No config is required.</td>
            <td><a href="/personas/default/simple.txt" target="_blank">simple.txt</a></td>
            <td>n/a</td>
        </tr>

        <tr>
            <td><a href="/headers" target="_blank">Headers</a></td>
            <td>Custom headers with a simple response (see raw response using curl)</td>
            <td><a href="/personas/default/headers.txt" target="_blank">headers.txt</a></td>
            <td><a href="/personas/default/headers.cfg" target="_blank">headers.cfg</a></td>
        </tr>

        <tr>
            <td><a href="/delay" target="_blank">Delay</a></td>
            <td>Response is delayed by 5 seconds  (to simulate slow connection, testing client timeouts)</td>
            <td><a href="/personas/default/delay.txt" target="_blank">delay.txt</a></td>
            <td><a href="/personas/default/delay.cfg" target="_blank">delay.cfg</a></td>
        </tr>

        <tr>
            <td><a href="/redirect" target="_blank">Redirect</a></td>
            <td>Redirect via a 302 to http://www.google.com.  No content needed.</td>
            <td>n/a</td>
            <td><a href="/personas/default/redirect.cfg" target="_blank">redirect.cfg</a></td>
        </tr>

        <tr>
            <td><a href="/pdfinline" target="_blank">Inline PDF</a></td>
            <td>Inline PDF rendered in the browser</td>
            <td><a href="/personas/default/AdobeXMLFormsSamples.pdf" target="_blank">AdobeXMLFormsSamples.pdf</a></td>
            <td><a href="/personas/default/pdfinline.cfg" target="_blank">pdfinline.cfg</a></td>
        </tr>

        <tr>
            <td><a href="/pdfdownload" target="_blank">Download PDF</a></td>
            <td>PDF download via Content-Disposition header to the browser</td>
            <td><a href="/personas/default/AdobeXMLFormsSamples.pdf" target="_blank">AdobeXMLFormsSamples.pdf</a></td>
            <td><a href="/personas/default/pdfdownload.cfg" target="_blank">pdfdownload.cfg</a></td>
        </tr>

        <tr>
            <td><a href="/html" target="_blank">HTML content</a></td>
            <td>Simple HTML response</td>
            <td><a href="/personas/default/html.html" target="_blank">html.html</a></td>
            <td><a href="/personas/default/html.cfg" target="_blank">html.cfg</a></td>
        </tr>

        <tr>
            <td><a href="/xml" target="_blank">XML content</a></td>
            <td>Simple XML response</td>
            <td><a href="/personas/default/xml.xml" target="_blank">xml.json</a></td>
            <td><a href="/personas/default/xml.cfg" target="_blank">xml.cfg</a></td>
        </tr>

        <tr>
            <td><a href="/json" target="_blank">JSON content</a></td>
            <td>Simple JSON response</td>
            <td><a href="/personas/default/json.json" target="_blank">json.json</a></td>
            <td><a href="/personas/default/json.cfg" target="_blank">json.cfg</a></td>
        </tr>

    </table>

    <h1>Simple personas</h1>

    <h2>News feed example</h2>

    <p>We have one news feed service that responds with world news.
    <ul>
        <li>When no user is logged in, the news feed will return world news.</li>
        <li>When a user logs in, the news feed will return localised news.</li>
        <li>Peter doesn't define a response data file, so the system falls-back to default</li>
    </ul>
    </p>

    <p>The persona is set in this instance because we provide an implementation of the <a href="https://github.com/JohnCrossley/PersonaMockServer/blob/master/src/main/java/com/jccworld/personamockserver/route/persona/LoginTest.java" target="_blank"><i>LoginTest</i></a> interface.</p>

    <div class="outer">
        <div class="inner">
            <div class="innerLarge"><a href="/news" target="_blank">Get news</a></div>

            <div class="innerSmall">
                <input type="submit" value="Login as Brian" onclick="javascript:execUrl('/login?username=brian&password=password123');" /><br />
                <i>London</i> (<a href="/personas/brian/news.html" target="_blank"><b>brian</b>/news.html</a>)
            </div>
            <div class="innerSmall">
                <input type="submit" value="Login as Sally" onclick="javascript:execUrl('/login?username=sally&password=password123');" /><br />
                <i>Chicago</i> (<a href="/personas/sally/news.html" target="_blank"><b>sally</b>/news.html</a>)
            </div>
            <div class="innerSmall">
                <input type="submit" value="Login as Peter" onclick="javascript:execUrl('/login?username=peter&password=password123');" /><br />
                <i>world news</i> (<a href="/personas/default/news.html" target="_blank"><b>default</b>/news.html</a>)
            </div>

            <div class="innerLarge"><input type="submit" value="Logout" onclick="javascript:execUrl('/logout');" /></div>
        </div>
    </div>

    <h1>Custom responders</h1>
    <p>These are implementations of the <a href="https://github.com/JohnCrossley/PersonaMockServer/blob/master/src/main/java/com/jccworld/personamockserver/challenge/Challenge.java" target="_blank"><i>Challenge</i></a> interface.  These are used when the response will change based on the request.  I.e. a header or GET/POST parameter.</p>
    <ul>
        <li><a href="/challenge?type=simple" target="_blank">Simple</a> response (just content in files)</li>
        <li><a href="/challenge?type=pdfinline" target="_blank">Inline PDF</a> response (content and config in files)</li>
        <li><a href="/challenge?type=bespoke" target="_blank">All bespoke</a> response (all hardcoded)</li>
    </ul>

    <h1>Ways to change to persona being used</h1>

    <ul>
        <li><input type="submit" value="Login" onclick="javascript:execUrl('/login?username=persona_session&password=password123');" /> as user <i>persona_session</i></li>
        <li><input type="submit" value="Logout" onclick="javascript:execUrl('/logout');" /> from session<br /></li>

        <li><a href="/persona" target="_blank">Persona check</a> show persona (uses persona_session when logged in and default when logged out)</li>
        <li><a href="/persona?persona=persona_get" target="_blank">Override with GET</a> parameter</li>
        <li><a href="javascript:document.getElementById('personPostOverrideForm').submit();" >Override with POST</a> parameter</li>
        <li><a href="#" onclick="javascript:loginAndPost('/persona', null, 'persona_header', null);">Override with Header</a> parameter</li>
    </ul>

    <h1>Advanced concepts</h1>
    <p><a href="edgeCases.jsp">Edge cases, test coverage and error messages.</a>

    <!-- hidden components -->

    <!-- POST -->
    <form id="personPostOverrideForm" action="/persona" method="post" target="_blank">
        <input type="hidden" name="persona" value="persona_post" />
    </form>

</body>

</html>