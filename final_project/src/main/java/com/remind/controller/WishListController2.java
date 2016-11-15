/*package com.remind.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.remind.model.DaoInter;
import com.remind.model.WishlistDto;

@Controller
public class WishListController2 {
	@Autowired
	private DaoInter daoInter;
	
	@RequestMapping(value="showWishList", method = RequestMethod.GET)
	public ModelAndView showWishList(@RequestParam("w_mno")String w_mno){
		ModelAndView modelAndView = new ModelAndView("../../showWishList", "wishlist", daoInter.showWishList(w_mno)); 	
		List<WishlistDto> list =  daoInter.showWishList(w_mno);
		return  modelAndView;
	}
	
	
	@RequestMapping(value="showInsertedList" ,method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertedList(@RequestParam("w_pname") String w_pname){
		System.out.println("�븘�옉�뒪 �옒�뱾�떎 @@ " + w_pname);
		List<Map<String, String>> insertedList = new ArrayList<Map<String, String>>();
		Map<String, String> sData = null;
		
		List<WishlistDto> list = daoInter.showInsertedList(w_pname);
		
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
		
		Map<String, Object> insertedData = new HashMap<String, Object>();
		insertedData.put("insertedList", insertedList);
		return insertedData;
	}
	
	
	
	@RequestMapping(value="insertWishList", method = RequestMethod.GET)
	public String insertWishList(@RequestParam("w_mno")String w_mno){
		
		System.out.println("�꽆�뼱�삩�떎~~");
		return "insertWishList?w_mno="+w_mno;			//?w_mno="+w_mno;
		
	}
	
	
	@RequestMapping(value="insertWishList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertWishListsubmit(WishlistBean bean){
		boolean b = daoInter.writeWishlist(bean);
		
		
			List<Map<String, String>> insertedList = new ArrayList<Map<String, String>>();
			Map<String, String> sData = null;
			System.out.println();
			List<WishlistDto> list = daoInter.showInsertedList(bean.w_pname);
			
			for(WishlistDto s:list){
				sData = new HashMap<String, String>();
				sData.put("w_mno", s.getW_mno());
				sData.put("w_detail", s.getW_detail());
				sData.put("w_pname", s.getW_pname());
				sData.put("w_price", s.getW_price());
				sData.put("w_image", s.getW_image());
				sData.put("url", s.getW_addr());
				insertedList.add(sData);
			}
			
			Map<String, Object> insertedData = new HashMap<String, Object>();
			insertedData.put("insertedList", insertedList);
			return insertedData;
			//return "showInsertedList?w_pname=" + bean.getW_pname();
	}
	
	@RequestMapping(value="updateWishList", method = RequestMethod.GET)
	public String updateWishList(@RequestParam("w_mno")String w_mno){
		System.out.println(w_mno + "@@");
		return "insertWishList?w_mno="+w_mno;
		
	}
	
	
	@RequestMapping(value="updateWishList", method = RequestMethod.POST)
	public String updateWishListsubmit(WishlistBean bean){
		System.out.println(bean.getW_pname() + " @@" + bean.getW_mno() + " @@@" + bean.getW_no());
		boolean b = daoInter.updateWishlist(bean);
		if(b)
			return "redirect:/showWishList?w_mno=" +bean.getW_mno();
		else
			return "redirect:/error.jsp";
	}
	
	@RequestMapping(value="deleteWishList", method = RequestMethod.GET)
	public ModelAndView deleteWishListsubmit(@RequestParam("w_pname")String w_pname, @RequestParam("w_mno")String w_mno){
		boolean b = daoInter.deleteWishlist(w_pname);
		if(b){
			//System.out.println("�궘�젣 �꽦怨�");
			return new ModelAndView("../../showWishList", "wishlist", daoInter.showWishList(w_mno)); //"showWishList?w_mno=" + w_mno;							//�씠嫄� �솢 forwarding�씠 �릺�뒗嫄곗�??  showWishList?w_mno=3.jsp瑜� 李얜뒗�떎
		}else{
			return new ModelAndView("../../showWishList");
		}
	}
	
}
*/