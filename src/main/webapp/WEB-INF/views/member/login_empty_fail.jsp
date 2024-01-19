<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<script>
	alert('로그인이 되어 있지 않습니다.');
	location.href='${pageContext.request.contextPath}/member/login_form';
</script>