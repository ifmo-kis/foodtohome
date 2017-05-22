package ru.ifmo.erp.foodtohome.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collections;
import java.util.Map;

/**
 * Created by nick on 20.05.17.
 */
@Controller
@RequestMapping(value = "/test")
public class IndexController {
    @RequestMapping(value = "/test")
    @ResponseBody
    public Map<String, String> test () {
        return Collections.singletonMap("Test", "Test");
    }

    @RequestMapping(value = "/")
    public String index () {
        return "index";
    }
}
