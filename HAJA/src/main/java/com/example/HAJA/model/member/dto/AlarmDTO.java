package com.example.HAJA.model.member.dto;

import java.util.Date;

public class AlarmDTO {
	private int ano;
	private int bno;
	private String userid;
	private String alarmtext;
	private String isview;
	private Date regdate;
	// setter, getter
	public int getAno() {
		return ano;
	}
	public void setAno(int ano) {
		this.ano = ano;
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
	public String getAlarmtext() {
		return alarmtext;
	}
	public void setAlarmtext(String alarmtext) {
		this.alarmtext = alarmtext;
	}
	public String getIsview() {
		return isview;
	}
	public void setIsview(String isview) {
		this.isview = isview;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	// constructor
	public AlarmDTO() {}
	public AlarmDTO(int ano, int bno, String userid, String alarmtext, String isview, Date regdate) {
		super();
		this.ano = ano;
		this.bno = bno;
		this.userid = userid;
		this.alarmtext = alarmtext;
		this.isview = isview;
		this.regdate = regdate;
	}
	// toString
	@Override
	public String toString() {
		return "AlarmDTO [ano=" + ano + ", bno=" + bno + ", userid=" + userid + ", alarmtext=" + alarmtext + ", isview="
				+ isview + ", regdate=" + regdate + "]";
	}
}
