package com.socialnetwork.handshake.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import static com.socialnetwork.handshake.utils.StringUtils.isNullOrEmpty;

@RestController
@RequestMapping("api/v1")
public class HealthCheckController {

    private static final String ANSWER_TO = "answerTo";

    @GetMapping(value = "/health/check", produces = "text/plain;charset=UTF-8")
    public String checkHealth(@RequestParam(value = ANSWER_TO, required = false) String answerTo) {
        return "I'm ok" + (isNullOrEmpty(answerTo) ? "!" : (", " + answerTo + "!"));
    }

}