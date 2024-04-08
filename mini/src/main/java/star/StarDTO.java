package star;

//	이름        널?       유형            
//	--------- -------- ------------- 
//	USERID             VARCHAR2(100) 
//	MOVIE_IDX          NUMBER        
//	SCORE     NOT NULL NUMBER        


public class StarDTO {
	private String userid;
	private int movie_idx;
	private int score;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getMovie_idx() {
		return movie_idx;
	}
	public void setMovie_idx(int movie_idx) {
		this.movie_idx = movie_idx;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	
	
}
