<html>

<head>
    <title>Persona Mock Server</title>
    <script src="/content/ajax.js" type="text/javascript"></script>
</head>

<body>
    <h1>Edge cases</h1>

    <h4>Please note POST and GET params are read right to left.  The idea is if you have an client that you
    can't/don't want to change, you can just append an extra header argument to override the previous value.
    I.e. example.com?persona=a&persona=b - b will be checked for availability before a is checked.</h4>

    <table border=1>
        <tr>
            <th>POST</th>
            <th>GET</th>
            <th>Header</th>
            <th>Session</th>
            <th>Default</th>
            <th>Expected</th>
            <th>Try it</th>
        </tr>
        <tr>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use POST</td>
            <td><a href="javascript:loginAndPost('/persona?persona=persona_get', 'persona=persona_post', 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td></td>
            <td>ok</td>
            <td></td>
            <td></td>
            <td></td>
            <td>Use GET</td>
            <td><a href="javascript:loginAndPost('/persona?persona=persona_get', null, null, null);">Try it</td>
        </tr>

        <tr>
            <td></td>
            <td></td>
            <td>ok</td>
            <td></td>
            <td></td>
            <td>Use Header</td>
            <td><a href="javascript:loginAndPost('/persona', null, 'persona_header', null);">Try it</td>
        </tr>

        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td>ok</td>
            <td></td>
            <td>Use Session</td>
            <td><a href="javascript:loginAndPost('/persona', null, null, 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>ok</td>
            <td>Use default</td>
            <td><a href="javascript:loginAndPost('/persona', null, null, null);">Try it</td>
        </tr>

        <tr>
            <td></td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use GET</td>
            <td><a href="javascript:loginAndPost('/persona?persona=persona_get',  null, 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td></td>
            <td></td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use Header</td>
            <td><a href="javascript:loginAndPost('/persona',  null, 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td>ok</td>
            <td>ok</td>
            <td>Use Session</td>
            <td><a href="javascript:loginAndPost('/persona',  null, null, 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td>[1] ok, [2] ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use POST [2]</td>
            <td><a href="javascript:loginAndPost('/persona?persona=persona_get', 'persona=sally&persona=persona_post', 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td>[1] ok, [2] bad</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use POST [1]</td>
            <td><a href="javascript:loginAndPost('/persona?persona=persona_get', 'persona=persona_post&persona=bad', 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td>[1] bad, [2] ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use POST [2]</td>
            <td><a href="javascript:loginAndPost('/persona?persona=persona_get', 'persona=bad&persona=persona_post', 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td>[1] bad, [2] bad</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use GET</td>
            <td><a href="javascript:loginAndPost('/persona?persona=persona_get', 'persona=bad1&persona=bad2', 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td>bad</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use GET</td>
            <td><a href="javascript:loginAndPost('/persona?persona=persona_get', 'persona=bad', 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td>bad</td>
            <td>[1] ok, [2] ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use GET [2]</td>
            <td><a href="javascript:loginAndPost('/persona?persona=brian&persona=persona_get', 'persona=bad', 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td>bad</td>
            <td>[1] ok, [2] bad</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use GET [1]</td>
            <td><a href="javascript:loginAndPost('/persona?persona=persona_get&persona=bad2', 'persona=bad', 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

         <tr>
            <td>bad</td>
            <td>[1] bad, [2] ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use GET [2]</td>
            <td><a href="javascript:loginAndPost('/persona?persona=bad1&persona=persona_get', 'persona=bad', 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td>bad</td>
            <td>[1] bad, [2] bad</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use Header</td>
            <td><a href="javascript:loginAndPost('/persona?persona=bad', 'persona=bad1&persona=bad2', 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td>bad</td>
            <td>bad</td>
            <td>ok</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use Header</td>
            <td><a href="javascript:loginAndPost('/persona?persona=bad', 'persona=bad', 'persona_header', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td>bad</td>
            <td>bad</td>
            <td>bad</td>
            <td>ok</td>
            <td>ok</td>
            <td>Use Session</td>
            <td><a href="javascript:loginAndPost('/persona?persona=bad', 'persona=bad', 'persona_bad', 'username=persona_session&password=password123');">Try it</td>
        </tr>

        <tr>
            <td>bad</td>
            <td>bad</td>
            <td>bad</td>
            <td>bad</td>
            <td>ok</td>
            <td>Use default</td>
            <td><a href="javascript:loginAndPost('/persona?persona=bad', 'persona=bad', 'persona_bad', 'username=bad&password=bad');">Try it</td>
        </tr>

        <tr>
            <td>bad</td>
            <td>bad</td>
            <td>bad</td>
            <td>bad</td>
            <td>bad</td>
            <td>Report no default error #1</td>
            <td><a href="javascript:loginAndPost('/personaNoDefault?persona=bad', 'persona=bad', 'persona_bad', 'username=bad&password=bad');">Try it</td>
        </tr>

        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>bad</td>
            <td>Report no default error #2</td>
            <td><a href="javascript:loginAndPost('/personaNoDefault', null, null, 'username=bad&password=bad');">Try it</td>
        </tr>
    </table>

    <h1>Other errors</h1>

    <ul>
        <li><a href="/thisDoesNotExist" target="_blank">Unmapped route</a>: Error message shows as the route is not registered.  Caught by the registered <i>CatchAll</i></li>
        <li><a href="/personas/default/simple.txt" target="_blank">Mapped ignoredPath</a>: This is not a route, but provided to <i>CatchAll</i> as an <i>ignoredPath</i>.</li>
        <li>Broken custom challenge error messages:
            <ol>
                <li><a href="/brokenCustomChallenge?die=exception" target="_blank">Logic error</a>: exception is caught and shown.</li>
                <li><a href="/brokenCustomChallenge?die=null" target="_blank">Returns null</a>: error message is shown because it should return a CustomResponse.</li>
                <li><a href="/brokenCustomChallenge?die=wrongInstance" target="_blank">Unsupported CustomResponse class</a>: error message is shown.</li>
            </ol>
        </li>
        <li><a href="/badConfig" target="_blank">Bad config</a>: Not a valid JSON format.</li>
    </ul>

</body>

</html>