package com.example.HAJA.model.board.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class BoardDTO {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private int viewcnt;
	private String category;
	private String isrec;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private Date calendar;
	private String place;
	// 2022-10-19 String teamid 추가
	private String teamid; // member DB에서 구함
	// 2022-10-20 String show, tel, email 추가
	private String show; // board DB에 새로추가
	private String tel; // member DB에서 구함
	private String email; // member DB에서 구함
	
	// setter, getter
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getIsrec() {
		return isrec;
	}
	public void setIsrec(String isrec) {
		this.isrec = isrec;
	}
	public Date getCalendar() {
		return calendar;
	}
	public void setCalendar(Date calendar) {
		this.calendar = calendar;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getTeamid() {
		return teamid;
	}
	public void setTeamid(String teamid) {
		this.teamid = teamid;
	}
	public String getShow() {
		return show;
	}
	public void setShow(String show) {
		this.show = show;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	// constructor
	public BoardDTO() {}
	public BoardDTO(int bno, String title, String content, String writer, Date regdate, int viewcnt, String category,
			String isrec, Date calendar, String place, String teamid, String show, String tel, String email) {
		super();
		this.bno = bno;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.regdate = regdate;
		this.viewcnt = viewcnt;
		this.category = category;
		this.isrec = isrec;
		this.calendar = calendar;
		this.place = place;
		this.teamid = teamid;
		this.show = show;
		this.tel = tel;
		this.email = email;
	}
	// toString
	@Override
	public String toString() {
		return "BoardDTO [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer
				+ ", regdate=" + regdate + ", viewcnt=" + viewcnt + ", category=" + category + ", isrec=" + isrec
				+ ", calendar=" + calendar + ", place=" + place + ", teamid=" + teamid + ", show=" + show + ", tel="
				+ tel + ", email=" + email + "]";
	}
}
