<!-- ��д������     �޸ģ������� -->

<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>������Ϣά��</title>
  </head>
  
  <body background=images/pureblue.jpg;>
  <center>
  <s:actionerror/>
    <h2>��ӳ�վ��Ϣ</h2>
    <s:form  method="post">
    	

    			<td>ʼ��վ</td>
    			<td><input type="text" name="ticket.start" id="start" /></td>

    			<td>�յ�վ</td>
    			<td><input type="text" name="ticket.end"  id="term"/></td>

    			<td>��վ����</td>
    			<td><input type="text" name="ticket.price" id="distance"/></td>
  
   
    			<td colspan="2" align="center"><input type="reset" value="����" />
    			<input type="submit" value="���"  onclick="add()"/></td>
    		
    	
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
		    dataType:"json",         //��������Ϊjson��ʽ
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