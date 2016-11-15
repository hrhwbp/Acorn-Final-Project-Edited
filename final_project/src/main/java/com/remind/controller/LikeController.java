package com.remind.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.remind.model.DaoInter;
import com.remind.model.LikeDto;
import com.remind.model.ReplyDto;

@Controller
public class LikeController {
	@Autowired
	private DaoInter daoInter;
	
	@RequestMapping(value="insertLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> like(LikeBean bean){
		daoInter.like(bean);
		List<LikeDto> like = daoInter.showLike(bean.getL_bno());
		List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
		Map<String, String> data = null;
		
		for(LikeDto dto : like){
			data = new HashMap<String, String>();
			data.put("l_name", dto.getL_mname());
			dataList.add(data);
		}
		Map<String, Object> likeData = new HashMap<String, Object>();
		likeData.put("datas", dataList);
		likeData.put("likecount", daoInter.countLike(bean.getL_bno()).getL_count());
		return likeData;
				
	}
	@RequestMapping(value="cancelLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> cancellike(LikeBean bean){
		daoInter.likeCancel(bean);
		List<LikeDto> like = daoInter.showLike(bean.getL_bno());
		List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
		Map<String, String> data = null;
		
		for(LikeDto dto : like){
			data = new HashMap<String, String>();
			data.put("l_name", dto.getL_mname());
			dataList.add(data);
		}
		Map<String, Object> likeData = new HashMap<String, Object>();
		likeData.put("datas", dataList);
		likeData.put("likecount", daoInter.countLike(bean.getL_bno()).getL_count());
		return likeData;
				
	}
}
