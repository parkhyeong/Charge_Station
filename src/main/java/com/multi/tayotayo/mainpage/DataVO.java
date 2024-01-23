package com.multi.tayotayo.mainpage;

public class DataVO {
	private String chgerId;
	private String statId;
	private int stat;
	public String getChgerId() {
		return chgerId;
	}
	public void setChgerId(String chgerId) {
		this.chgerId = chgerId;
	}
	public String getStatId() {
		return statId;
	}
	public void setStatId(String statId) {
		this.statId = statId;
	}
	
	public int getStat() {
		return stat;
	}
	public void setStat(int stat) {
		this.stat = stat;
	}
	@Override
	public String toString() {
		return "DataVO [chgerId=" + chgerId + ", statId=" + statId + ", stat=" + stat + "]";
	}
	
	
 
	
}

	