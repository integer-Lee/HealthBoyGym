package com.project.boot.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.project.boot.service.MemberService;
import com.project.boot.vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@ResponseBody
	@RequestMapping(value = "/member/join.do")
	public Map<String, Object> join(@RequestBody MemberVO member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("join()");
		System.out.println("member : " + member);

		Map<String, Object> resultMap = memberService.join(member);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/member/isExistUid.do")
	public Map<String, Object> isExistUid(@RequestBody MemberVO memberVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberController_isExistUid : " + memberVo.getUserid());
//	매개변수로 입력받은 uid(ID)가 이미 존재하는지 if문으로 확인한다. 	
		Map<String, Object> map = memberService.isExistUid(memberVo);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/member/login.do")
	public Map<String, Object> login(@RequestBody MemberVO memberVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		System.out.println("login() : " + memberVo.toString());
		Map<String, Object> resultMap = memberService.loginMember(memberVo, session);
		/*
		 * containsKey(주어진 키가 있는지 여부)메서드를 사용하기 위해서 equals와 hashcode메서들를 재정의해야 한다. 
		 * 클라이언트로받은 memberVo와 Map컬렉션의 키에 포함된 값이 일치하는지 확인하는 조건문이다.
		 */
		if (resultMap.containsKey("memberVo")) {
			//아래 코드의 memberVo는 서비스 메서드에서 생성된 MemberVO 객체를 나타낸다.		
			session.setAttribute("LoginMember", resultMap.get("memberVo"));
		}
		return resultMap;
	}

	@ResponseBody
	@RequestMapping(value="/member/logout.do")
	public Map<String, Object> logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		System.out.println("logout()");

		session.invalidate();

		map.put("status", true);
		map.put("message", "로그아웃 되었습니다");
		System.out.println("jsonResult.toString() : " + map.toString());

		return map;
	}

	@ResponseBody
	@RequestMapping(value="/member/update.do")
	public Map<String, Object> update(@RequestBody MemberVO member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("update()");
		System.out.println("수정된 회원정보 : " + member);
		
		Map<String, Object> map = memberService.update(member);
		HttpSession session = request.getSession();
		session.setAttribute("LoginMember", member);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/member/withdrawl.do")
	public Map<String, Object> withdrawl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		System.out.println("withdrawl()");
		MemberVO loginMember = (MemberVO) session.getAttribute("LoginMember");
		Map<String, Object> map = memberService.delete(loginMember);
		session.invalidate();
		
		return map;
	}
}
