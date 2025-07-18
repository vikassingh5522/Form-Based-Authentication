package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

    @GetMapping("/public")
    @ResponseBody
    public String publicPage() {
        return "This is a public page!";
    }

    @GetMapping("/secured")
    public String securedPage() {
        return "secured"; // Maps to WEB-INF/views/secured.jsp
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login"; // Maps to WEB-INF/views/login.jsp
    }

    @GetMapping("/logout-success")
    public String logoutSuccess() {
        return "logout-success"; // Maps to WEB-INF/views/logout-success.jsp
    }

    @GetMapping("/test")
    @ResponseBody
    public String testPage() {
        return "This is a test page!";
    }
}
