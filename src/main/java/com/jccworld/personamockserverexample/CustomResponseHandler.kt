package com.jccworld.personamockserverexample

import com.google.gson.Gson
import com.jccworld.personamockserver.PersonaDataFilePicker
import com.jccworld.personamockserver.Route
import com.jccworld.personamockserver.persona.PersonaExtractor
import com.jccworld.personamockserver.responsehandler.ResponseHandler
import java.util.stream.Collectors
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class CustomResponseHandler : ResponseHandler {

    private val validEmailRefex = "(?:[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    private val gson = Gson()

    override fun dispatch(personaDataFilePicker: PersonaDataFilePicker, personaExtractor: PersonaExtractor, route: Route, request: HttpServletRequest, response: HttpServletResponse) {
        val requestBody = request.reader.lines().collect(Collectors.joining(System.lineSeparator()))
        val profileRequest = gson.fromJson<ProfileRequest>(requestBody, ProfileRequest::class.java)

        response.writer.apply {
            write(
                    when (validEmailRefex.toRegex().matches(profileRequest.email)) {
                        true -> "Great, thanks"
                        false -> "e-mail is not valid"
                    }
            )
        }
    }
}

data class ProfileRequest(val email: String)