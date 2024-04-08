 package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import movie.MovieDTO;

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Context init;
	private DataSource ds;
	
	private MemberDAO() {
		try {
			init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/oracle");
			
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public static MemberDAO getInstance() {
		return instance;
	}
	
	private void close() {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	private MemberDTO mapping(ResultSet rs) throws SQLException {
		MemberDTO dto = new MemberDTO();
		
		dto.setGender(rs.getString("gender"));
		dto.setNickname(rs.getString("nickname"));
		dto.setEmail(rs.getString("email"));
		dto.setProfile_img(rs.getString("profile_img"));
		dto.setUserid(rs.getString("userid"));
		dto.setUserpw(rs.getString("userpw"));
		
		return dto;
	}
	
	// 회원가입
	public int insert(MemberDTO dto) {
		int row = 0;
		String sql = "insert into member(userid, userpw, nickname, email, gender) values(?, ?, ?, ?, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getUserpw());
			pstmt.setString(3, dto.getNickname());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getGender());
			
			row = pstmt.executeUpdate();
			
		} catch (SQLException e) {
	
			e.printStackTrace();
		} finally { close(); }
		
		return row;
	}
	
	// 아이디 중복체크
	public MemberDTO check(String userid) {
		MemberDTO dto = null;
		String sql = "select * from member where userid = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dto = mapping(rs);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		
		return dto;
	}
	
	// 로그인
	public MemberDTO login(MemberDTO dto) {
		MemberDTO login = null;
		String sql = "select * from member where userid = ? and userpw = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getUserpw());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				login = mapping(rs);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { close(); }
		
		
		return login;
	}
	
	// 탈퇴
	public int withdraw(MemberDTO dto) {
		int row = 0;
		String sql = "delete from member where userid = ? and userpw = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getUserpw());
			row = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		
		return row;
	}
	
	// 정보 수정
	public int modify(MemberDTO dto) {
		int row = 0;
		String sql = "update member set"
				+ "		userpw = ?,"
				+ "		nickname = ?,"
				+ "		email = ?,"
				+ "		gender = ?,"
				+ "		profile_img = ?"
				+ "	 where userid = ?";		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserpw());
			pstmt.setString(2, dto.getNickname());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getGender());
			pstmt.setString(5, dto.getProfile_img());
			pstmt.setString(6, dto.getUserid());
			row = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return row;
		
	}
	

	
}
