package com.herbmall.member.model;

import java.sql.SQLException;

//DB작업 이외의 로직을 담는 클래스
/*
 jsp ->DAO
 jsp -> Service -> DAO 
 */
public class MemberService {
   //아이디 중복확인에서 사용하는 상수
   public static final int USABLE_ID=1; //사용가능한 아이디
   public static final int UNUSABLE_ID=2; //이미 존재해서 사용불가능한 아이디
   
   private MemberDAO memberDao;
   
   public MemberService() {
      memberDao=new MemberDAO();
   }
   
   
   public int insertMember(MemberVO vo) throws SQLException {
      int cnt=memberDao.insertMember(vo);
      return cnt;
      
   }
   
   public int duplicateId(String userid) throws SQLException {
      return memberDao.duplicateId(userid);
      
   }
}