package com.tg.ctl;

import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.tg.svc.UserService;
import com.tg.vo.UserVO;


import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    // 사용자 추가
    @RequestMapping(value = "/user_insert", method = RequestMethod.POST)
    public String ctlUserInsert(@ModelAttribute UserVO userVO
    		, @RequestParam("ufile") MultipartFile file) {
    	//-----------------------------------------------------------------------------------------
		//사용자파일명, 크기, 확장자, 시스템파일명(유니크)
		if (file != null) {
			String fileRealName 	= file.getOriginalFilename();
			String fileExtension 	= fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
			String uniqueName 		= UUID.randomUUID().toString().split("-")[0];
			String uploadFolder = "\\user\\imgs\\";
			String profileImg 	=   uniqueName + fileExtension;   //45dfered.png
			//파일카피
			try {
				file.transferTo( new File(profileImg) ); 
				userVO.setProfileImg(profileImg);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}		
		} //e.o.if
		//-----------------------------------------------------------------------------------------	
    	userService.svcUserInsert(userVO);
        return "redirect:/index"; // 사용자 목록 페이지로 리다이렉트
    }

    // 모든 사용자 조회
    @RequestMapping(value = "/user_list", method = RequestMethod.GET)
	public String ctlUserSelectAll(Model model) {
		 ArrayList<UserVO> userList  = userService.svcUserSelectAll();
		 model.addAttribute("MY_USERLIST", userList);
		 return "common/header";
	}

    
 // 로그아웃
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String ctlUserLogout(Model model, HttpServletRequest request) {
		 request.getSession().invalidate();
		 return "index";
	}
    
    
    // 로그인
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String ctlUserLogin(@RequestParam("userEmail") String userEmail, @RequestParam("userPw") String userPw
    		, Model model
    		, HttpServletRequest request) {
        UserVO userVO = new UserVO();
        userVO.setUserEmail(userEmail);
        userVO.setUserPw(userPw);
        userVO = userService.svcUserLogin(userVO);
        
        if(userVO != null) {
	        request.getSession().setAttribute("SESS_USER_SEQ"  , userVO.getUserSeq());
	        request.getSession().setAttribute("SESS_USER_EMAIL", userVO.getUserName());
			request.getSession().setAttribute("SESS_USER_IMAGE", userVO.getProfileImg());
	        return "index";   //로그인 성공
        } else {
        	return "user/user_form";
        }
    }
    
    // 사용자 정보 상세보기
    @RequestMapping(value = "/user_detail", method = RequestMethod.GET)
	public String ctlUserSelectOne(@RequestParam("userSeq") int userSeq, Model model){
		UserVO userVO = userService.svcUserSelectOne(userSeq);
		System.out.println(userVO.toString());
		model.addAttribute("MY_USER_SEQ", userVO.getUserSeq());
		model.addAttribute("MY_USERVO", userVO);
		return "user/user_mypage";
	}

    // 사용자 수정
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String ctlUserUpdate(@ModelAttribute UserVO userVO ){
		userService.svcUserUpdate(userVO);


        return "redirect:/index";       // 사용자 목록 페이지로 리다이렉트
	}
	
    // 사용자 삭제
	@RequestMapping(value = "/user_delete", method = RequestMethod.POST)
    public String ctlUserDelete(@RequestParam("userSeq") int userSeq) {
        userService.svcUserDelete(userSeq);
        return "redirect:/user_list";          // 사용자 목록 페이지로 리다이렉트
    }
}
