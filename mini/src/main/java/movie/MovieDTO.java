package movie;

import java.sql.Date;

//	이름           널?       유형             
//	------------ -------- -------------- 
//	IDX          NOT NULL NUMBER         
//	NAME         NOT NULL VARCHAR2(100)  
//	GENRE        NOT NULL VARCHAR2(100)  
//	RELEASE_DATE          DATE           
//	PLAYTIME     NOT NULL NUMBER         
//	CONTENT      NOT NULL VARCHAR2(4000) 
//	CASTING      NOT NULL VARCHAR2(500)  
//	MOVIE_IMG             VARCHAR2(100)  

public class MovieDTO {
	private int idx;
	private String name;
	private String genre;
	private Date release_date;
	private int playtime;
	private String content;
	private String casting;
	private String movie_img;
	private String trailer;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public Date getRelease_date() {
		return release_date;
	}
	public void setRelease_date(Date release_date) {
		this.release_date = release_date;
	}
	public int getPlaytime() {
		return playtime;
	}
	public void setPlaytime(int playtime) {
		this.playtime = playtime;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCasting() {
		return casting;
	}
	public void setCasting(String casting) {
		this.casting = casting;
	}
	public String getMovie_img() {
		return movie_img;
	}
	public void setMovie_img(String movie_img) {
		this.movie_img = movie_img;
	}
	public String getTrailer() {
		return trailer;
	}
	public void setTrailer(String trailer) {
		this.trailer = trailer;
	}
	
	
}
