package controller.JHR;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dao.JEJ;
import interceptor.NoLoginCheck;

@Controller
@RequestMapping("/aus")
@NoLoginCheck
public class loginController {

	@Autowired
	private loginServiceImpl service;

	@Autowired
	   private JEJ service_jej;
	   
	   public void setService_jej(JEJ service_jej) {
	      this.service_jej = service_jej;
	   }
	   
	   @RequestMapping(value="/loginCheck",method=RequestMethod.POST)
	   public String loginCheck(@ModelAttribute MemberDTO dto, HttpSession session,Model m) {

	      MemberDTO result = service.loginCheck(dto);

	      if (result != null) {
	         
	         SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yyyy/MM/dd");
	         Date currentTime = new Date ();
	         String mTime = mSimpleDateFormat.format ( currentTime );
	         
	         
	         if (service_jej.countVisit(mTime) == 0) {
	         //오늘날짜가 없는 경우 insert
	         service_jej.insertVisit(mTime);
	         } else {
	         //오늘날짜가 있는 경우 update
	         service_jej.updateVisit(mTime);
	         }
	         
	         
	         session.setMaxInactiveInterval(60);
	         session.setAttribute("id", result.getId());
	         session.setAttribute("name", result.getName());
	         session.setAttribute("userphoto", result.getU_img());
	         
	         
	         
	         return "redirect:/aus/MyPageMain";
	      } else {
	         m.addAttribute("msg","아이디 또는 비밀번호가 맞지 않습니다.");
	         return "main";  
	      }

	   }
	   
	// 로그 아웃
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		service.logout(session);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/aus/main");
		// mav.addObject("msg","logout"); //메인화면으로 이동함
		return mav;
	}


	@RequestMapping(value="/Pw")
	public String Pw(HttpServletRequest req,@ModelAttribute MemberDTO dto,HttpSession session){
		
		System.out.print("pw = : " +dto);
		
		return "JHR/Pw";
	}  
        
	//회원 정보 페이지
	@RequestMapping(value="/mypage")
	public ModelAndView mypage(HttpServletRequest req,Model model,@ModelAttribute MemberDTO dto){
		
		String id = req.getSession().getAttribute("id").toString();
		boolean result = service.checkPw(id,dto.getPassword());
		ModelAndView mav = new ModelAndView();
		if(result == true) {
			MemberDTO dto1 = service.mypage(id);
			model.addAttribute("dto", dto1);
			mav.setViewName("JHR/mypage");
/*			mav.addObject("msg","success");
*/		}else {
			mav.addObject("message","비밀번호 불일치");
			mav.setViewName("redirect:/aus/Pw");
		}
		return mav;
	}

	// 회원 정보 업데이트
	@RequestMapping(value = "/memberUpdate")
    public String memberUpdate(@ModelAttribute MemberDTO dto,@RequestParam("file") MultipartFile file,Model model,HttpSession session){
		System.out.println(dto);
		if(!file.isEmpty()) {
			String path = "d://item//profile//";
			String f_name = file.getOriginalFilename();
			f_name = f_name.substring(0, f_name.indexOf("."));
			long now = System.currentTimeMillis();
			String new_name = now + "_" + f_name;
			File new_file = new File(path, new_name);
			try {
				file.transferTo(new_file);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			dto.setU_img(new_name);
			}else {
				dto.setU_img("");
			}
		service.memberUpdate(dto);
		
		session.setAttribute("userphoto", dto.getU_img());
		
		return "redirect:/aus/MyPageMain";
	}

	// 탈퇴 페이지
	@RequestMapping("/secession")
	public String secession() {
		return "JHR/secession";

	}

	// 회원 탈퇴
	@RequestMapping(value = "/secessionpro")
	public String deleteSecession(@RequestParam("pwd") String password, Model model, HttpSession session) {
		System.out.println("password : "+password);
		String id = (String) session.getAttribute("id");
		System.out.println("id"+id);
		// 비밀번호 체크
		boolean result = service.checkPw(id, password);
		if (result) { // 비밀번호가 맞다면 삭제 처리
			service.deleteSecession(id);
			session.invalidate(); // 탈퇴시 로그아웃 처리
			return "redirect:/aus/main";
		} else { // 비밀번호가 일치하지 않는다면
			return "JHR/secessionpro";

		}
	}
}
