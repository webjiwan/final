package com.example.HAJA.model.member.dto;

import java.util.Date;

public class ReportDTO {
	private int rno;
	private String send;
	private String receive;
	private String category;
	private String text;
	private Date regdate;
	
	// setter, getter
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getSend() {
		return send;
	}
	public void setSend(String send) {
		this.send = send;
	}
	public String getReceive() {
		return receive;
	}
	public void setReceive(String receive) {
		this.receive = receive;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	// constructor
	public ReportDTO() {}
	public ReportDTO(int rno, String send, String receive, String category, String text, Date regdate) {
		super();
		this.rno = rno;
		this.send = send;
		this.receive = receive;
		this.category = category;
		this.text = text;
		this.regdate = regdate;
	}
	
	// toString
	@Override
	public String toString() {
		return "ReportDTO [rno=" + rno + ", send=" + send + ", receive=" + receive + ", category=" + category
				+ ", text=" + text + ", regdate=" + regdate + "]";
	}
}
