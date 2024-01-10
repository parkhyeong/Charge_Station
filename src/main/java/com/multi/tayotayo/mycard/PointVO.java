package com.multi.tayotayo.mycard;

import java.util.Date;

public class PointVO {
	private String card_num;
    private int card_point;
    private int used_point;
    private Date point_day;
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
	public int getUsed_point() {
		return used_point;
	}
	public void setUsed_point(int used_point) {
		this.used_point = used_point;
	}
	public Date getPoint_day() {
		return point_day;
	}
	public void setPoint_day(Date point_day) {
		this.point_day = point_day;
	}
	@Override
	public String toString() {
		return "PointVO [card_num=" + card_num + ", card_point=" + card_point + ", used_point=" + used_point
				+ ", point_day=" + point_day + "]";
	}
}
