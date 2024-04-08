package review;

public class ReviewPaging {
	private int page; 
	private int perPage; 
	private int reviewCount; 
	private int offset; 
	private int fetch; 

	private int pageCount; 
	private int section; 
	private boolean prev; 
	private boolean next; 
	private int begin; 
	private int end; 


	public static ReviewPaging newInstance(int page, int reviewCount) {
		return new ReviewPaging(page, reviewCount);
	}
	public static ReviewPaging newInstance(int page, int reviewCount, int seperator) {
		return new ReviewPaging(page, reviewCount, seperator);
	}

	private ReviewPaging(int page, int reviewCount) { 
		this.page = page;				
		this.reviewCount = reviewCount;	
		perPage = 10;				  
		offset = (page - 1) * perPage; 
		fetch = perPage;			  


		pageCount = reviewCount / perPage;		
		pageCount += (reviewCount % perPage != 0) ? 1 : 0;	
		section = (page - 1) / 10;				
												
		prev = section != 0;					
		next = pageCount > end;					  
		begin = section * 10 + 1;				
		end = begin + 9;						
		if (end > pageCount) {					
			end = pageCount;					
			next = false; 
		}
	}
	private ReviewPaging(int page, int reviewCount, int separtor) { 
		this.page = page;				
		this.reviewCount = reviewCount;	
		perPage = 16;				  
		offset = (page - 1) * perPage; 
		fetch = perPage;			  
		
		
		pageCount = reviewCount / perPage;		
		pageCount += (reviewCount % perPage != 0) ? 1 : 0;	
		section = (page - 1) / 10;				
		
		prev = section != 0;					
		next = pageCount > end;					  
		begin = section * 10 + 1;				
		end = begin + 9;						
		if (end > pageCount) {					
			end = pageCount;					
			next = false; 
		}
	}

	public int getBegin() {
		return begin;
	}

	public void setBegin(int begin) {
		this.begin = begin;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getFetch() {
		return fetch;
	}

	public void setFetch(int fetch) {
		this.fetch = fetch;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getSection() {
		return section;
	}

	public void setSection(int section) {
		this.section = section;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

}
