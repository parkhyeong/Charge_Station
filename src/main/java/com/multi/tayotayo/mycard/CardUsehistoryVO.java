package com.multi.tayotayo.mycard;

import java.util.Date;

public class CardUsehistoryVO {
	private int payment_amount;
	private int payment_point;
	private float charge_amount;
	private Double charge_time;
	private Date charge_day;
	private String mcard_num;
	private String station_name;
	private boolean refunded;
	private Long transaction_id;
	
	
	public int getPayment_amount() {
		return payment_amount;
	}
	public void setPayment_amount(int payment_amount) {
		this.payment_amount = payment_amount;
	}
	public int getPayment_point() {
		return payment_point;
	}
	public void setPayment_point(int payment_point) {
		this.payment_point = payment_point;
	}
	public float getCharge_amount() {
		return charge_amount;
	}
	public void setCharge_amount(float charge_amount) {
		this.charge_amount = charge_amount;
	}
	public Double getCharge_time() {
		return charge_time;
	}
	public void setCharge_time(Double charge_time) {
		this.charge_time = charge_time;
	}
	public Date getCharge_day() {
		return charge_day;
	}
	public void setCharge_day(Date charge_day) {
		this.charge_day = charge_day;
	}
	public String getMcard_num() {
		return mcard_num;
	}
	public void setMcard_num(String mcard_num) {
		this.mcard_num = mcard_num;
	}
	
	public String getStation_name() {
		return station_name;
	}
	public void setStation_name(String station_name) {
		this.station_name = station_name;
	}
	
	public boolean isRefunded() {
		return refunded;
	}
	public void setRefunded(boolean refunded) {
		this.refunded = refunded;
	}
	
	public Long getTransaction_id() {
		return transaction_id;
	}
	public void setTransaction_id(Long transaction_id) {
		this.transaction_id = transaction_id;
	}
	@Override
	public String toString() {
		return "CardUsehistoryVO [payment_amount=" + payment_amount + ", payment_point=" + payment_point
				+ ", charge_amount=" + charge_amount + ", charge_time=" + charge_time + ", charge_day=" + charge_day
				+ ", mcard_num=" + mcard_num + ", station_name=" + station_name + ", refunded=" + refunded
				+ ", transaction_id=" + transaction_id + "]";
	}
}
