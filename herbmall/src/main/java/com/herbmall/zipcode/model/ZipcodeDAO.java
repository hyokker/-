package com.herbmall.zipcode.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.herbmall.db.ConnectionPoolMgr2;

public class ZipcodeDAO {
	private ConnectionPoolMgr2 pool;
	
	public ZipcodeDAO() {
		pool=new ConnectionPoolMgr2();
	}
	
	public List<ZipcodeVO> selectByAll(String dong) throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<ZipcodeVO> list=new ArrayList<ZipcodeVO>();
		try {
			//1,2
			con=pool.getConnection();
			
			String sql="select * from zipcode where dong like '%'||?||'%'";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, dong);
			
			rs=ps.executeQuery();
			while(rs.next()) {
				String zipcode=rs.getString("zipcode");
				String sido=rs.getString("sido");
				String gugun=rs.getString("gugun");
				dong=rs.getString("dong");
				String startbunji=rs.getString("startbunji");
				String endbunji=rs.getString("endbunji");
				int seq	=rs.getInt("seq");
				
				ZipcodeVO vo = new ZipcodeVO(zipcode, sido, gugun, dong, startbunji, endbunji, seq);
				
				list.add(vo);
			}
			System.out.println("선택한 우편번호 list.size()="+list.size()+", 매개변수 dong="+dong);
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
}
