package movie;

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

public class MovieDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Context init;
	private DataSource ds;
	
	private static MovieDAO instance = new MovieDAO();
	
	private MovieDAO() {
		try {
			init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/oracle");
			
		} catch (NamingException e) {

			e.printStackTrace();
		}
		
	}
	
	public static MovieDAO getInstance() {
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
	
	private MovieDTO mapping(ResultSet rs) throws SQLException {
		MovieDTO dto = new MovieDTO();
		
		dto.setCasting(rs.getString("casting"));
		dto.setContent(rs.getString("content"));
		dto.setGenre(rs.getString("genre"));
		dto.setIdx(rs.getInt("idx"));
		dto.setMovie_img(rs.getString("movie_img"));
		dto.setName(rs.getString("name"));
		dto.setPlaytime(rs.getInt("playtime"));
		dto.setRelease_date(rs.getDate("release_date"));
		dto.setTrailer(rs.getString("trailer"));
		
		return dto;
	}
	
	public ArrayList<String> selectTrailers() {
		ArrayList<String> list = new ArrayList<String>();
		String sql = "select trailer from movie order by release_date desc "
				+ "offset 0 rows "
				+ "fetch next 10 rows only";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString("trailer"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		
		return list;
	}

	public List<MovieDTO> selectRecentMovies() {
		ArrayList<MovieDTO> list = new ArrayList<MovieDTO>();
		String sql = "select * from movie order by release_date desc "
				+ "offset 0 rows "
				+ "fetch next 5 rows only";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(mapping(rs));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		
		return list;
		
	}
	
	public List<MovieDTO> selectMovies(String genre) {
		ArrayList<MovieDTO> list = new ArrayList<MovieDTO>();
		String sql = "select * from movie where genre = ? order by release_date desc "
				+ "offset 0 rows "
				+ "fetch next 5 rows only";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, genre);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(mapping(rs));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		
		
		return list;
	}
	
	public List<MovieDTO> selectMoviesBySearch(String search) {
		ArrayList<MovieDTO> list = new ArrayList<MovieDTO>();
		String sql = "select * from movie where name like '%' || ? || '%' "
				+ "or casting like '%' || ? || '%' "
				+ "order by name";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, search);
			pstmt.setString(2, search);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(mapping(rs));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		
		return list;
	}
	
	public List<MovieDTO> selectMoviesBySearchRecent(String search) {
		ArrayList<MovieDTO> list = new ArrayList<MovieDTO>();
		String sql = "select * from movie where name like '%' || ? || '%' "
				+ "or casting like '%' || ? || '%' "
				+ "order by release_date desc";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, search);
			pstmt.setString(2, search);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(mapping(rs));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		
		return list;
	}
	
	public List<MovieDTO> selectMoviesBySearchPop(String search) {
		ArrayList<MovieDTO> list = new ArrayList<MovieDTO>();
		String sql = "select movie.*, (select count(*) from movie_like where movie.idx = movie_like.movie_idx) as likecount "
				+ " from movie where name like '%' || ? || '%' "
				+ " or casting like '%' || ? || '%' "
				+ " order by likecount desc, name asc";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, search);
			pstmt.setString(2, search);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(mapping(rs));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		
		return list;
	}
	
	// 특정 유저가 좋아요한 영화 리스트(최근 9개만)
	public List<MovieDTO> selectLikeMovies(String userid) {
		ArrayList<MovieDTO> list = new ArrayList<MovieDTO>();
		String sql = "select movie.* from movie, movie_like where movie.idx = movie_like.movie_idx "
				+ " and userid = ? "
				+ " order by release_date desc "
				+ " offset 0 rows "
				+ " fetch next 9 rows only";
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
	
	// 좋아요한 영화 개수
	public int selectCount(String userid) {
		int count = 0;
		String sql = "select count(*) from movie_like where userid = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		
		return count;
	}
	
	
	public MovieDTO selectOne(int idx) {
		MovieDTO dto = null;
		String sql = "select * from movie where idx = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dto = mapping(rs);
			}
			
		} catch (SQLException e) {

			e.printStackTrace();
		} finally { close(); }
		
		
		return dto;
	}

	public int isLike(String userid, int movie_idx) {
		int row = 0;
		String sql = "select * from movie_like where userid = ? and movie_idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setInt(2, movie_idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				row++;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		
		return row;
	}
	
	public int pushLike(String userid, int movie_idx) {
		int row = 0;
		String sql = "insert into movie_like values(?, ?)";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setInt(2, movie_idx);
			row = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return row;
	}
	
	public int cancelLike(String userid, int movie_idx) {
		int row = 0;
		String sql = "delete from movie_like where userid = ? and movie_idx = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setInt(2, movie_idx);
			row = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		
		
		return row;
	}
	
	public int getLikeCount(int movie_idx) {
		int count = 0;
		String sql = "select count(*) from movie_like where movie_idx = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, movie_idx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { close(); }
		
		
		return count;
	}
}
