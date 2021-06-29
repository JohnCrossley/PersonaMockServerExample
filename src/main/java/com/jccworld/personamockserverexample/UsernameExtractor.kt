package com.jccworld.personamockserverexample

import com.jccworld.personamockserver.Route
import com.jccworld.personamockserver.persona.PersonaExtractor
import com.jccworld.personamockserver.responsehandler.FileResponseHandler

import javax.servlet.http.HttpServletRequest

class UsernameExtractor : PersonaExtractor {
    val authTokensToUserNames = mapOf(
            "Basic aaaaaaaa" to "emily",
            "Basic bbbbbbbb" to "isla"
    )


    override fun extract(route: Route, httpServletRequest: HttpServletRequest): String? {
        return when(route.properties[FileResponseHandler.RESPONSE_HEADERS_KEY]) {
            "profile.headers" -> getFirstGroup(route, httpServletRequest.requestURI)
            "my_events.headers" -> authTokensToUserNames[httpServletRequest.getHeader("Authorization")]
            "redirect.headers" -> httpServletRequest.getParameter("id")
            else -> null
        }
    }

    private fun getFirstGroup(route: Route, path: String): String {
        val matcher = route.path.matcher(path)
        matcher.find()
        return matcher.group(1)
    }
}
