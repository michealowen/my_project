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
    <h2>添加车次信息</h2>
    <s:form  method="post">
    	<table width="320" border="0" bordercolor="purple" height="300">
    		<tr>
    			<td>车次</td>
    			<td><input type="text" name="Train_number" id="Train_number"  /></td>
    		</tr>
    		<tr>
    			<td>列车类型</td>
    			<td><input type="text" name="Train_type" id="Train_type" /></td>
    		</tr>
    		<tr>
    			<td>始发站</td>
    			<td><input type="text" name="Start_station" id="Start_station" /></td>
    		</tr>
    		<tr>
    			<td>终点站</td>
    			<td><input type="text" name="Term_station" id="Term_station" /></td>
    		</tr>
    		<tr>
    			<td>途径站</td>
    			<td><input type="text" name="Pass_station" id="Pass_station" /></td>
    		</tr>
    		
    		<tr>
    			<td>剩余票数</td>
    			<td><input type="text" name="Tickets"  id="Tickets"/></td>
    		</tr>
    		<tr>
    			<td>各站停留时间</td>
    			<td><input type="text" name="Waittime"  id="Waittime"/></td>
    		
    		<tr>
    			<td>始发时间</td>
    			<td><input type="text" name="Start_time" id="Start_time" /></td>
    		</tr>
    		<tr>
    			<td colspan="2" align="center"><input type="reset" value="重置" />
    			<input type="submit" value="添加"  onclick="add()"/>
    			<input type = "submit" value = "删除" onclick="deletetrain()">
    			</td>
    		</tr>
    	</table>
    </s:form>
    
    <input type = "button" value = "列出所有信息" onclick="listtrain()">
  </center>
  <script type="text/javascript" src="./js/jquery-1.4.2.js"></script>
		<script type="text/javascript" src="./js/station_name.js"></script>
		<script type="text/javascript" src="./js/My97DatePicker/WdatePicker.js"></script>
  <script type="text/javascript">
  function add(){
	  alert("ok");
	  var Train_number = document.getElementById("Train_number").value;
	  alert("ok");
	  var Train_type =   document.getElementById("Train_type").value;
	  alert("ok");
	  var Start_station=  document.getElementById("Start_station").value;
	  alert("ok");
	  var Term_station = document.getElementById("Term_station").value;
	  alert("ok");
	  var Pass_station = document.getElementById("Pass_station").value;
	  alert("ok");
	  var Tickets = document.getElementById("Tickets").value;
	  alert("ok");
	  var Waittime = document.getElementById("Waittime").value;
	  alert("ok");
	  var Start_time = document.getElementById("Start_time").value;
      alert("ok");
	  //alert(start+term+distance);
	  $.ajax({  
		    dataType:"json",         
		    data:{"Train_number":Train_number,"Train_type":Train_type,"Start_station":Start_station,
		    	"Term_station":Term_station,"Pass_station":Pass_station,"Tickets":Tickets,"Waittime":Waittime,"Start_time":Start_time},
		    contentType: "application/x-www-form-urlencoded; charset=GB18030", 
		    type:"GET",  
		    url:"trainMan",  
		    statusCode: {404: function() {  
		         alert('page not found'); }  
		      },      
		    success:function(data,textStatus){ 
		 	    alert("ok");
		 	    alert(data);
		 	 
		 	    
		 	    }
		    });
	  
  };
  function deletetrain(){
	  var Train_number = document.getElementById("Train_number").value;
	  $.ajax({  
		    dataType:"json",         
		    data:{"Train_number":Train_number},
		    contentType: "application/x-www-form-urlencoded; charset=GB18030", 
		    type:"GET",  
		    url:"delete",  
		    statusCode: {404: function() {  
		         alert('page not found'); }  
		      },      
		    success:function(data,textStatus){ 
		 	    alert("ok");
		 	    alert(data);
		 	 
		 	    
		 	    }
		    });
  };
  function listtrain(){
	  var a = 1;
	  alert("ok");
      alert(a);
      $.ajax({  
		    dataType:"json",         
		    //data:{"Train_number":Train_number},
		    contentType: "application/x-www-form-urlencoded; charset=GB18030", 
		    type:"GET",  
		    url:"list",  
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
