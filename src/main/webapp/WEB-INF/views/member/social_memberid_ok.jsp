<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<script>

const form = document.createElement('form'); // form 태그 생성
form.setAttribute('method', 'post'); // 전송 방식 결정 (get or post)
form.setAttribute('action', 'social_memberid_update'); // 전송할 url 지정

let social = document.createElement('input'); //<input>
social.setAttribute('name', 'id');
social.setAttribute('value', ${social.id});

let social2 = document.createElement('input');
social2.setAttribute('name', 'type');
social2.setAttribute('value', ${social.id});

form.appendChild(social);
form.appendChild(social2);

document.body.appendChild(form);
form.submit();

opener.parent.fn_reload(); 
window.close();


</script>