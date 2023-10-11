package com.project.boot.dao;

import org.apache.ibatis.annotations.Mapper;
import com.project.boot.vo.MemberVO;

@Mapper
public interface MemberDAO {
//    List<MemberVO> getMemberList();		   //Read
    public int isExistUid(MemberVO memberVo);
    public int join(MemberVO memberVo);		   //Create
    public int delete(MemberVO memberVo);	   //Delete
    public boolean update(MemberVO memberVo);	   //Update
    public MemberVO loginMember(MemberVO memberVo); //login
}
