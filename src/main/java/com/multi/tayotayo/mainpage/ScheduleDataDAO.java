package com.multi.tayotayo.mainpage;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ScheduleDataDAO {

	@Autowired
	private SqlSessionTemplate my;
	
	public void apiUpdate(List<DataVO> listDataVO) {
		
		try {
			my.update("data.apiUpdate", listDataVO);
			
		} catch (Exception e) {
			System.out.println(e + "에러메세지");
		}
	}
	
	public void apiUpdateTest(DataVO dataVO) {
		try {
			
			if (dataVO != null) {
				
				System.out.println("null 아님");
				my.update("data.apiUpdateTest", dataVO);
			} else {
				System.out.println("null 발생");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
