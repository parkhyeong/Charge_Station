package com.multi.tayotayo.mainpage;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;


@Service
public class ScheduleDataService {
	
	@Autowired
	private ScheduleDataDAO apiDAO;

	
	@Scheduled(fixedRate = 10800000)
	public void dataAPIupdate() {
		try {
			for (int i = 1; i <= 5; i++) {
				
				StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552584/EvCharger/getChargerInfo"); 
				urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=lIC1t/tCqX7uKc7GgEYtA6A/fzQvBjZFyDjbb4CZ9PkMxOcSq360wVN7E1auvVM1plBnfLCp6heGtHnOm4b9zw=="); 
				urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode(i+"", "UTF-8")); 
				urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("9999", "UTF-8")); 
				urlBuilder.append("&" + URLEncoder.encode("zcode","UTF-8") + "=" + URLEncoder.encode("11", "UTF-8")); 
				URL url = new URL(urlBuilder.toString());
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				conn.setRequestProperty("Content-type", "application/json");
				System.out.println("Response code: " + conn.getResponseCode());
				BufferedReader rd;
				if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				    rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				} else {
				    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
				}
				StringBuilder sb = new StringBuilder();
				String line;
				while ((line = rd.readLine()) != null) {
				    sb.append(line);
				}
				rd.close();
				conn.disconnect();
				
				JSONObject json1 = XML.toJSONObject(sb.toString());
				
				JSONObject body = json1.getJSONObject("response").getJSONObject("body");
				JSONArray items = body.getJSONObject("items").getJSONArray("item");
				
				List<DataVO> listDataVO = new ArrayList<>();
				
				for (int j = 0; j < items.length(); j++) {
					
					DataVO dataVO = new DataVO();
					

					dataVO.setChgerId(items.getJSONObject(j).get("chgerId") + "");
					dataVO.setStatId(items.getJSONObject(j).getString("statId"));
					dataVO.setStat(items.getJSONObject(j).getInt("stat"));
					
					listDataVO.add(dataVO);
				}
				System.out.println(listDataVO.size());
				apiDAO.apiUpdate(listDataVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}
}