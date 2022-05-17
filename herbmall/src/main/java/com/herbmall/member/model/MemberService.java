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
   
   //로그인 체크에서 사용하는 상수
   public static final int LOGIN_OK=1; //로그인 성공
   public static final int DISAGREE_PWD=2; //비밀번호 불일치
   public static final int NONDE_USERID=3; //해당 아이디 존재 하지 않음
   
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
   public int checkLogin(String userid, String pwd) throws SQLException {
	   return memberDao.checkLogin(userid, pwd);
	   
   }
   
   public MemberVO selectByUserid(String userid) throws SQLException {
	   return memberDao.selectByUserid(userid);
   }
   public int updateMember(MemberVO vo) throws SQLException {
	   return memberDao.updateMember(vo);
   }
   
   public int updateOutdate(String userid, String pwd) throws SQLException {
	   return memberDao.updateOutdate(userid, pwd);
   }
}