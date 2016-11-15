package com.remind.controller;

import org.springframework.web.multipart.MultipartFile;

public class MemberBean {
String m_no, m_name, m_bdate, m_email, m_gender, m_password, year, month, day, gender, m_image;
MultipartFile fileUp;

public String getYear() {
	return year;
}

public void setYear(String year) {
	this.year = year;
}

public String getMonth() {
	return month;
}

public void setMonth(String month) {
	this.month = month;
}

public String getDay() {
	return day;
}

public void setDay(String day) {
	this.day = day;
}

public String getM_no() {
	return m_no;
}

public void setM_no(String m_no) {
	this.m_no = m_no;
}

public String getM_name() {
	return m_name;
}

public void setM_name(String m_name) {
	this.m_name = m_name;
}

public String getM_bdate() {
	return m_bdate;
}

public void setM_bdate(String m_bdate) {
	this.m_bdate = m_bdate;
}

public String getM_email() {
	return m_email;
}

public void setM_email(String m_email) {
	this.m_email = m_email;
}

public String getM_gender() {
	return m_gender;
}

public void setM_gender(String m_gender) {
	this.m_gender = m_gender;
}

public String getM_password() {
	return m_password;
}

public void setM_password(String m_password) {
	this.m_password = m_password;
}

public MultipartFile getFileUp() {
	return fileUp;
}

public void setFileUp(MultipartFile fileUp) {
	this.fileUp = fileUp;
}

public String getM_image() {
	return m_image;
}

public void setM_image(String m_image) {
	this.m_image = m_image;
}

}
