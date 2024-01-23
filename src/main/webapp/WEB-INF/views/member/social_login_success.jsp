<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<script>
    alert("${social.type} 로그인 성공");
    location.href="${pageContext.request.contextPath}/mainpage/MainPage.jsp"
</script>