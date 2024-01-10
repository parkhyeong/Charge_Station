package com.multi.tayotayo.notice;

import java.util.Date;

public class NoticeVO {
	private int n_no;
	private int n_num;
	private String n_title;
	private String n_content;
	private Date n_date;
	private String n_id;
	private String type;
	private String keyword;
	public int getN_no() {
		return n_no;
	}
	public void setN_no(int n_no) {
		this.n_no = n_no;
	}
	public int getN_num() {
		return n_num;
	}
	public void setN_num(int n_num) {
		this.n_num = n_num;
	}
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	public String getN_content() {
		return n_content;
	}
	public void setN_content(String n_content) {
		this.n_content = n_content;
	}
	public Date getN_date() {
		return n_date;
	}
	public void setN_date(Date n_date) {
		this.n_date = n_date;
	}
	public String getN_id() {
		return n_id;
	}
	public void setN_id(String n_id) {
		this.n_id = n_id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	@Override
	public String toString() {
		return "NoticeVO [n_no=" + n_no + ", n_num=" + n_num + ", n_title=" + n_title + ", n_content=" + n_content
				+ ", n_date=" + n_date + ", n_id=" + n_id + ", type=" + type + ", keyword=" + keyword + "]";
	}
}
