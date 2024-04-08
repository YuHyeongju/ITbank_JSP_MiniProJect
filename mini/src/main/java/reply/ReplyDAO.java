package reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class ReplyDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Context init;
	private DataSource ds;
	
	private static ReplyDAO instance = new ReplyDAO();
	
	public static ReplyDAO getInstance() {
		return instance;
	}
	
	public ReplyDAO() {
		try {
			init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
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
	public ReplyDTO mapping(ResultSet rs) throws SQLException {
	
			ReplyDTO  dto = new ReplyDTO ();
			dto.setIdx(rs.getInt("idx"));
			dto.setWriter(rs.getString("writer"));
			dto.setBoard_idx(rs.getInt("board_idx"));
			dto.setContent(rs.getString("content"));
			dto.setWriteDate(rs.getDate("writeDate"));
			return dto;
		
	}
	// 댓글 불러오기
	public ArrayList<ReplyDTO> selectReplyList(int board_idx){
		ArrayList<ReplyDTO> list = new ArrayList<>();
		String sql = "select * from reply where board_idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(mapping(rs));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return list;
	}
	// 내가 쓴 댓글 불러오기
	public ArrayList<ReplyDTO> selectReplyListALL(String writer){
		ArrayList<ReplyDTO> list = new ArrayList<>();
		String sql = "select * from reply where writer = ? order by writedate desc "
				+ "offset 0 rows "
				+ "fetch next 5 rows only";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(mapping(rs));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return list;
	}
	//내가 쓴 글의 리뷰 갯수 불러오기
	public int selectReviewCount(String search) {
		int count = 0;
		
		String sql = "select count(*) from review "
				+ "where title like '%' || ? || '%' or "
				+ "writer like '%' || ? || '%' or "
				+ "content like '%' || ? || '%' ";		
		try {
			conn =ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,search);
			pstmt.setString(2,search);
			pstmt.setString(3,search);
			rs = pstmt.executeQuery();		
			while(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return count;
	}
	// 댓글 추가
	public int insertReply(ReplyDTO dto) {
		int row = 0;
		String sql = "insert into reply (writer,content,board_idx) values(?,?,?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getWriter());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getBoard_idx());
			row = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return row;
	}
	//댓글 삭제
	public int deleteReply(int idx) {
		int row = 0;
		String sql = "delete from reply where idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			row = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			close();
		}
		return row;
	}
	
}
