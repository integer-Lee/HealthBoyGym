package com.project.boot.controller;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.project.boot.service.CommentService;
import com.project.boot.vo.CommentVO;

@Controller
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	
	@ResponseBody
	@RequestMapping(value = "/comment/save.do")
	public Map<String, Object> saveComment(@RequestBody CommentVO commetVO) throws Exception {
		System.out.println("댓글작성 컨트롤러 : " + commetVO);
		Map<String, Object> map = commentService.insertComment(commetVO);
		
		return map;
	}
}
