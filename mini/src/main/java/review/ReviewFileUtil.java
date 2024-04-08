package review;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

public class ReviewFileUtil {
	private static ReviewFileUtil instance = new ReviewFileUtil();
	
	public static ReviewFileUtil getInstance() {
		return instance;
	}
	
	private ReviewFileUtil() {
		
	}
	
	private final String saveDirectory ="C:\\upload";
	private final int maxPostSize = 1024 * 1024 * 50;
	private final String encoding="UTF-8";
	private final FileRenamePolicy policy = new DefaultFileRenamePolicy();
	
	public ReviewDTO getDTO(HttpServletRequest request) throws IOException {
		ReviewDTO dto = new ReviewDTO();
		MultipartRequest mpRequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding
				, policy);
		File uploadFile  = mpRequest.getFile("uploadFile");
		if(uploadFile != null) {
			dto.setReview_img(uploadFile.getName());
			
		}
		//String idx = mpRequest.getParameter("idx"); // 파라미터로 받아야되기 떄문에 문자열로 받아와서
		//dto.setIdx(Integer.parseInt(idx));			// 정수형으로 변환
		dto.setWriter(mpRequest.getParameter("writer"));
		dto.setTitle(mpRequest.getParameter("title"));
		dto.setContent(mpRequest.getParameter("content"));
		
		return dto;
	}
	
	public void deleteFile(String fileName) {
		File f = new File(saveDirectory, fileName);
		
		if(f.exists()) {
			f.delete();
		}
	}
}
