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
import org.springframework.web.servlet.ModelAndView;

import com.remind.model.AnnoInter;
import com.remind.model.DaoInter;
import com.remind.model.WishlistDto;

@Controller
public class WishListController {
	@Autowired
	private DaoInter daoInter;
	
	/*@RequestMapping(value="showWishList", method = RequestMethod.GET)
	public ModelAndView showWishList(@RequestParam("w_mno")String w_mno){
		ModelAndView modelAndView = new ModelAndView("../../showWishList", "wishlist", daoInter.showWishList(w_mno)); 	
		List<WishlistDto> list =  daoInter.showWishList(w_mno);
		return  modelAndView;
	}*/
	
	@RequestMapping(value="showInsertedList" ,method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertedList(WishlistBean bean){//@RequestParam("w_no") String w_no, @RequestParam("w_mno") String w_mno){
		System.out.println("아작스 힘들다 @@ " + bean.w_no + " && " + bean.w_mno);
		List<Map<String, String>> insertedList = new ArrayList<Map<String, String>>();
		Map<String, String> sData = null;
		
		if(bean.w_mno != null){
			List<WishlistDto> list2 = daoInter.showWishList(bean.w_mno);
			for(WishlistDto s2:list2){
				sData = new HashMap<String, String>();
				sData.put("m_name", s2.getM_name());
				System.out.println(s2.getM_name() + "~~~~~~~~~~~");
				insertedList.add(sData);
			}
		}
		
		if(bean.w_no != null){
			List<WishlistDto> list = daoInter.showInsertedList(bean.w_no);
			for(WishlistDto s:list){
				sData = new HashMap<String, String>();
				//System.out.println(s.getW_price() + " %% ");
				sData.put("w_no", s.getW_no());
				sData.put("w_mno", s.getW_mno());
				sData.put("w_detail", s.getW_detail());
				sData.put("w_pname", s.getW_pname());
				sData.put("w_price", s.getW_price());
				sData.put("w_image", s.getW_image());
				sData.put("url", s.getW_addr());
				insertedList.add(sData);
			}
		}
		
		
		Map<String, Object> insertedData = new HashMap<String, Object>();
		insertedData.put("insertedList", insertedList);
		return insertedData;
	}
	
	@RequestMapping(value="insertWishList", method = RequestMethod.POST)
	public String insertWishListsubmit(WishlistBean bean){
		System.out.println(bean.w_mno + " " + bean.w_pname + " " + bean.w_addr + " " + bean.w_detail + " " + bean.w_image + " " + bean.w_price + " " + bean.wg_detail);
		boolean b = daoInter.writeWishlist(bean);
		if(b)
			return "redirect:/showWishList?w_mno=" +bean.getW_mno() + "&wg_detail=" + bean.getWg_detail();
		else
			return "redirect:/error.jsp";
	}
	
	@RequestMapping(value="updateWishList", method = RequestMethod.POST)
	public String updateWishListsubmit(WishlistBean bean){
		System.out.println(bean.getW_pname() + " @@" + bean.getW_mno() + " @@@" + bean.getW_no());
		boolean b = daoInter.updateWishlist(bean);
		if(b)
			return "redirect:/showWishList?w_mno=" + bean.getW_mno();
		else
			return "redirect:/error.jsp";
	}
	
	@RequestMapping(value="updatelock", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateLockStatus(WishlistBean bean){
		
		boolean b = daoInter.updateLockStatus(bean);
		System.out.println(bean.getW_lock() + " @@ " + bean.getW_no() + " $$ " + bean.getW_mno());
		if(b){
			List<Map<String, String>> insertedList = new ArrayList<Map<String, String>>();
			Map<String, String> sData = null;
		
			List<WishlistDto> list = daoInter.showInsertedList(bean.getW_no());
		
			for(WishlistDto s:list){
				sData = new HashMap<String, String>();
				System.out.println(s.getW_lock() + " %% ");
				sData.put("w_lock", s.getW_lock());
				sData.put("w_mno", s.getW_mno());
				insertedList.add(sData);
			}
		
			Map<String, Object> insertedData = new HashMap<String, Object>();
			insertedData.put("insertedList", insertedList);
			return insertedData;
		}else{
			System.out.println("에러당 ");
			return null;
		}
		
		
		
	}
	
	@RequestMapping(value="deleteWishList", method = RequestMethod.GET)
	public String deleteWishListsubmit(@RequestParam("w_mno")String w_mno, @RequestParam("w_no")String w_no){
		boolean b = daoInter.deleteWishlist(w_no);
		if(b){
			return "redirect:/showWishList?w_mno=" + w_mno;
		}else{
			return "redirect:/error.jsp";
		}
	}
	
	

	/*//Wishlist 추가
	@RequestMapping(value="insertWishList", method = RequestMethod.GET)
	public String insertWishList(@RequestParam("w_mno")String w_mno){		
		return "insertWishList?w_mno="+w_mno;			
	}*/
	
	/*@RequestMapping(value="insertWishList", method = RequestMethod.POST)
	public String insertWishListsubmit(WishlistBean bean){
		boolean b = daoInter.writeWishlist(bean);
		if(b)
			return "showWishList?w_mno=" +bean.getW_mno();
		else
			return "redirect:/error.jsp";
	}*/
		
	/*//Wishlist 변경
	@RequestMapping(value="updateWishList", method = RequestMethod.GET)
	public String updateWishList(@RequestParam("w_mno")String w_mno){
		return "insertWishList?w_mno="+w_mno;
		
	}*/
/*	@RequestMapping(value="updateWishList", method = RequestMethod.POST)
	public String updateWishListsubmit(WishlistBean bean){
		boolean b = daoInter.updateWishlist(bean);
		if(b)
			return "showWishList?w_mno=" + bean.getW_mno();
		else
			return "redirect:/error.jsp";
	}*/
		
	/*//Wishlist 물품삭제
	@RequestMapping(value="deleteWishList", method = RequestMethod.GET)
	public String deleteWishListsubmit(@RequestParam("w_mno")String w_mno){
		boolean b = daoInter.deleteWishlist(w_mno);
		if(b)
			return "showWishList?w_mno=" +w_mno;
		else
			return "redirect:/error.jsp";
	}*/
	
	//Wishlist 보기
	@RequestMapping(value="showWishList", method = RequestMethod.GET)
	public ModelAndView showWishList(@RequestParam("w_mno")String w_mno){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("wishlist",daoInter.showWishList(w_mno));	
		modelAndView.addObject("wishgroup",daoInter.showWishGroup(w_mno));
		System.out.println("test : " + daoInter.showWishList(w_mno));
		
		modelAndView.setViewName("../../wishlist");
		return modelAndView;
	}
	
	//WishList Group 추가
	@RequestMapping(value="insertWishGroup", method = RequestMethod.POST)
	public String insertWishGroup(WishlistBean bean){	
		boolean b = daoInter.insertWishGroup(bean);
		String w_mno = bean.getW_mno();
		System.out.println(bean.getW_mno());
		System.out.println(b);
		if(b)
			return "redirect:/wishlist?w_mno=" + w_mno;  //"showWishList?w_mno=" + bean.getW_mno();
		else
			return	"redirect:/error.jsp";		
	}
	
	//Wishlist Group 업데이트
	@RequestMapping(value="updateWishGroup", method= RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateWishGroup(@RequestParam("wg_no")String wg_no, @RequestParam("wg_detail")String wg_detail){
		List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
		Map<String, String> data = null;
		
		WishlistBean bean = new WishlistBean();
		bean.setWg_no(wg_no);
		bean.setWg_detail(wg_detail);		
		boolean b = daoInter.updateWishGroup(bean);
		if (b)		System.out.println(wg_no + wg_detail);
		else System.out.println("에러");
		
		//DB 변경작업 끝
		WishlistDto wishGroup = daoInter.showWishAGroup(wg_no);
			data = new HashMap<String, String>();
			data.put("wg_no", wishGroup.getWg_no());
			data.put("wg_detail", wishGroup.getWg_detail());			
			dataList.add(data);
		
		Map<String, Object> wishGroupData = new HashMap<String, Object>();
		wishGroupData.put("WishGroupList", dataList);
		
		return wishGroupData;
	}
	
	
	
	/*@RequestMapping(value="ReadWishGroupList4Edit", method = RequestMethod.GET)
	public Map<String, Object> ReadWishGroupList4Edit(@RequestParam("wg_no")String wg_no){
		List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
		Map<String, String> data = null;
		
		List<WishlistDto> wishGroup = daoInter.ReadWishGroupList4Edit(wg_no);
		
		for(WishlistDto w:wishGroup){
			data = new HashMap<String, String>();
			data.put("wg_no", w.getWg_no());
			data.put("wg_detail", w.getWg_detail());			
			dataList.add(data);
		}
		Map<String, Object> wishGroupData = new HashMap<String, Object>();
		wishGroupData.put("WishGroupData", dataList);
		return wishGroupData;
	}
	
	//WishList Group 변경
	@RequestMapping(value="updateWishGroup", method = RequestMethod.POST)
	public ModelAndView updateWishGroup(@RequestParam("w_mno")String w_mno, WishlistBean bean){	
		boolean b = daoInter.insertWishGroup(bean);
		String w_mno = bean.getW_mno();
		System.out.println(bean.getW_mno());
		System.out.println(b);
		if(b)
			return ;
		else
			return	"redirect:/error.jsp";		
	}
	
	//ajax
	 * public Map<String, Object> sangpum(){
		List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
		Map<String, String> data = null;
		
		List<SangpumDto> sangList = inter.list();
		
		for(SangpumDto s:sangList){
			data = new HashMap<String, String>();
			data.put("code", s.getCode());
			data.put("sang", s.getSang());
			data.put("su", s.getSu());
			data.put("dan", s.getDan());
			dataList.add(data);
		}
		Map<String, Object> sangpumData = new HashMap<String, Object>();
		sangpumData.put("Datas", dataList);
		return sangpumData;
	}		
			
			
			
	
	
*/
	
}
