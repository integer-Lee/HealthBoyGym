package com.project.boot.service;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.boot.dao.MemberDAO;
import com.project.boot.vo.MemberVO;


@Service
public class MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	
//    public List<MemberVO> getMemberList() throws Exception {
//        return memberDAO.getMemberList();
//    }
    
    public Map<String, Object> isExistUid(MemberVO memberVo) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	if ((memberDAO.isExistUid(memberVo)) > 0) {
    		// 이미 아이디가 존재한다면, true값을 전송.			
    		map.put("status", true);
    		map.put("message", "아이디가 사용 불가능 합니다");
		} else {
			map.put("status", false);
			map.put("message", "아이디가 사용가능합니다");
		}

    	return map;
    }

// insert
    public Map<String, Object> join(MemberVO member) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	if (memberDAO.join(member) > 0) {
    		map.put("status", true);
    		map.put("message", "회원 가입이 성공되었습니다");
		} else {
			map.put("status", false);
			map.put("message", "아이디 중복으로 회원 가입이 실패되었습니다");
		}
		return map;
    }
    
    public Map<String, Object> delete(MemberVO member) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	if (memberDAO.delete(member) != 0) {
//    		System.out.println("서비스 :" + memberDAO.delete(member)); 
    		map.put("status", true);
    		map.put("message", "회원 탈퇴가 성공되었습니다");
		} else {
			map.put("status", false);
			map.put("message", "회원 탈퇴가 실패되었습니다");
		}
		return map;
    }
    
    public Map<String, Object> update(MemberVO memberVo) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	if (memberDAO.update(memberVo)) {
    		map.put("status", true);
    		map.put("message", "회원 수정이 성공되었습니다");
		} else {
			map.put("status", false);
			map.put("message", "회원수정이 실패되었습니다");
		}
		return map;
    	
    }
    
    // 로그인 기능 메서드    
    public Map<String, Object> loginMember(MemberVO memberVo, HttpSession session) {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
		MemberVO loginMember = memberDAO.loginMember(memberVo);
		
		if (loginMember != null) {
			// session객체의 setAttribute메서드로 loginMember값을 보내주면 jsp에서 받아서 사용할 수 있다.			
			session.setAttribute("LoginMember", loginMember);
			System.out.println("서비스 : " + loginMember);
			resultMap.put("status", true);
			resultMap.put("message", "로그인 성공");
		} else {
			resultMap.put("status", false);
			resultMap.put("message", "아이디 또는 비밀번호를 확인해주세요 ");
		}
    	return resultMap;
    }
}
