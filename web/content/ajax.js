function createHtmlHttpRequest() {
    // Attempt to create the XHR2 object
    var xhr;
    try {
        xhr = new XMLHttpRequest();
    } catch (e){
        try {
            xhr = new XDomainRequest();
        } catch(e) {
            try{
                xhr = new ActiveXObject('Msxml2.XMLHTTP');
            } catch(e) {
                try{
                    xhr = new ActiveXObject('Microsoft.XMLHTTP');
                } catch(e) {
                    statusField('\nYour browser is not' +
                        ' compatible with XHR2');
                }
            }
        }
    }
    return xhr;
}

function execUrl(path){
    var xhr = createHtmlHttpRequest();

    xhr.open('POST', path, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            alert("Done");
        }
    };

    xhr.send();
}

function loginThen(loginPostBody, callback) {
    var xhrLogin = createHtmlHttpRequest();

    xhrLogin.open('POST', '/login', true);

    if (loginPostBody != null) {
        xhrLogin.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhrLogin.setRequestHeader("Content-length", loginPostBody.length);
        xhrLogin.setRequestHeader("Connection", "close");
    }

    xhrLogin.onreadystatechange = callback;

    xhrLogin.send(loginPostBody);
}

function loginAndPost(pathWithGet, postBody, header, loginPostBody) {
    loginThen(loginPostBody, function() {
        if (this.readyState != 4) {
            return;
        }

        var xhr = createHtmlHttpRequest();

        xhr.open('POST', pathWithGet, true);

        if (header != null) {
            xhr.setRequestHeader("persona", header);
        }

        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4) {
                var getWithoutPath = null;
                if (pathWithGet.indexOf('?') >= 0) {
                    getWithoutPath = pathWithGet.substring(pathWithGet.indexOf('?') + 1);
                }

                alert("Request:\n" +
                " * P: " + postBody + "\n" +
                " * G: " + getWithoutPath + "\n" +
                " * H: " + header + "\n" +
                " * L: " + loginPostBody + "\n" +
                "Response:\n" + xhr.responseText);
            }
        };

        if (postBody != null) {
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.setRequestHeader("Content-length", postBody.length);
            xhr.setRequestHeader("Connection", "close");

            xhr.send(postBody);
        } else {
            xhr.send();
        }
    });
}

function simpleGet(path){
    var xhr = createHtmlHttpRequest();

    xhr.open('GET', path, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            alert("Request:\n" +
                  " * Path: " + path + "\n" +
                  "Response:\n" + xhr.responseText);
        }
    };

    xhr.send();
}
