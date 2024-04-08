package review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReviewDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Context init;
	private DataSource ds;
	
	private static ReviewDAO instance = new ReviewDAO();
	
	public static ReviewDAO getInstance() {
		return instance;
	}
	
	public ReviewDAO() {
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
	public ReviewDTO mapping(ResultSet rs) throws SQLException {
	
			ReviewDTO  dto = new ReviewDTO ();
			dto.setIdx(rs.getInt("idx"));
			dto.setWriter(rs.getString("writer"));
			dto.setTitle(rs.getString("title"));
			dto.setWriteDate(rs.getDate("writeDate"));
			dto.setContent(rs.getString("content"));
			dto.setViewCount(rs.getInt("viewCount"));
			dto.setDeleted(rs.getInt("deleted"));
			dto.setReview_img(rs.getString("review_img"));
			return dto;
		
	}
	// 리뷰 전체 불러오기(검색 페이징)
	public ArrayList<ReviewDTO> selectList(String search, ReviewPaging paging){
		ArrayList<ReviewDTO> list = new ArrayList<>();
		String sql = "select * from review "
				+ "where "
				+ "	deleted = 0 and "
				+ " (title like '%' || ? || '%' or "
				+ "	writer like '%' || ? || '%' or "
				+ "	content	like '%' || ? || '%') "
				+ "order by idx desc "
				+ "offset ? rows "
				+ "fetch next ? rows only";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,search);
			pstmt.setString(2,search);
			pstmt.setString(3,search);
			pstmt.setInt(4,paging.getOffset());
			pstmt.setInt(5,paging.getFetch());
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
	// 리뷰 전체 불러오기
	public ArrayList<ReviewDTO> selectReviewListALL(String writer, ReviewPaging paging){
		ArrayList<ReviewDTO> list = new ArrayList<>();
		String sql = "select * from review "
				+ "where "
				+ "writer = ? "
				+ "order by idx desc "
				+ "offset ? rows "
				+ "fetch next ? rows only";
				
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setInt(2, paging.getOffset());
			pstmt.setInt(3, paging.getFetch());
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
	// 내가 작성한 리뷰 불러오기(5개만)
	public ArrayList<ReviewDTO> selectMyReviews(String userid) {
		ArrayList<ReviewDTO> list = new ArrayList<ReviewDTO>();
		String sql = "select * from review where writer = ? and deleted = 0 "
				+ "offset 0 rows "
				+ "fetch next 5 rows only";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(mapping(rs));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		return list;
	}
	// 리뷰 개수 불러오기
	public int selectCount(String search) {
		int count = 0;
		String sql = "select count(*) from review "
				+ "where "
				+ " 	deleted = 0 and "
				+ "		(title like '%' || ? || '%' or "
				+ "		writer like '%' || ? || '%' or "
				+ "		content like '%' || ? || '%') ";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, search);
			pstmt.setString(2, search);
			pstmt.setString(3, search);
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
	

	
	
	// 리뷰 단일 조회
	public ReviewDTO selectOne(int idx) {
		ReviewDTO dto  = null;
		String sql = "select * from review where idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dto = mapping(rs);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return dto;
	}
	
	// 리뷰 추가
	public int insert(ReviewDTO dto) {
		int row = 0;
		String sql = "insert into review (writer,title,review_img,content) values(?,?,?,?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getWriter());
			pstmt.setString(2,dto.getTitle());
			pstmt.setString(3, dto.getReview_img());
			pstmt.setString(4,dto.getContent());
			row = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return row;
	}
	//리뷰 삭제
	public int delete(int idx) {
		int row = 0;
		String sql = "update review set deleted = 1 - deleted where idx = ?";
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
	// 리뷰 수정
	public int modify(ReviewDTO dto, int idx) {
		int row = 0;
		String sql = "update review set "
				+ "		title = ?, "
				+ "		review_img = ?, "
				+ "		content = ? "
				+ "	 where idx = ?";		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getReview_img());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, idx);
		
			row = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return row;
		
	}
	//조회수 증가
	public int upViewCount(int idx) {
		int row = 0;
		String sql = "update review set viewCount = viewCount + 1 where idx = ?";
		try {
			conn = ds.getConnection();		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,idx);
			row = pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return row;
		
	}
	
}
