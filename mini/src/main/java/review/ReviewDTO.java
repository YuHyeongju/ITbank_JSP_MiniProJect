package review;

import java.sql.Date;

public class ReviewDTO {
	private int idx;
	private String writer;
	private String title;
	private String content;
	private Date writeDate;
	private int viewCount;
	private int deleted;
	private String review_img;

	public int getDeleted() {
		return deleted;
	}

	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public String getReview_img() {
		return review_img;
	}

	public void setReview_img(String review_img) {
		this.review_img = review_img;
	}

}
