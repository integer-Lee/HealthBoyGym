package com.project.boot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HelloController {
//	@ResponseBody 
//	@RequestMapping("/")
//	public String hello() {
//		return "Hello World";
//	}
	
	@GetMapping("/hello")
	public String hello2() {
		return "hello";
	}
}
