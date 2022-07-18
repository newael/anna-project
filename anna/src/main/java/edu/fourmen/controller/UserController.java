package edu.fourmen.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.fourmen.service.MailService;
import edu.fourmen.service.UserService;
import edu.fourmen.vo.UserVO;

@RequestMapping(value="/user")
@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	MailService mailService;
	
	@Autowired
	BCryptPasswordEncoder pwdEncoder; 
	
	String path = "/anna";
	
	//로그인 페이지
	@RequestMapping(value="/login.do", method=RequestMethod.GET)
	public String login() {
		
		return "user/login";
	}
		
	//회원가입 페이지
	@RequestMapping(value="/join.do", method=RequestMethod.GET)
	public String join() {
		
		return "user/join";
		
	}
	
	//로그인 처리
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public void login(UserVO vo, HttpServletResponse response,HttpServletRequest request,HttpSession session) throws IOException {
		
		response.setContentType("text/html; charset=utf-8");
		
		PrintWriter pw = response.getWriter();
		
		UserVO userInfo = userService.login(vo);

		if(userInfo == null) {
			
			System.out.println("가입되지 않은 이메일주소1");
			
			pw.append("<script>alert('가입되지 않은 이메일 주소입니다.'); history.back();</script>");
			
			pw.flush();
			
			pw.close();
			
			
		} else {
			
			System.out.println("kakao_auth : " + userInfo.getKakao_auth());
			
			if(userInfo.getKakao_auth() == null) {
				
				if(pwdEncoder.matches(vo.getUser_pwd(), userInfo.getUser_pwd())){
					
					System.out.println("비밀번호 일치");
					
					session = request.getSession(); 
		
					session.setAttribute("uidx", userInfo.getUidx());
					
					session.setAttribute("user_email", userInfo.getUser_email());
					
					session.setAttribute("nickName", userInfo.getNickName());
					
					session.setAttribute("interested", userInfo.getInterested());
					
					pw.append("<script>location.href='"+request.getContextPath()+"/main.do';</script>");
					
					pw.flush();
					
					pw.close();
					
				} else {
					
					System.out.println("비밀번호 불일치");
					
					pw.append("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
					
					pw.flush();
					
					pw.close();
					
				}
				
			} else {
				
				pw.append("<script>alert('카카오 계정과 연동된 아이디 입니다. \\n카카오 로그인 하기를 눌러주시면 간편 로그인이 가능합니다.'); history.back();</script>");
				
				pw.flush();
				
				pw.close();
				
			}
			
		} 	
	}
	
	//로그아웃 처리
	@RequestMapping(value="/logout.do")
	public String logOut(HttpServletRequest request,HttpSession session) {
		
		session = request.getSession();
		
		session.invalidate();
		
		return "redirect:/main.do";
	}
	
	//회원가입  데이터 입력
	@RequestMapping(value="/join.do", method=RequestMethod.POST)
	public void join(UserVO vo, HttpServletResponse response,HttpServletRequest request) throws IOException {
		
		response.setContentType("text/html; charset=utf-8");

		PrintWriter pw = response.getWriter();
		
		vo.setUser_pwd(pwdEncoder.encode(vo.getUser_pwd()));
		
		int result = userService.join(vo);
		
		if(result == 1) {
			
			pw.append("<script>alert('환영합니다"+vo.getNickName()+"님, 가입이 완료되었습니다.'); location.href='"+request.getContextPath()+"/user/login.do';</script>");
			
			pw.flush();
			
			pw.close();
			
		} else {
			
			pw.append("<script>alert('문제가 발생하여 처리되지 않았습니다.\\n다시 시도해주세요.'); location.href='"+request.getContextPath()+"/user/joinS2.do'</script>");
			
			pw.flush();
			
			pw.close();
			
		}
		
	}		
	
	//카카오 인증 Api URL 가져오는 Ajax
	@ResponseBody
	@RequestMapping(value = "/getKakaoAuthUrl.do", produces = "application/text; charset=utf8")
	public String getKakaoAuthUrl() {
		
		String reqUrl = "https://kauth.kakao.com/oauth/authorize";
		reqUrl += "?client_id="+userService.getClient_id();
		reqUrl += "&redirect_uri="+userService.getRedirect_uri();
		reqUrl += "&response_type=code";
		
		return reqUrl;
	}
	
	//카카오 연동정보 조회 및 로그인 처리
	@RequestMapping(value = "/kakaoLogin.do")
	public void oauthKakao(String code, HttpServletResponse response,HttpServletRequest request,HttpSession session) throws IOException {

		//오류 발생시의 메세지
        String msg = "";
        
        //처리후 이동경로
        String moveTo = "";
		
		session = request.getSession();
		
		response.setContentType("text/html; charset=utf-8");

		PrintWriter pw = response.getWriter();
		
		//카카오 code값을 이용해 엑세스 토큰 및 통신코드 받기
		HashMap<String,Object> kakaoInfo = userService.getAccessToken(code);
		
		//카카오 엑세스 토큰
        String access_Token = (String)kakaoInfo.get("access_Token");
        
        //카카오 통신 코드 200이여야 정상 처리됨
        int responseCode = (int)kakaoInfo.get("responseCode");
	
        //엑세스 토큰을 이용하여 카카오 회원정보를 받기
        HashMap<String, Object> userInfo = userService.getKakaoUserInfo(access_Token);
        
        //카카오 회원정보를 담기위한 UserVO
        UserVO vo = new UserVO();
        
        //카카오 회원정보를 변수에 담고 vo에 세팅---------------------------------------------------------------
        
        String kakao_email = (String)userInfo.get("kakao_email");
        
    	String kakao_nickName = (String)userInfo.get("nickName");
    	
    	String kakaoId = (String)userInfo.get("kakaoId");
    	
    	String thumbnail_image = (String)userInfo.get("thumbnail_image");
    	
    	vo.setUser_email(kakao_email);
    	
    	vo.setNickName(kakao_nickName);
    	
    	vo.setKakao_auth(kakaoId);
    	
    	vo.setProfile_image(thumbnail_image);
    	
    	//------------------------------------------------------------------------------------------
    	
    	
    	//로그인 정보를 담기위한 UserVO
    	UserVO userLoginInfo = new UserVO();
    	
    	//통신 코드가 200이 아니면 카카오API 통신 실패
        if(responseCode != 200) {
        	
        	System.out.println("카카오 로그인 오류(code : "+responseCode+")");
        	
        	msg = "alert('카카오 로그인에 실패하였습니다.(오류코드 : kakao"+responseCode+")\\n관리자에게 문의해주세요.');";
        	
        	moveTo = request.getContextPath()+"/user/login.do";
        	
        } else {
        	
        	//카카오 회원정보의 이메일과 일치하는 회원정보가 있는지 확인
        	int result = userService.emailChk(kakao_email);
        	
        	//일치하는 정보가 없다면 카카오 회원정보를 이용한 회원가입 후 로그인 처리
        	if(result == 0) {
            	
        		
            	if(userService.join(vo) != 1) {
            		
            		System.out.println("카카오 로그인 회원가입 오류 발생");
            		
            		msg = "alert('카카오 로그인에 실패하였습니다.(오류코드 : join)\\n관리자에게 문의해주세요.');";
                	
                	moveTo = request.getContextPath()+"/user/login.do";
            		
            	} else {
            		
            		System.out.println("카카오 로그인 회원가입 및 로그인 처리");
            		
            		userLoginInfo = userService.login(vo);
            		
            		//로그인 세션정보 (회원번호[uidx], 이메일[user_email], 닉네임[nickName])
            		session.setAttribute("uidx", userLoginInfo.getUidx());
            		
        			session.setAttribute("user_email", userLoginInfo.getUser_email());
        			
        			session.setAttribute("nickName", userLoginInfo.getNickName());
        			
        			session.setAttribute("interested", userLoginInfo.getInterested());
        			
        			moveTo = request.getContextPath()+"/main.do";
        			
            	}
            	
        	} else {	//일치하는 정보가 있다면 kakao_auth update 후 로그인 처리
        		
        		System.out.println("가입된 이메일 주소 카카오 id(kakao_auth) update 후 로그인 처리");
        		
        		userLoginInfo = userService.login(vo);
        		
        		if(userLoginInfo.getKakao_auth() == "") {
        			
        			userLoginInfo.setKakao_auth(vo.getKakao_auth());
        			
        			userService.updateKakaoAuthKey(userLoginInfo);
        			
        		}
        		
    			//로그인 세션정보 (회원번호, 이메일[아이디], 닉네임)
    			session.setAttribute("uidx", userLoginInfo.getUidx());
    			
    			session.setAttribute("user_email", userLoginInfo.getUser_email());
    			
    			session.setAttribute("nickName", userLoginInfo.getNickName());
    			
    			session.setAttribute("interested", userLoginInfo.getInterested());
    			
    			moveTo = request.getContextPath()+"/user/myPage.do";
        			
        	}
        	
        }
        
        pw.append("<script>"+msg+" location.href='"+moveTo+"';</script>");
		
		pw.flush();
		
		pw.close();
		
	}
	
	@RequestMapping(value="/myPage.do")
	public String myPage(Model model,HttpServletRequest request,HttpSession session) {
		
		model.addAttribute("path",path);
		
		session = request.getSession();
		
		int uidx = 0;
		
		if(session.getAttribute("uidx") != null) {		
			uidx = (int)session.getAttribute("uidx");
		}
		
		System.out.println(uidx);
		
		return "user/myPage";
		
	}
	
	//회원정보 조회
	@RequestMapping(value="/userInfoView.do")
	public String userInfo(Model model,HttpServletRequest request,HttpSession session) {
		
		model.addAttribute("path",path);
		
		session = request.getSession();
		
		int uidx = 0;
		
		if(session.getAttribute("uidx") != null) {		
			uidx = (int)session.getAttribute("uidx");
			
			UserVO userInfo = userService.getUserInfo(uidx);
			
			model.addAttribute("userInfo",userInfo);
			
		}
				
		return "user/userInfoView";
		
	}
	
	
	//회원정보 조회
	@RequestMapping(value="/userInfoMod.do")
	public String userInfoMod(Model model,HttpServletRequest request,HttpSession session) {
		
		model.addAttribute("path",path);
		
		session = request.getSession();
		
		int uidx = 0;
		
		if(session.getAttribute("uidx") != null) {		
			uidx = (int)session.getAttribute("uidx");
			
			UserVO userInfo = userService.getUserInfo(uidx);
			
			model.addAttribute("userInfo",userInfo);
			
		} 
		
		return "user/userInfoMod";
		
	}
	
	//가입된 이메일인지 확인후 인증 이메일을 보내는 Ajax
	@ResponseBody
	@RequestMapping(value="/emailChk.do", produces = "application/text; charset=utf8")
	public String emailChk(String user_email) {
		
		int result = userService.emailChk(user_email);
		
		return result+"";
		
	}
	
	//이메일 인증 메일 전송
	@ResponseBody
	@RequestMapping(value="/sendAuthEmail.do",produces = "application/text; charset=utf8")
	public String sendAuthEmail(String user_email) {
		
		String authKey = mailService.sendAuthMail(user_email);
		
		return authKey;
		
	}
	
}
