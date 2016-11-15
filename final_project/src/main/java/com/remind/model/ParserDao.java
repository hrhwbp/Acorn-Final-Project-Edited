package com.remind.model;

import org.springframework.stereotype.Component;

import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.util.ArrayList;

import java.net.URL;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

@Component
public class ParserDao implements ParserDaoInter {

	public ArrayList<ParserDto> getData(String bean) {

		ArrayList<ParserDto> list = new ArrayList<ParserDto>();
		
		/*URL url;					아마존의 경우 웹 크롤링을 소프트웨어로 보호하기에 안됨
	    InputStream is = null;
	    DataInputStream dis;
	    String line = null;
	    try {
	        url = new URL(bean);
	        is = url.openStream();  // throws an IOException
	        dis = new DataInputStream(new BufferedInputStream(is));
	        
	        while ((line = dis.readLine()) != null) {
	            System.out.println(line);
	        }
	        
	    } catch (MalformedURLException mue) {
	         mue.printStackTrace();
	    } catch (IOException ioe) {
	         ioe.printStackTrace();
	    } finally {
	        try {
	            is.close();
	        } catch (IOException ioe) {
	            // nothing to see here
	        }
	    }*/
		
		try {
			
			ParserDto dto = new ParserDto();
			
			Document doc = Jsoup.connect(bean).get();	//(line, "utf-8");     //Jsoup.connect(bean).get(); // "view-source:" +
			
			Elements titleelem = doc.select("title");
			Elements priceelem = doc.select("[itemprop*=price]");

			Elements priceelem2 = doc.select("[class*=price]"); // span[id*=price]    codi_01n.jpg  

			Elements imageelem3 = doc.select("[class*=Img] [src$=jpg]");
			Elements imageelem = doc.select("[id*=Image] [src$=jpg]");// [src$=jpg]
			Elements imageelem2 = doc.select("[id*=img] [src$=jpg]");
			
			
			//System.out.println(imageelem.text() + "@@@@@@@ ");
			//System.out.println(imageelem2.text() + "@@@@@@@ ");
			
			
			Element irum = null;
			Element cost = null;
			Element image = null;
			
			//System.out.println(titleelem.text() + "$$$$$");
			//상품명 Parsing	
			if( !titleelem.get(0).attr("title").toString().equals(null)){
				//classelem.get(i).attr("class").toString().equals(doc.select("[class*=produ]").get(j).attr("class").toString())
				
				System.out.println(titleelem.get(0).text() + "~~~!~!~!");
				irum = titleelem.get(0);
				dto.setName(irum.text());
			}
			
			//상품 가격 Parsing
			if(priceelem.size() > 0){
				for (int j = 0; j < priceelem.size(); j++) {
					if((!priceelem.get(j).attr("class").toString().equals(null) || 
							!priceelem.get(j).equals(null))){
						System.out.println(priceelem.get(j).text() + "~~~!~");
						
						cost = priceelem.get(j);
						if(dto.getPrice()==null){
							System.out.println("없음");
							System.out.println(cost.text());
							dto.setPrice(cost.text());	
						}else{
							System.out.println("있음");
						}
					}
				}
			}else if(priceelem2.size() > 0){
				for (int j = 0; j < priceelem2.size(); j++) {
					if((!priceelem2.get(j).attr("class").toString().equals(null) || 
							!priceelem2.get(j).equals(null))){
						System.out.println(priceelem2.get(j).text() + "~~~!~");
						
						cost = priceelem2.get(j);
						if(dto.getPrice()==null){
							System.out.println("없음");
							System.out.println(cost.text());
							dto.setPrice(cost.text());	
						}else{
							System.out.println("있음");
						}
					}
				}
			}
			
			
			
			//상품 이미지 주소 Parsing
			if(imageelem3.size() > 0){
				for (int i = 0; i < imageelem3.size(); i++) {
					if( !imageelem3.get(i).attr("id").toString().equals(null) ||
							!imageelem3.get(i).equals(null)){
						System.out.println(imageelem3.get(i).text() + "~~~!~");
						
						
						//imageelem.get(i).attr("src").toString();
						image = imageelem3.get(i);
						System.out.println(imageelem3.get(i).attr("src").toString() + "~~~!~!~!");
						
						if(dto.getImage()==null){
							System.out.println("이미지 없음");
							System.out.println(image.text());
							dto.setImage(imageelem3.get(i).attr("src").toString());
						}else{
							System.out.println("이미지 있음");
						}
					}
				}
				
			}else if(imageelem.size() > 0) {
				for (int i = 0; i < imageelem.size(); i++) {
					if( !imageelem.get(i).attr("id").toString().equals(null) ||
							!imageelem.get(i).equals(null)){
						System.out.println(imageelem.get(i).text() + "~~~!~");
						//imageelem.get(i).attr("src").toString();
						image = imageelem.get(i);
						System.out.println(imageelem.get(i).attr("src").toString() + "~~~!~!~!");
						
						if(dto.getImage()==null){
							System.out.println("이미지 없음");
							System.out.println(image.text());
							dto.setImage(imageelem.get(i).attr("src").toString());
						}else{
							System.out.println("이미지 있음");
						}
					}
				}
			}else if(imageelem2.size() > 0) {
				for (int i = 0; i < imageelem2.size(); i++) {
					if( !imageelem2.get(i).attr("id").toString().equals(null) ||
							!imageelem2.get(i).equals(null)){
						System.out.println(imageelem2.get(i).text() + "~~~!~");
						//imageelem.get(i).attr("src").toString();
						image = imageelem2.get(i);
						System.out.println(imageelem2.get(i).attr("src").toString() + "~~~!~!~!");
						
						if(dto.getImage()==null){
							System.out.println("이미지 없음");
							System.out.println(image.text());
							dto.setImage(imageelem2.get(i).attr("src").toString());
						}else{
							System.out.println("이미지 있음");
						}
					}
				}
			}
			list.add(dto);
			System.out.println(dto.getName() + "~~~~" + dto.getPrice() + " " + dto.getImage());

		} catch (Exception e) {
			System.out.println("에러당 : " + e);
		}

		return list;
	}

}
