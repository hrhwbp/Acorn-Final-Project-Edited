package com.remind.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.remind.model.DaoInter;
import com.remind.model.FollowDto;

@Controller
public class FollowController {
	@Autowired
	private DaoInter daoInter;
	
	@RequestMapping(value="showMyFollower", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> showMyFollower(@RequestParam("m_no")String m_no, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		String m_no2 = (String)session.getAttribute("mno");
		List<FollowDto> list = daoInter.showMyFollower(m_no);
		List<FollowDto> list2 = daoInter.showIFollow(m_no2);
		System.out.println("주인 " + m_no + " 나 " + m_no2);
		for(int i = 0; i < list.size(); i++){
			if(list.get(i).getF_mno().equals(m_no2)){
				break;
			}else{
				list.get(i).setF_mno(m_no2);
				list.get(i).setF_ms("");
				for(int j = 0; j < list2.size(); j++){
					if(list.get(i).getF_sno().equals(list2.get(j).getF_mno())){
						System.out.println("3번" + list2.size());
						list.get(i).setF_ms(list2.get(j).getF_ms());
						System.out.println(list2.get(j).getF_ms());
					}
				}
			}
		}
		map.put("Mylist", list);
		/*map.put("Mylist2", list2);*/
		map.put("m_no", m_no);
		map.put("m_no2", m_no2);
		return map;
	}
	@RequestMapping(value="showIFollow", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> showIFollow(@RequestParam("m_no")String m_no, HttpSession session){
		String m_no2 = (String)session.getAttribute("mno");
		Map<String, Object> map = new HashMap<String, Object>();
		List<FollowDto> list = daoInter.showIFollow(m_no);
		List<FollowDto> list2 = daoInter.showIFollow(m_no2);
		for(int i = 0; i < list.size(); i++){
			if(list.get(i).getF_sno().equals(m_no2)){
				System.out.println("실행");
				break;
			}else{
				list.get(i).setF_sno(m_no2);
				list.get(i).setF_ms("");
				for(int j = 0; j < list2.size(); j++){
					if(list.get(i).getF_mno().equals(list2.get(j).getF_mno())){
						System.out.println("3번" + list2.size());
						list.get(i).setF_ms(list2.get(j).getF_ms());
						System.out.println(list2.get(j).getF_ms());
					}
				}
			}
		}
		map.put("Mylist", list);
		map.put("m_no", m_no);
		map.put("m_no2", m_no2);
		return map;
	}
	
	
	@RequestMapping(value="insertFollow", method = RequestMethod.POST)
	@ResponseBody
	public void follow(FollowBean bean){
		FollowDto dto = daoInter.selectFollower(bean);
		System.out.println("getf_mno" + bean.getF_mno());
		System.out.println("getf_sno" + bean.getF_sno());
		System.out.println("getF_ms" + bean.getF_ms());
		if(dto != null){
			System.out.println("????");
			boolean b = daoInter.followUpdate(dto.getF_no(),"insert");
			if(b){
				bean.setF_sno(dto.getF_mno());
				bean.setF_mno(dto.getF_sno());
				bean.setF_ms("2");
				daoInter.follow(bean);
			}
			/*System.out.println("sno인 사람 f_ms업데이트 필요" + dto.getF_no());*/
		}else{
			System.out.println("safj");
			String imsi = bean.getF_mno();
			bean.setF_mno(bean.getF_sno());
			bean.setF_sno(imsi);
			bean.setF_ms("1");
			daoInter.follow(bean);
			/*System.out.println("내가 먼저 팔로우 하는경우");*/
		}
	}
	
	
	@RequestMapping(value="followCancel", method = RequestMethod.POST)
	@ResponseBody
	public void followCancel(FollowBean bean){
		FollowDto dto = daoInter.selectFollower(bean);
		if(dto != null){
			boolean b = daoInter.followUpdate(dto.getF_no(),"delete");
			if(b){
				bean.setF_sno(dto.getF_mno());
				bean.setF_mno(dto.getF_sno());
				daoInter.followCancel(bean);
			}
		}else{
			System.out.println("안옴 ?");
			String imsi = bean.getF_mno();
			bean.setF_mno(bean.getF_sno());
			bean.setF_sno(imsi);
			System.out.println(bean.getF_mno() + " 1 " + bean.getF_sno());
			daoInter.followCancel(bean);
		}
	}
	
}
