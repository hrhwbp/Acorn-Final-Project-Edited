package com.remind.controller;

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

import com.remind.model.DaoInter;
import com.remind.model.ReplyDto;

@Controller
public class ReplyController {
	@Autowired
	private DaoInter daoInter;
	
	@RequestMapping(value="insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> writeReply(ReplyBean bean){
		System.out.println(bean.getR_mno() + " " +bean.getR_content());
		daoInter.writeReply(bean);
		List<ReplyDto> reply = daoInter.showReply(bean.getR_bno());
		List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
		Map<String, String> data = null;
		int count = daoInter.countReply(bean.getR_bno());
		for(ReplyDto dto : reply){
			data = new HashMap<String, String>();
			data.put("r_name", dto.getR_name());
			data.put("r_content",dto.getR_content());
			dataList.add(data);
		}
		Map<String, Object> replyData = new HashMap<String, Object>();
		replyData.put("datas", dataList);
		replyData.put("count", count);
		return replyData;
		
	}
	@RequestMapping(value="moreReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> moreReply(@RequestParam("b_no") String b_no){
		 
		List<ReplyDto> reply = daoInter.showReplyMore(b_no);
		List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
		Map<String, String> data = null;
		for(ReplyDto dto : reply){
			data = new HashMap<String, String>();
			data.put("r_name", dto.getR_name());
			data.put("r_content",dto.getR_content());
			dataList.add(data);
		}
		Map<String, Object> replyData = new HashMap<String, Object>();
		replyData.put("datas", dataList);
		return replyData;
		
	}
	@RequestMapping(value="deleteReply", method = RequestMethod.GET)
	public String deleteReply(@RequestParam("r_no")String r_no){
		boolean b = daoInter.deleteReply(r_no);
		ReplyDto dto = daoInter.showReplyDetail(r_no);
		if(b) return "showDetail"+dto.getR_bno();
		else return "redirect:/error.jsp";
	}
	@RequestMapping(value="updateReply", method = RequestMethod.GET)
	@ResponseBody
	public ReplyDto replyDetail(@RequestParam("r_no")String r_no){
		return daoInter.showReplyDetail(r_no);
	}
	
	@RequestMapping(value="updateReply", method = RequestMethod.POST)
	public String updateReply(ReplyBean bean){
		boolean b = daoInter.updateReply(bean);
		if(b) return "showDetail"+bean.getR_bno();
		else return "redirect:/error.jsp";
	}
	
}
