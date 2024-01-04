package com.multi.tayotayo.mycard;

import java.util.Date;

public class MembershipVO {
	private String car_kind;
    private String car_model;
    private String car_number;
    private String card_reason;
    private String card_addr;
    private String card_num;
    private int card_point;
    private String c_memberid;
    private Date card_signday;
    private int card_balance;
	public String getCar_kind() {
		return car_kind;
	}
	public void setCar_kind(String car_kind) {
		this.car_kind = car_kind;
	}
	public String getCar_model() {
		return car_model;
	}
	public void setCar_model(String car_model) {
		this.car_model = car_model;
	}
	public String getCar_number() {
		return car_number;
	}
	public void setCar_number(String car_number) {
		this.car_number = car_number;
	}
	public String getCard_reason() {
		return card_reason;
	}
	public void setCard_reason(String card_reason) {
		this.card_reason = card_reason;
	}
	public String getCard_addr() {
		return card_addr;
	}
	public void setCard_addr(String card_addr) {
		this.card_addr = card_addr;
	}
	public String getCard_num() {
		return card_num;
	}
	public void setCard_num(String card_num) {
		this.card_num = card_num;
	}
	public int getCard_point() {
		return card_point;
	}
	public void setCard_point(int card_point) {
		this.card_point = card_point;
	}
	public String getC_memberid() {
		return c_memberid;
	}
	public void setC_memberid(String c_memberid) {
		this.c_memberid = c_memberid;
	}
	
	public Date getCard_signday() {
		return card_signday;
	}
	public void setCard_signday(Date card_signday) {
		this.card_signday = card_signday;
	}
	public int getCard_balance() {
		return card_balance;
	}
	public void setCard_balance(int card_balance) {
		this.card_balance = card_balance;
	}
	@Override
	public String toString() {
		return "MembershipVO [car_kind=" + car_kind + ", car_model=" + car_model + ", car_number=" + car_number
				+ ", card_reason=" + card_reason + ", card_addr=" + card_addr + ", card_num=" + card_num
				+ ", card_point=" + card_point + ", c_memberid=" + c_memberid + ", card_signday=" + card_signday
				+ ", card_balance=" + card_balance + "]";
	}
    
}
