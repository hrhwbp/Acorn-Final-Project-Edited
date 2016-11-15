package com.remind.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.remind.model.AnniversaryDto;
import com.remind.model.BoardDto;
import com.remind.model.DaoInter;
import com.remind.model.LikeDto;
import com.remind.model.ReplyDto;

@Controller
public class BoardController {
	@Autowired
	private DaoInter daoInter;
	private StringBuffer likeStringBuffer = new StringBuffer();
	private StringBuffer replyNameBuffer = new StringBuffer();
	private StringBuffer replyContentBuffer = new StringBuffer();
	
	/*@RequestMapping(value="snslist", method = RequestMethod.GET)
	public ModelAndView list(@RequestParam("mno") String m_no){
		List<BoardDto> list = daoInter.showBoard(m_no);
		ModelAndView model = new ModelAndView();
		
		model.addObject("list", list);
		model.addObject("reply",daoInter.showReplyall());
		model.setViewName("../../main");
		return model;
	}*/
	@RequestMapping(value="snslist", method = RequestMethod.GET)
	public ModelAndView list(HttpSession session){
		String m_no = (String) session.getAttribute("mno");
		ModelAndView model = new ModelAndView();
		List<AnniversaryDto> anniversary = daoInter.showAnniversaryPart(m_no);
		List<BoardDto> list = daoInter.showBoard(m_no);
		for (int i = 0; i < list.size(); i++) {
			List<ReplyDto> reply = daoInter.showReply(list.get(i).getB_no()); 
			model.addObject("reply" + list.get(i).getB_no(), reply);
			int count = daoInter.countReply(list.get(i).getB_no());
			//System.out.println(count);
			model.addObject("replycount"+list.get(i).getB_no(),count);
		}
		for (int i = 0; i < list.size(); i++) {
			List<LikeDto> like = daoInter.showLike(list.get(i).getB_no());
			model.addObject("like" + list.get(i).getB_no(), like);	
		}
		for (int i = 0; i < list.size(); i++) {
			LikeBean bean = new LikeBean();
			bean.setL_bno(list.get(i).getB_no());
			bean.setL_mno(m_no);
			int likeYN = daoInter.likeYN(bean);
			model.addObject("likeYN" + list.get(i).getB_no(), likeYN);	
		}
		model.addObject("list", list);
		model.addObject("anniversary",anniversary);
		model.setViewName("../../main");
		return model;
	}
	@RequestMapping("scroll") // 스크롤링 기본 베이스  ( 댓글 , 라이크 뽑을려면 있어야됨 )
	@ResponseBody
	public Map<String, Object> scrolling(@RequestParam("last_bno")String last_bno, HttpSession session){//last_bnoShouldMinus
		String m_no = (String) session.getAttribute("mno");
		List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
		Map<String, String> data = null;
		ScrollBean bean = new ScrollBean();
		bean.setLast_b_no(last_bno);
		bean.setM_no(m_no);
		List<BoardDto> boardList = daoInter.scrollBoard(bean);
		LikeBean likeYnBean = new LikeBean();
		
		for(BoardDto s : boardList){
			data = new HashMap<String,String>();
			data.put("b_no",s.getB_no());
			data.put("b_image", s.getB_image());
			data.put("b_content", s.getB_content());
			data.put("b_mname", s.getB_mname());
			data.put("b_mno", s.getB_mno());
			
			///	라이크
			List<LikeDto> likeDto = daoInter.showLike(s.getB_no());
			likeStringBuffer.delete(0, likeStringBuffer.length());
			for (int i = 0; i < likeDto.size(); i++) {
				likeStringBuffer.append(likeDto.get(i).getL_mname());
				likeStringBuffer.append(",");
			}
			if (likeStringBuffer.length() >= 1) {
				likeStringBuffer.delete(likeStringBuffer.length()-1, likeStringBuffer.length());
			}
			data.put("like_mname", likeStringBuffer.toString());
			/// 라이크 마지막
			//댓글 
			List<ReplyDto> replyDto = daoInter.showReply(s.getB_no());
			replyNameBuffer.delete(0, replyNameBuffer.length());
			replyContentBuffer.delete(0, replyContentBuffer.length());
			for (int i = 0; i < replyDto.size(); i++) {
				replyNameBuffer.append(replyDto.get(i).getR_name());
				replyNameBuffer.append(",");
				replyContentBuffer.append(replyDto.get(i).getR_content());
				replyContentBuffer.append(",");
			}
			if (replyNameBuffer.length() >= 1) {
				replyNameBuffer.delete(replyNameBuffer.length()-1, replyNameBuffer.length());
			}
			if (replyContentBuffer.length() >= 1){
				replyContentBuffer.delete(replyContentBuffer.length()-1, replyContentBuffer.length());
			}
			data.put("reply_Name", replyNameBuffer.toString());
			data.put("reply_Content", replyContentBuffer.toString());
			String replyCount = Integer.toString(daoInter.countReply(s.getB_no()));
			data.put("reply_Count", replyCount);
			//댓글 마지막
			//YN
			//likeYnBean = null;
			likeYnBean.setL_bno(s.getB_no());
			likeYnBean.setL_mno(m_no);
			
			int likeYnCheck = daoInter.likeYN(likeYnBean);
			data.put("scoll_mno", m_no);
			data.put("likeYnCheck", Integer.toString(likeYnCheck));
			//YN 마지막
//			for (int i = 0; i < list.size(); i++) {
//				LikeBean bean = new LikeBean();
//				bean.setL_bno(list.get(i).getB_no());
//				bean.setL_mno(m_no);
//				int likeYN = daoInter.likeYN(bean);
//				model.addObject("likeYN" + list.get(i).getB_no(), likeYN);	
//			}
			dataList.add(data);
		}
		Map<String, Object> scrollData = new HashMap<String, Object>();
		scrollData.put("datas", dataList);
		
		return scrollData;
	}
	
	@RequestMapping("likescoll")
	@ResponseBody
	public Map<String, Object> likeScrolling(@RequestParam("likeB_no")String likeB_no){
		List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
		Map<String, String> data = null;
		List<LikeDto> like = daoInter.showLike(likeB_no);
		for(LikeDto s : like){
			data = new HashMap<String, String>();
			data.put("l_mname", s.getL_mname());
		}
		
		Map<String, Object> likeScrollData = new HashMap<String, Object>();
		likeScrollData.put("datas", dataList);
		return likeScrollData;
	}
	@RequestMapping("replyscrollcount")
	@ResponseBody
	public Map<String, Object> likeScrollingCount(@RequestParam("likeB_no")String likeB_no){
		int num = 0;
		List<LikeDto> dto = daoInter.showLike(likeB_no);
//		if (dto.size() == 0) {
//			num = 0;
//		}else if(dto.size() > 11){
//			num = 1;
//		}else{
//			num = 2;
//		}
		num = dto.size();
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("num", num);
		return data;
	}
	
	/*@RequestMapping(value="snslist", method = RequestMethod.POST)
	public Map<String, Object> listPOST(@RequestParam("b_no") String b_no){
		System.out.println("snslist test" + b_no);
		List<ReplyDto> reply = daoInter.showReply(b_no);
		List<LikeDto> like = daoInter.showLike(b_no);
		List<Map<String, String>> replydataList = new ArrayList<Map<String, String>>();
		Map<String, String> replydata = null;
		for (ReplyDto dto:reply){
			replydata = new HashMap<String, String>();
			replydata.put("r_name", dto.getR_name());
			replydata.put("r_content",dto.getR_content());
			replydataList.add(replydata);
		}
		List<Map<String, String>> likeList = new ArrayList<Map<String, String>>();
		Map<String, String> likedata = null;
		for (LikeDto dto:like){
			likedata = new HashMap<String, String>();
			likedata.put("l_name", dto.getL_mname());
			likeList.add(likedata);
		}
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("replydata"+b_no,replydataList);
		data.put("likedata"+b_no, likeList);
		
		return data;
		
	}*/
	@RequestMapping(value="showDetail", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> ShowDetail(@RequestParam("b_no") String b_no){
		List<ReplyDto> listReply = daoInter.showReply(b_no);
		BoardDto showDetail =  daoInter.showBoardDetail(b_no);
	/*	List<Map<String, String>> replyList = new ArrayList<Map<String,String>>();
		Map<String, String> reply = null;
		for(ReplyDto dto:listReply){
			reply = new HashMap<String, String>();
			reply.put("r_no", dto.getR_no());
			reply.put("r_bno", dto.getR_bno());
			reply.put("r_mno", dto.getR_mno());
			reply.put("r_content", dto.getR_content());
			reply.put("r_date", dto.getR_date());
			replyList.add(reply);
		}
		Map<String, String> detail = new HashMap<String, String>();
		detail.put("b_no1", showDetail.getB_no1());
		detail.put("b_mno", showDetail.getB_mno());
		detail.put("b_image", showDetail.getB_image());
		detail.put("b_content", showDetail.getB_content());
		detail.put("b_date", showDetail.getB_date());
		detail.put("b_like", showDetail.getB_like());
		Map<String, Object> resultData = new HashMap<String, Object>();
		resultData.put("listReply", replyList);
		resultData.put("showDetail", detail);*/
		Map<String, Object> resultData = new HashMap<String, Object>();
		resultData.put("listReply", listReply);
		resultData.put("showDetail", showDetail);
		return resultData;
	}
	
	@RequestMapping(value="insertBoard",method = RequestMethod.GET)
	public String write(BoardBean bean){
		MultipartFile uploadfile = bean.getFileUpload();
		System.out.println(uploadfile);	
		return "write";
	}
	
	@RequestMapping(value="insertBoard", method=RequestMethod.POST)
	public String writeSubmit(BoardBean bean){
		
		MultipartFile uploadfile = bean.getFileUpload();
	
		
		if (uploadfile != null) {
            String fileName = uploadfile.getOriginalFilename();
            System.out.println(fileName);
            bean.setB_image("http://wbp.synology.me/boardimg/" + fileName);
            System.out.println(bean.getB_image());
            try {
                // 1. FileOutputStream 사용
                // byte[] fileData = file.getBytes();
                // FileOutputStream output = new FileOutputStream("C:/images/" + fileName);
                // output.write(fileData);
                 
                // 2. File 사용
                File file = new File("N:/web/boardimg/" + fileName);
                
                uploadfile.transferTo(file);
            } catch (Exception e) {
                System.out.println("보드 파일 업로드 err : " + e);
            } // try - catch
        } // if
		boolean b = daoInter.write(bean);
		if(b) return "redirect:/myinfo";
		else return "redirect:/error.jsp";
	}
	@RequestMapping(value="updateBoard", method=RequestMethod.GET)
	public ModelAndView updateBoard(@RequestParam("b_no1") String b_no1){
		BoardDto dto = daoInter.showBoardDetail(b_no1);
		return new ModelAndView("updateboard","dto",dto);
	}
	@RequestMapping(value="updateBoard", method = RequestMethod.POST)
	public String updateSubmit(BoardBean bean){
		MultipartFile uploadfile = bean.getFileUpload();
		if (uploadfile != null) {
            String fileName = uploadfile.getOriginalFilename();
            System.out.println(fileName);
            bean.setB_image("http://wbp.synology.me/boardimg/" + fileName);
            System.out.println(bean.getB_image());
            try {
                // 1. FileOutputStream 사용
                // byte[] fileData = file.getBytes();
                // FileOutputStream output = new FileOutputStream("C:/images/" + fileName);
                // output.write(fileData);
                 
                // 2. File 사용
                File file = new File("N:/web/boardimg/" + fileName);
                
                uploadfile.transferTo(file);
            } catch (Exception e) {
                System.out.println("보드 파일 업로드 err : " + e);
            } // try - catch
        } // if
		boolean b = daoInter.updateBoard(bean);
		if(b) return "redirect:/myinfo";
		else return "redirect:/error.jsp";
	}
	
	@RequestMapping(value="deleteBoard", method = RequestMethod.GET)
	public String deleteSubmit(@RequestParam("b_no1") String b_no1){
		boolean b = daoInter.eraseBoard(b_no1);
		BoardDto dto = daoInter.showBoardDetail(b_no1);
		if(b){return "snslist?m_no=" + dto.getB_mno();}
		else return "redirect:/error.jsp";
	}
	
	@RequestMapping(value="boardDetail", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> boardDetail(@RequestParam("b_no") String b_no){
		BoardDto dto = daoInter.showBoardDetail(b_no);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("detailDto", dto);
		return map;
	}
	
	@RequestMapping(value="rlCount", method= RequestMethod.POST)
	@ResponseBody
	public Map<String, Integer> likeReCount(@RequestParam("b_no") String b_no){
		LikeDto dto = daoInter.countLike(b_no);
		int likeCount = Integer.parseInt(dto.getL_count());
		int replyCount = daoInter.countReply(b_no);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("likeCount", likeCount);
		map.put("replyCount", replyCount);
		return map;
	}
}
