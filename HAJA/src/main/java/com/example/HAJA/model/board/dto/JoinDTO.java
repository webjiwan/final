package com.example.HAJA.model.board.dto;

import java.util.Date;

public class JoinDTO {
	private int jno;
	private int bno;
	private String userid;
	private String userid2;
	private String ismatch;
	private String teamid; // member Table에서 구함
	private String tel; // member Table에서 구함
	private String email; // member Table에서 구함
	private String title; // board Table에서 구함
	private String place; // board Table에서 구함
	private Date calendar; // board Table에서 구함
	// getter, setter
	public int getJno() {
		return jno;
	}
	public void setJno(int jno) {
		this.jno = jno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserid2() {
		return userid2;
	}
	public void setUserid2(String userid2) {
		this.userid2 = userid2;
	}
	public String getIsmatch() {
		return ismatch;
	}
	public void setIsmatch(String ismatch) {
		this.ismatch = ismatch;
	}
	public String getTeamid() {
		return teamid;
	}
	public void setTeamid(String teamid) {
		this.teamid = teamid;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public Date getCalendar() {
		return calendar;
	}
	public void setCalendar(Date calendar) {
		this.calendar = calendar;
	}
	// constructor
	public JoinDTO() {}
	public JoinDTO(int jno, int bno, String userid, String userid2, String ismatch, String teamid, String tel,
			String email, String title, String place, Date calendar) {
		super();
		this.jno = jno;
		this.bno = bno;
		this.userid = userid;
		this.userid2 = userid2;
		this.ismatch = ismatch;
		this.teamid = teamid;
		this.tel = tel;
		this.email = email;
		this.title = title;
		this.place = place;
		this.calendar = calendar;
	}
	// toString
	@Override
	public String toString() {
		return "JoinDTO [jno=" + jno + ", bno=" + bno + ", userid=" + userid + ", userid2=" + userid2 + ", ismatch="
				+ ismatch + ", teamid=" + teamid + ", tel=" + tel + ", email=" + email + ", title=" + title + ", place="
				+ place + ", calendar=" + calendar + "]";
	}
}
