<!-- 编写：刘琦     修改：刘继涛 -->

<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>车次信息维护</title>
  </head>
  
  <body background=images/pureblue.jpg;>
  <center>
  <s:actionerror/>
    <h2>添加车站信息</h2>
    <s:form  method="post">
    	

    			<td>始发站</td>
    			<td><input type="text" name="ticket.start" id="start" /></td>

    			<td>终点站</td>
    			<td><input type="text" name="ticket.end"  id="term"/></td>

    			<td>车站距离</td>
    			<td><input type="text" name="ticket.price" id="distance"/></td>
  
   
    			<td colspan="2" align="center"><input type="reset" value="重置" />
    			<input type="submit" value="添加"  onclick="add()"/></td>
    		
    	
    </s:form>
  </center>
  <script type="text/javascript" src="./js/jquery-1.4.2.js"></script>
		<script type="text/javascript" src="./js/station_name.js"></script>
		<script type="text/javascript" src="./js/My97DatePicker/WdatePicker.js"></script>
  <script type="text/javascript">
  function add(){
	  var start = document.getElementById("start").value;
	  var term =   document.getElementById("term").value;
	  var distance=  document.getElementById("distance").value;
	  alert(start+term+distance);
	  $.ajax({  
		    dataType:"json",         //数据类型为json格式
		    data:{"start":""+start+"","term":""+term+"","distance":distance},
		    contentType: "application/x-www-form-urlencoded; charset=GB18030", 
		    type:"GET",  
		    url:"stationMan",  
		    statusCode: {404: function() {  
		         alert('page not found'); }  
		      },      
		    success:function(data,textStatus){ 
		 	    alert("ok");
		 	    alert(data);
		 	 
		 	    
		 	    }
		    });
	  
  };
  
  </script>
  </body>
</html>