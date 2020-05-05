package controller.KMJ;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/aus")
public class ImageViewController {
	
									// 파일명 받아오기위해 정의하는 변수명
	@RequestMapping({"/userImg/{imagePath}","/userImg/"})
	@ResponseBody // 페이지 이동없이 로드
	public byte[] getImage(@PathVariable(required = false) String imagePath,HttpServletRequest req) throws IOException {
		
		String rpath = req.getSession().getServletContext().getRealPath("/resources/dist/img/user1-128x128.jpg");
		
		if(!StringUtils.isEmpty(imagePath) && !imagePath.equalsIgnoreCase("null")) {
			rpath = "d:\\item\\profile\\" + imagePath;
		}
		
		Path path = Paths.get(rpath);			 // 정의한 경로(문자열)를 경로(절대경로)로 읽어들임
		byte[] data = Files.readAllBytes(path);  // 절대경로에있는 파일을 byte로 읽어온다

		return data;
	}
	
	@RequestMapping(value = "/pofol_Img/{imagePath}")
	@ResponseBody // 페이지 이동없이 로드
	public byte[] getportfolioImage(@PathVariable String imagePath) throws IOException {
								//위에서 정의한 변수명을 갖고와서 사용
		String rpath = "d:\\item\\portfolio\\detail\\" + imagePath; // 파일명의 전체 경로를 정의(그냥 문자열)
		Path path = Paths.get(rpath);			 // 정의한 경로(문자열)를 경로(절대경로)로 읽어들임
		byte[] data = Files.readAllBytes(path);  // 절대경로에있는 파일을 byte로 읽어온다

		return data;
	}
}
