package com.example.HAJA.model.member.dto;

import java.util.Date;

public class MessageDTO {
	private int mno;
	private String send;
	private String receive;
	private String text;
	private Date regdate;
	private String isview;
	// setter, getter
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
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
	public String getIsview() {
		return isview;
	}
	public void setIsview(String isview) {
		this.isview = isview;
	}
	// constructor
	public MessageDTO() {}
	public MessageDTO(int mno, String send, String receive, String text, Date regdate, String isview) {
		super();
		this.mno = mno;
		this.send = send;
		this.receive = receive;
		this.text = text;
		this.regdate = regdate;
		this.isview = isview;
	}
	// toString
	@Override
	public String toString() {
		return "MessageDTO [mno=" + mno + ", send=" + send + ", receive=" + receive + ", text=" + text + ", regdate="
				+ regdate + ", isview=" + isview + "]";
	}
	
}
