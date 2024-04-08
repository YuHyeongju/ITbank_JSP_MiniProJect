package member;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

public class MemberFileUtil {
	private static MemberFileUtil instance = new MemberFileUtil();
	
	public static MemberFileUtil getInstance() {
		return instance;
	}
	
	private MemberFileUtil() {
		
	}
	
	private final String saveDirectory ="C:\\upload";
	private final int maxPostSize = 1024 * 1024 * 50;
	private final String encoding="UTF-8";
	private final FileRenamePolicy policy = new DefaultFileRenamePolicy();
	
	public MemberDTO getDTO(HttpServletRequest request) throws IOException {
		MemberDTO dto = new MemberDTO();
		MultipartRequest mpRequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding
				, policy);
		File uploadFile  = mpRequest.getFile("uploadFile");
		if(uploadFile != null) {
			dto.setProfile_img(uploadFile.getName());	
		}
		if(uploadFile == null) {
			dto.setProfile_img("default.png");
		}
		dto.setUserid(mpRequest.getParameter("userid"));
		dto.setUserpw(mpRequest.getParameter("userpw"));
		dto.setNickname(mpRequest.getParameter("nickname"));
		dto.setEmail(mpRequest.getParameter("email"));
		dto.setGender(mpRequest.getParameter("gender"));
		return dto;
	}
}
