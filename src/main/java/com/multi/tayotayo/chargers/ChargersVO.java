package com.multi.tayotayo.chargers;

public class ChargersVO {
	private String es_statId;	// 충전소ID
	private String es_gungoo;	// 충전소가 위치한 군/구
	private String es_addr;		// 충전소 주소
	private String es_statNm;	// 충전소 명칭
	private String es_faciL;	// 시설 대분류 ex)공공시설
	private String es_faciS;	// 시설 소분류 ex)주민센터
	private String es_dvcL;		// 충전기 급속/완속 구분
	private String es_dvcS;		// 충전기 세부 구분
	private String es_bnm;		// 기관명 ex) 환경부, 타기관
	private String es_busiNm;	// 운영기관명 ex) 환경부(협회), 한국EV충전서비스센터
	private String es_output;	// 충전기 출력 - kW, 누락된 경우가 많음
	private String es_chgerType;	// 충전기 종류 ex) AC완속, DC콤보
	private String es_limit;	// 이용자제한 여부
	private double es_lat;		// 위도
	private double es_lon;		// 경도
	private int row_no; //정렬 값 ROW_NUMBER() over(order by es_statNm)
	private int stat_count; //stat이 2인 개수 --> 충전가능한 충전기 개수
	
	
	public int getStat_count() {
		return stat_count;
	}

	public void setStat_count(int stat_count) {
		this.stat_count = stat_count;
	}

	public int getRow_no() {
		return row_no;
	}

	public void setRow_no(int row_no) {
		this.row_no = row_no;
	}

	public String getEs_statId() {
		return es_statId;
	}

	public void setEs_statId(String es_statId) {
		this.es_statId = es_statId;
	}

	public String getEs_gungoo() {
		return es_gungoo;
	}

	public void setEs_gungoo(String es_gungoo) {
		this.es_gungoo = es_gungoo;
	}

	public String getEs_addr() {
		return es_addr;
	}

	public void setEs_addr(String es_addr) {
		this.es_addr = es_addr;
	}

	public String getEs_statNm() {
		return es_statNm;
	}

	public void setEs_statNm(String es_statNm) {
		this.es_statNm = es_statNm;
	}

	public String getEs_faciL() {
		return es_faciL;
	}

	public void setEs_faciL(String es_faciL) {
		this.es_faciL = es_faciL;
	}

	public String getEs_faciS() {
		return es_faciS;
	}

	public void setEs_faciS(String es_faciS) {
		this.es_faciS = es_faciS;
	}

	public String getEs_dvcL() {
		return es_dvcL;
	}

	public void setEs_dvcL(String es_dvcL) {
		this.es_dvcL = es_dvcL;
	}

	public String getEs_dvcS() {
		return es_dvcS;
	}

	public void setEs_dvcS(String es_dvcS) {
		this.es_dvcS = es_dvcS;
	}

	public String getEs_bnm() {
		return es_bnm;
	}

	public void setEs_bnm(String es_bnm) {
		this.es_bnm = es_bnm;
	}

	public String getEs_busiNm() {
		return es_busiNm;
	}

	public void setEs_busiNm(String es_busiNm) {
		this.es_busiNm = es_busiNm;
	}

	public String getEs_output() {
		return es_output;
	}

	public void setEs_output(String es_output) {
		this.es_output = es_output;
	}

	public String getEs_chgerType() {
		return es_chgerType;
	}

	public void setEs_chgerType(String es_chgerType) {
		this.es_chgerType = es_chgerType;
	}

	public String getEs_limit() {
		return es_limit;
	}

	public void setEs_limit(String es_limit) {
		this.es_limit = es_limit;
	}

	public double getEs_lat() {
		return es_lat;
	}

	public void setEs_lat(double es_lat) {
		this.es_lat = es_lat;
	}

	public double getEs_lon() {
		return es_lon;
	}

	public void setEs_lon(double es_lon) {
		this.es_lon = es_lon;
	}

	@Override
	public String toString() {
		return "ChargersVO [es_statId=" + es_statId + ", es_gungoo=" + es_gungoo + ", es_addr=" + es_addr
				+ ", es_statNm=" + es_statNm + ", es_faciL=" + es_faciL + ", es_faciS=" + es_faciS + ", es_dvcL="
				+ es_dvcL + ", es_dvcS=" + es_dvcS + ", es_bnm=" + es_bnm + ", es_busiNm=" + es_busiNm + ", es_output="
				+ es_output + ", es_chgerType=" + es_chgerType + ", es_limit=" + es_limit + ", es_lat=" + es_lat
				+ ", es_lon=" + es_lon + ", row_no=" + row_no + ", stat_count=" + stat_count + "]";
	}

 




}
