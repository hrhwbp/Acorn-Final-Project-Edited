package com.remind.controller;

import java.io.File;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.remind.model.BoardDto;
import com.remind.model.DaoInter;
import com.remind.model.FollowDto;

import com.remind.model.MemberDto;

@Controller
//@SessionAttributes("mno")
public class MemberController {
	@Autowired
	private DaoInter daoInter;
	
	//내 메인페이지
	@RequestMapping(value="showMyMain", method = RequestMethod.GET)
	public ModelAndView showMyMain(@RequestParam("b_mno") String b_mno){
		return new ModelAndView("myMain","myboard",daoInter.showMyMain(b_mno));
	}

	//회원가입
	@RequestMapping(value="join", method= RequestMethod.POST)
	public String join(MemberBean bean){
		
		bean.setM_bdate(bean.getYear()+ "-" + bean.getMonth() + "-" + bean.getDay());
		boolean b = daoInter.joinMember(bean);
		if(b){
			MemberDto dto = daoInter.memberDetail(bean.getM_name());
			AnniversaryBean bean2 = new AnniversaryBean();
			bean2.setA_date(bean.getM_bdate());
			bean2.setA_detail("생일");
			bean2.setA_mno(dto.getM_no());
			daoInter.insertAnniversary(bean2);
			return "redirect:/index.jsp";
		}
		else return "redirect:/error.jsp";
	}
	
	//회원탈퇴
	@RequestMapping(value="out", method = RequestMethod.GET)
	public ModelAndView outConfirm(@RequestParam("m_no") String m_no){
		return new ModelAndView("deleteconfirm","m_no",m_no);
	}
	@RequestMapping(value="out", method= RequestMethod.POST)
	public String out(@RequestParam("m_no") String m_no){
		boolean b = daoInter.outMember(m_no);
		if(b)
			return "redirect:/index.jsp";
		else return "redirect:/error.jsp";
	}
	//내 정보 업데이트
	@RequestMapping(value="updateInfo", method=RequestMethod.GET)
	public ModelAndView updateMember(@RequestParam("m_no") String m_no){
		MemberDto dto = daoInter.showMemberDetail(m_no);
		return new ModelAndView("updateform","dto",dto);
	}	
	@RequestMapping(value="updateInfo", method = RequestMethod.POST)
	public String updateSubmit(MemberBean bean){
		
		MultipartFile uploadfile = bean.getFileUp();
		if (uploadfile != null) {
            String fileName = uploadfile.getOriginalFilename();
            System.out.println(fileName);
            bean.setM_image(fileName);
            try {
                // 1. FileOutputStream 사용
                // byte[] fileData = file.getBytes();
                // FileOutputStream output = new FileOutputStream("C:/images/" + fileName);
                // output.write(fileData);
                 
                // 2. File 사용
                File file = new File("N:/web/profileimg/" + fileName);
                
                uploadfile.transferTo(file);
            } catch (Exception e) {
                System.out.println("파일 업로드 err : " + e);
            } // try - catch
        } // if
        // 데이터 베이스 처리를 현재 위치에서 처리
		bean.setM_bdate(bean.getYear()+ "-" + bean.getMonth() + "-" + bean.getDay());
		boolean b = daoInter.updateMember(bean);
		
		if(b){return "redirect:/myinfo";}
		else return "redirect:/error.jsp";
			
	}
	
	//로그인
	@RequestMapping(value="loginsub", method = RequestMethod.POST)
	@ResponseBody
	public String login(MemberBean bean, HttpSession session){
		MemberDto dto = daoInter.login(bean);
		System.out.println(bean.getM_email());
		String result = "";
		if(dto!= null){
			session.setAttribute("mno", dto.getM_no());		
			result="success";
			  //+ dto.getM_no()
		}else{
			result = "fail";
			
		}
		return result;
	}
	
	//로그아웃
	@RequestMapping(value="logout", method = RequestMethod.GET)
	public String logoutConfirm(HttpSession session){		
		session.removeAttribute("mno");		
		return "../../index";
	}
	
	//내 정보 보기
	@RequestMapping(value="friendinfo", method = RequestMethod.POST)
	public ModelAndView showFriendinfo(@RequestParam("m_no")String m_no){
		System.out.println("들어옴?");
		System.out.println("m_no"+ m_no);
		ModelAndView view = new ModelAndView();
		MemberDto dto = daoInter.showMemberDetail(m_no);
		view.addObject("myinfo", dto);
		List<FollowDto> mylist = daoInter.showMyFollower(m_no);
		view.addObject("mylist", mylist);
		List<FollowDto> ilist = daoInter.showIFollow(m_no);
		view.addObject("ilist", ilist);
		List<BoardDto> list = daoInter.showMyMain(m_no);
		view.addObject("board",list);
		view.setViewName("myinfo");
		return view;
	}
	@RequestMapping(value="myinfo", method = RequestMethod.POST)
	public ModelAndView showMyinfo(@RequestParam("m_no")String m_no){
		ModelAndView view = new ModelAndView();
		MemberDto dto = daoInter.showMemberDetail(m_no);
		
		view.addObject("myinfo", dto);
		List<FollowDto> mylist = daoInter.showMyFollower(m_no);
		view.addObject("mylist", mylist);
		List<FollowDto> ilist = daoInter.showIFollow(m_no);
		view.addObject("ilist", ilist);
		List<BoardDto> list = daoInter.showMyMain(m_no);
		view.addObject("board",list);
		view.setViewName("myinfo");
		return view;
	}
	@RequestMapping(value="myinfo", method = RequestMethod.GET)
	public ModelAndView showMyinfo2(HttpSession session){
		String m_no = (String)session.getAttribute("mno"); 
		ModelAndView view = new ModelAndView();
		MemberDto dto = daoInter.showMemberDetail(m_no);
		view.addObject("myinfo", dto);
		List<FollowDto> mylist = daoInter.showMyFollower(m_no);
		view.addObject("mylist", mylist);
		List<FollowDto> ilist = daoInter.showIFollow(m_no);
		view.addObject("ilist", ilist);
		List<BoardDto> list = daoInter.showMyMain(m_no);
		view.addObject("board",list);
		view.setViewName("myinfo");
		return view;
	}
	
}
