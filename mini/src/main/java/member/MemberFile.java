package member;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

public class MemberFile {
	private static MemberFile instance = new MemberFile();
	
	public static MemberFile getInstance() {
		return instance;
	}
	
	private MemberFile() {}
	
	private String saveDirectory = "C:\\upload";
	private final int maxPostSize = 1024 * 1024 * 50;
	private final String encoding = "UTF-8";
	private final FileRenamePolicy policy = new DefaultFileRenamePolicy();
	
	public MemberDTO getDTO(HttpServletRequest request) throws IOException {
		MemberDTO dto = null;
		
		MultipartRequest mpRequest = new MultipartRequest(
				request, saveDirectory, maxPostSize, encoding, policy
		);
		
		dto = new MemberDTO();
		
		dto.setGender(mpRequest.getParameter("gender"));
		dto.setNickname(mpRequest.getParameter("nickname"));
		dto.setProfile_img(mpRequest.getFile("profile_img").getName());
		dto.setUserid(mpRequest.getParameter("userid"));
		dto.setUserpw(mpRequest.getParameter("userpw"));
		
		return dto;
	}
}
