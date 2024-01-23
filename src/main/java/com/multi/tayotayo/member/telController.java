package com.multi.tayotayo.member;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Balance;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.model.StorageType;
import net.nurigo.sdk.message.request.MessageListRequest;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.MessageListResponse;
import net.nurigo.sdk.message.response.MultipleDetailMessageSentResponse;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

@Controller
public class telController {

	@Autowired
	MemberService memberservice;
	
	@Autowired
	MailService mailservice;
	
    @Autowired
    private RedisExample redisUtil;
	
    final DefaultMessageService messageService;

    public telController() {
        // 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
        this.messageService = NurigoApp.INSTANCE.initialize("NCSYIFQI0SK33I5L", "DQILD7HQRCDF1BVLRSUVURKX8YWPNR9G", "https://api.coolsms.co.kr");
    }

    /**
     * 메시지 조회 예제
     */
    @GetMapping("/get-message-list")
    public MessageListResponse getMessageList() {
        // 검색 조건이 있는 경우에 MessagListRequest를 초기화 하여 getMessageList 함수에 파라미터로 넣어서 검색할 수 있습니다!.
        // 수신번호와 발신번호는 반드시 -,* 등의 특수문자를 제거한 01012345678 형식으로 입력해주셔야 합니다!
        MessageListRequest request = new MessageListRequest();

        // 검색할 건 수, 값 미지정 시 20건 조회, 최대 500건 까지 설정 가능
        // request.setLimit(1);

        // 조회 후 다음 페이지로 넘어가려면 조회 당시 마지막의 messageId를 입력해주셔야 합니다!
        // request.setStartKey("메시지 ID");

        // request.setTo("검색할 수신번호");
        // request.setFrom("검색할 발신번호");

        // 메시지 상태 검색, PENDING은 대기 건, SENDING은 발송 중,COMPLETE는 발송완료, FAILED는 발송에 실패한 모든 건입니다.
        /*
        request.setStatus(MessageStatusType.PENDING);
        request.setStatus(MessageStatusType.SENDING);
        request.setStatus(MessageStatusType.COMPLETE);
        request.setStatus(MessageStatusType.FAILED);
        */

        // request.setMessageId("검색할 메시지 ID");

        // 검색할 메시지 목록
        /*
        ArrayList<String> messageIds = new ArrayList<>();
        messageIds.add("검색할 메시지 ID");
        request.setMessageIds(messageIds);
         */

        // 조회 할 메시지 유형 검색, 유형에 대한 값은 아래 내용을 참고해주세요!
        // SMS: 단문
        // LMS: 장문
        // MMS: 사진문자
        // ATA: 알림톡
        // CTA: 친구톡
        // CTI: 이미지 친구톡
        // NSA: 네이버 스마트알림
        // RCS_SMS: RCS 단문
        // RCS_LMS: RCS 장문
        // RCS_MMS: RCS 사진문자
        // RCS_TPL: RCS 템플릿문자
        // request.setType("조회 할 메시지 유형");

        return this.messageService.getMessageList(request);
    }

    /**
     * 단일 메시지 발송 예제
     */
    @ResponseBody
    @PostMapping("member/send-one")
    public int sendOne(MemberVO memberVO) {
    	System.out.println(memberVO);
    	try {
			MemberVO memberVOconfirm = memberservice.id_find_to_tel(memberVO);
			String authCode = mailservice.createdCode();  
			
    	if ( memberVO.getName().equals(memberVOconfirm.getName())
				&& memberVO.getTel().equals(memberVOconfirm.getTel())) {
			 Message message = new Message();
		        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
		        message.setFrom("01040364479");
		        message.setTo(memberVO.getTel());
		        message.setText("전기차 타요타요를 방문해주셔서 감사합니다. 인증 번호는 " + authCode + "입니다. 해당 인증번호를 인증번호 확인란에 기입하여 주세요.");
		        System.out.println(authCode);
		        //SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
		        //System.out.println(response);
		        
				redisUtil.setDataExpire(memberVO.getTel(), authCode);

			return 1;
		} else {
			return 0;
		}
	} catch (Exception e) {
		e.printStackTrace();
		return 0;
	}
	
    }
    
	//전화번호 인증번호 일치여부 검사
	@ResponseBody
	@RequestMapping(value = "member/telauthCodeAuth", method = RequestMethod.POST)
	public String telauthCodeAuth(MemberVO memberVO, String inputCode) {
        
		if (mailservice.telverifyEmailCode(memberVO, inputCode)) {
			return "ok";
		}
		return "x";
	}
    

}
