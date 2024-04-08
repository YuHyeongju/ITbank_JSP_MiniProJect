package star;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class StarDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Context init;
	private DataSource ds;
	
	private static StarDAO instance = new StarDAO();
	
	private StarDAO() {
		try {
			init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/oracle");
			
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public static StarDAO getInstance() {
		return instance;
	}
	
	public void close() {
		try {
 			if(rs != null) rs.close();
 			if(pstmt != null) pstmt.close();
 			if(conn != null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 별점을 이미 준 상태인지 확인하는 메서드
	public StarDTO hasStar(StarDTO dto) {
		StarDTO record = null;
		String sql = "select * from movie_star where userid = ? and movie_idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setInt(2, dto.getMovie_idx());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				record = new StarDTO();
				record.setUserid(rs.getString("userid"));
				record.setMovie_idx(rs.getInt("movie_idx"));
				record.setScore(rs.getInt("stars"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return record;
	}
	
	// 별점을 넣어주는 메서드
	public int insertStar(StarDTO dto) {
		int row = 0;
		String sql = "insert into movie_star values(?, ?, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setInt(2, dto.getMovie_idx());
			pstmt.setInt(3, dto.getScore());
			row = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close();}
		
		return row;
	}
	
	// 별점이 이미 존재할 때 별점을 다시 줬을 시 별점을 변경하는 메서드
	public int updateStar(StarDTO dto) {
		int row = 0;
		String sql = "update movie_star set stars = ? where userid = ? and movie_idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getScore());
			pstmt.setString(2, dto.getUserid());
			pstmt.setInt(3, dto.getMovie_idx());
			row = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close();}
		
		return row;
	}
	
	// 영화 별점 가져오기
	public double getStarScore(int movie_idx) {
		double score = 0;
		String sql = "select avg(stars) from movie_star where movie_idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setDouble(1, movie_idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				score = rs.getDouble(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }

		String result = String.valueOf(score);	
		result = result.substring(0, 3);
		
		return Double.valueOf(result);
	}
}
