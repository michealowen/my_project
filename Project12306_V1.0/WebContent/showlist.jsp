<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>showticketList</title>
  </head>
  <body background=images/pureblue.jpg;>
   <script type="text/javascript" src="./js/jquery-1.4.2.js"></script>
		<script type="text/javascript" src="./js/station_name.js"></script>
		<script type="text/javascript" src="./js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
  function listtrain()
  {
	  
	  alert("ok");
	  
	  
	  
  $.ajax({  
      dataType:"json",         //数据类型为json格式
      contentType: "application/x-www-form-urlencoded; charset=GB18030", 
      type:"GET",  
      url:"list",  
      statusCode: {404: function() {  
           alert('page not found'); }  
        },
      success:function(data,textStatus){ 
   	    alert("ok");
   	    alert(data);
   	   $("#listTable tr:not(:first)").html(""); 
   	var city = new Array("北京","天津","石家庄","济南","郑州","商丘","西安","连云港","武汉","长沙","南昌","南京","上海","杭州","徐州");
  for (var i = 0;  i<data.length; i++){
  	          //alert("in");
    		  var row = $("#row").clone();
    		  var post=0;
    		  var postn=0;
    		  post = data[i].indexOf(",");
    	      row.find("#trainid").html(data[i].substring(0,post));
    	      //alert(data[i].substring(0,post));
    	      row.find("#start").html(city[i]);
    	      row.find("#arrive").html(city[i+3]);
    	      postn = post+1;
              post = data[i].indexOf(",",post+1);
    	      row.find("#starttime").html(data[i].substring(postn,post).substring(0,2)+':'+(data[i].substring(postn,post).substring(2,4)));
    	      postn = post+1;
              post = data[i].indexOf(",",post+1);
    	      row.find("#arrivetime").html(data[i].substring(postn,post));
    	      postn = post+1;
              post = data[i].indexOf(",",post+1);
              //alert(data[i].substring(postn,post));
    	      row.find("#utime").html(data[i].substring(postn,post));
    	      postn = post+1;
              post = data[i].indexOf(",",post+1);
    	      row.find("#money").html(data[i].substring(postn,post));
    	      postn = post+1;
              post = data[i].indexOf(",",post+1);
              row.find("#tickets").html(data[i].substring(postn,data[i].length));
    	      row.find("#te").html(" ");
    	      row.appendTo("#listTable");
  }
      }
      });
  }
  </script>
  <body>
  <center>
    <h2>车次信息</h2>
    <input type="button" value="列出所有信息" onclick="listtrain()">
    <s:form  method="post">
    	<table width="80%" border="0">
    		
			<tr id="row">
			<td id = "trainid"></td>
			<td id = "start"></td>
			<td id = "arrive"></td>
			<td id = "starttime"></td>
			<td id = "arrivetime"></td>
			<td id = "utime"></td>
			<td id = "money"></td>
			<td id = "tickets"></td>
			<td id = "te"></td>
            </tr>

    	</table>
    	<div class="t-list  mt10">
		<table width="80%" id="listTable">
			<thead>
				<tr style="text-align: center;">
					<th>车次</th>
					<th>出发站</th>
					<th>到达站</th>
					<th>出发时间</th>
					<th>到达时间</th>
					<th>历时</th>
					<th>票价</th>
					<th>余票</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody id="tbody"  style="text-align:center;">
			

			</tbody>
		</table>
		</div>
    </s:form>
  </center>
  </body>
</html>
