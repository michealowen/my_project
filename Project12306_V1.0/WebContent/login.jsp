<!--编写：刘琦    修改：刘继涛  -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>login</title>
<style type="text/css">
<!--
#apDiv1{
position:absolute;
top:280px;
left:500px;
}
-->

body{
background-repeat: no-repeat;
background-attachment:fixed;
background-position: top center;

}

</style>
</head>
<body background=images/pureblue.jpg;>
<div id="apDiv1">
	<form action="login" method="post">
	<table border="0" cellspacing="0">
	<tr>
		<td>账号：</td>
		<td><input name="account" id="account" type="text"></td>
	</tr>
	<tr>
     <td></td>
     <td></td>
    </tr>
	<tr>
		<td>密码：</td>
		<td><input name="password" id="password" type="text"></td> 
	</tr>
	<tr>
     <td></td>
     <td></td>
   </tr>
   </table>
		<input type="submit" value="登录"/>
		<input type="button" value="管理员登陆"/>
		<input type="reset" id="reset"  onclick="reset()" value ="清空"/>

	</form>
</div>
</body>
</html>