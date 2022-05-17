package com.herbmall.member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.swing.plaf.synth.SynthOptionPaneUI;

import com.herbmall.db.ConnectionPoolMgr2;

public class MemberDAO {
	private ConnectionPoolMgr2 pool;
	
	public MemberDAO(){
		pool=new ConnectionPoolMgr2();
	}
	
	public int insertMember(MemberVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="insert into Member(no,userid,name,pwd,email,hp,zipcode,"
					+ " address,addressDetail)"
					+ " values(member_seq.nextval,?,?,?,?,?,?,?,?)";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getUserid());
			ps.setString(2, vo.getName());
			ps.setString(3, vo.getPwd());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getHp());
			ps.setString(6, vo.getZipcode());
			ps.setString(7, vo.getAddress());
			ps.setString(8, vo.getAddressDetail());

			
			int cnt=ps.executeUpdate();
			System.out.println("회원가입 결과 cnt"+cnt+", 매개변수 vo="+vo);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public int duplicateId(String userid) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		int result=0;
		try {
			con=pool.getConnection();
			
			String sql="select count(*) from member where userid=? ";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, userid);
			
			rs=ps.executeQuery();
			
			if(rs.next()) {
				int count=rs.getInt(1);
				if(count> 0) {
					result=MemberService.UNUSABLE_ID;//이미존재, 사용불가
				}else {
					result=MemberService.USABLE_ID;//사용가능
				}
			}
			
			System.out.println("아이디 중복확인 결과 result="+result+
					", 매개변수 userid="+userid);
			return result;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public int checkLogin(String userid, String pwd) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		int result=0;
		try {
			con=pool.getConnection();
			String sql="select pwd from member where userid=? and outdate is null";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, userid);
			
			
			//4
			rs=ps.executeQuery();
			if(rs.next()) {
				String dbPwd=rs.getString(1);
				
				if(dbPwd.equals(pwd)) {
					result=MemberService.LOGIN_OK;
				}else{
					result=MemberService.DISAGREE_PWD;
				}
			}else{
				result=MemberService.NONDE_USERID;
			}
			System.out.println("로그인 체크 결과 result="+result
					+", 매개변수 userid="+userid+", pwd="+pwd);
			return result;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public MemberVO selectByUserid(String userid) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs =null;
		
		MemberVO vo = null;
		try {
			con=pool.getConnection();
			
			String sql="select * from member where userid=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs=ps.executeQuery();
			if(rs.next()) {
				 int no = rs.getInt("no");
		         userid=rs.getString("userid");
		         String name = rs.getString("name");
		         String pwd = rs.getString("pwd");
		         String email = rs.getString("email");
		         String hp = rs.getString("hp");
		         String zipcode = rs.getString("zipcode");
		         String address = rs.getString("address");
		         String addressDetail = rs.getString("addressDetail");
		         Timestamp regdate = rs.getTimestamp("regdate");
		         int mileage = rs.getInt("mileage");
		         Timestamp outdate = rs.getTimestamp("outdate");
		         
		         vo=new MemberVO(no, userid, name, pwd, email, hp, zipcode, address, addressDetail, regdate, mileage, outdate);
			}
			System.out.println("아이디로 조회결과 vo="+vo+"매개변수 userid="+userid);
				return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public int updateMember(MemberVO vo) throws SQLException {
		Connection con =null;
		PreparedStatement ps =null;
		
		try {
			con=pool.getConnection();
			
			String sql="update member "
					+ " set zipcode=?, address=?, addressDetail=?,hp=? ,email=? "
					+ " where userid=?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getZipcode());
			ps.setString(2, vo.getAddress());
			ps.setString(3, vo.getAddressDetail());
			ps.setString(4, vo.getHp());
			ps.setString(5, vo.getEmail());
			ps.setString(6, vo.getUserid());
			
			int cnt=ps.executeUpdate();
			System.out.println("업데이트 결과 cnt ="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public int updateOutdate(String userid, String pwd) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		try {
			con=pool.getConnection();
			
			String sql="update member"
					+ " set outdate=sysdate"
					+ " where userid=? and pwd=? and outdate is null";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, userid);
			ps.setString(2, pwd);
		
			int cnt=ps.executeUpdate();
			
			System.out.println("회원 탈퇴 결과 cnt="+cnt+"매개변수 userid="+userid+", pwd="+pwd);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
}
