<!--编写:刘继涛，刘琦         修改：刘继涛，刘琦-->

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<Meta http-equiv="Content-Type" Content="text/html; Charset=utf-8">
		<title>12306登录</title>
<style type="text/css">
.clearfix:after {
    clear: both;
    content: ".";
    display: block;
    height: 0;
    visibility: hidden;
}
.lay-sear-yp {
    height: 40px;
    margin-top: 10px;
}
.lay-sear {
    background: none repeat scroll 0 0 #EEF1F8;
    border: 1px solid #298CCE;
    border-radius: 3px;
    font-size: 14px;
    height: 40px;
    margin: 10px 0 10px;
    padding: 7px 0;
    position: relative;
}
.clearfix {
    display: block;
}
.inp-txt {
    background: none repeat scroll 0 0 #FFFFFF;
    border: 1px solid #CFCDC7;
    color: #999999;
    height: 35px;
    line-height: 18px;
    padding: 5px 0 5px 5px;
    width: 193px;
}
.btn122s {
    width: 122px;
    background-position: 0 0;
    color: #FFFFFF;
    height: 30px;
    line-height: 30px;
    background: url("./images/bg_btn.png") repeat-x scroll 0 0 rgba(0, 0, 0, 0);
    border-radius: 4px;
    color: #333333;
    display: inline-block;
    text-align: center;
    text-decoration: none;
    color: white;
}
.t-list {
border: 1px solid #298cce;
}
.mt10 {
margin-top: 10px;
}
table {
	table-layout: fixed;
	word-wrap: break-word;
	margin-top: 0;
	background: url(./images/bg_tlisthd.png) top repeat-x;
	border-collapse: collapse;
	border-spacing: 0;
}
thead {
	display: table-header-group;
	vertical-align: middle;
	border-color: inherit;
}
.t-list th {
	height: 52px;
	background: url(./images/line_tlisth.png) right center no-repeat;
	color: #fff;
	overflow: hidden;
}
.t-list td {
	border-right: 1px solid #b0cedd;
	border-top: 1px solid #b0cedd;
	color: #999;
	height: 36px;
	padding: 2px 0;
	text-align: center;
}
div.dhx_modal_cover {
	border: currentColor;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	_height: 0;
	_overflow: hidden;
	position: fixed;
	filter: alpha(opacity=50);
	opacity: .5;
	z-index: 19999;
	cursor: default;
	zoom: 1;
	background-color: rgba(0,0,0,0.09);
}


.sear-sel-bd {
	border: 1px solid #3391d0;
	height: 44px;
	overflow: hidden;
	position: relative;
	padding: 3px 0;
}
</style>
		<script type="text/javascript" src="./js/jquery-1.4.2.js"></script>
		<script type="text/javascript" src="./js/station_name.js"></script>
		<script type="text/javascript" src="./js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function getdate()
{
	var now=new Date();
	y=now.getFullYear();
	m=now.getMonth()+1;           //JS中月份从零开始
	d=now.getDate();              //返回当前月份的日期
	m=m<10?"0"+m:m;               //月份规格化
	d=d<10?"0"+d:d;               //日期规格化
	return y+"-"+m+"-"+d;
} 
function enddate(){
	var endDate = new Date();
	endDate.setDate(endDate.getDate()+19);     //设置为了19天后的日期
	y=endDate.getFullYear();         
	m=endDate.getMonth()+1;        
	d=endDate.getDate();          
	m=m<10?"0"+m:m;
	d=d<10?"0"+d:d;
	return y+"-"+m+"-"+d;
}
$(document).ready(function(){
	$('#train_start_date').click(function(){
			WdatePicker({doubleCalendar:true,dateFmt:'yyyy-MM-dd',minDate:getdate(),maxDate:enddate()});
	});
	$('#train_start_date').val(getdate());
	var listTableWidth = $('#listTable').width();
	$('#floatTable').width(listTableWidth);
	$(window).resize(function(){  //窗口改变大小事件
   		var listTableWidth = $('#listTable').width();
		$('#floatTable').width(listTableWidth);
	});
	$(window).scroll(function () {  //鼠标滚轮事件
		var listTableWidth = $('#listTable').width();
		$('#floatTable').width(listTableWidth);
		var scrollPos;
		if (window.pageYOffset) {
			scrollPos = window.pageYOffset; 
		}else if (document.compatMode && document.compatMode != 'BackCompat')
		{ 
			scrollPos = document.documentElement.scrollTop; 
		}else if (document.body) { 
			scrollPos = document.body.scrollTop; 
		}
		if(scrollPos>155){
			$('#floatTable').css('display','block');
		}else{
			$('#floatTable').css('display','none');
		}
	});
})
function searchTrain(type)
{
	var fromStationText = $('#fromStationText').val();  //出发地
	var toStationText = $('#toStationText').val();  //目的地
	var train_start_date = $('#train_start_date').val();  //出发日
	if(fromStationText == '' ){
		alert("出发地不能为空!");
		$('#fromStationText').focus();         //光标置于出发点输入框
		return;
	}
	if(toStationText == ''){
		alert('目的地不能为空!');
		$('#toStationText').focus();
		return;
	}
	if(train_start_date == ''){
		alert('出发日不能为空!');
		$('#train_start_date').focus();
		return;
	}
	if(station_names.indexOf(fromStationText)<0)
	{
		alert("请输入正确的出发地!");
		$('#fromStationText').focus();
		$('#fromStationText').select();
		return;
	}
	if(station_names.indexOf(toStationText)<0)
	{
		alert("请输入正确的目的地!");
		$('#toStationText').focus();
		$('#toStationText').select();
		return;
	}
	//alert(fromStationText+toStationText);

/*var a='a';
var b='a';
var city = new Array("北京","天津","石家庄","济南","郑州","商丘","西安","连云港","武汉","长沙","南昌","南京","上海","杭州","徐州");
var num = new Array('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o');
alert('o');
for(var i = 0;i<city.length;i++)
	{
	alert('1');
	if(fromStationText==city[i]){
		a=num[i];
	    break;
	}
	}
for(var i = 0;i<city.length;i++)
{
    if(toStationText==city[i]){
	    b=num[i];
	    break;
}
}
alert(a+b);
*/

$.ajax({  
    dataType:"json",         //数据类型为json格式
    data:{"start":fromStationText,"term":toStationText},
    //data:{"start":a,"term":b},
    contentType: "application/x-www-form-urlencoded; charset=utf-8", 
    type:"POST",  
    url:"findpath",  
    statusCode: {404: function() {  
         alert('page not found'); }  
      },
    success:function(data,textStatus){ 
 	    //alert("ok");
 	    //alert(data);
 	   $("#listTable tr:not(:first)").html(""); 
for (var i = 0;  i<data.length; i++){
	      //alert("in");
  		  var row = $("#row").clone();
  		  var post=0;
  		  var postn=0;
  		  post = data[i].indexOf(",");
  	      row.find("#trainid").html(data[i].substring(0,post));
  	      //alert(data[i].substring(0,post));
  	      row.find("#start").html(fromStationText);
  	      row.find("#arrive").html(toStationText);
  	      postn = post+1;
          post = data[i].indexOf(",",post+1);
  	      row.find("#starttime").html(data[i].substring(postn,post).substring(0,2)%24+':'+(data[i].substring(postn,post).substring(2,4)));
  	      postn = post+1;
          post = data[i].indexOf(",",post+1);
  	      //row.find("#arrivetime").html(data[i].substring(postn,post));
  	      row.find("#arrivetime").html(data[i].substring(postn,post).substring(0,2)%24+':'+(data[i].substring(postn,post).substring(2,4)));
  	      postn = post+1;
          post = data[i].indexOf(",",post+1);
          //alert(data[i].substring(postn,post));
  	      //row.find("#utime").html(data[i].substring(postn,post));
  	      row.find("#utime").html(parseInt(data[i].substring(postn,post)/100)+':'+(data[i].substring(postn,post)%100));
  	      postn = post+1;
          post = data[i].indexOf(",",post+1);
  	      row.find("#money").html(data[i].substring(postn,post));
  	      postn = post+1;
          post = data[i].indexOf(",",post+1);
          row.find("#tickets").html(data[i].substring(postn,post));
          //row.find("#tickets").html(data[i].substring(postn,data[i].length));
          postn = post+1;
          post = data[i].indexOf(",",post+1);
  	      row.find("#te").html(data[i].substring(postn,data[i].length));
  	      row.appendTo("#listTable");
  	    }
  
    }
    });

}
</script>
	</head>

	<body>
		<div class="lay-sear lay-sear-yp clearfix" style="text-align: center;">
			出发地：
			<input type="text" value="" class="inp-txt" id="fromStationText" maxlength="15">&nbsp;&nbsp;
			目的地：
			<input type="text" value="" class="inp-txt" id="toStationText" maxlength="15">&nbsp;&nbsp;
			出发日：
			<input type="text" value="" class="inp-txt" id="train_start_date" maxlength="15">&nbsp;&nbsp;
			<a shape="rect" class="btn122s" href="javascript:void(0);" onclick="searchTrain('ADULT')">查询</a>&nbsp;&nbsp;
			<a shape="rect" class="btn122s" href="javascript:void(0);" onclick="searchTrain('0X00')">查询学生票</a>
		</div>
		<div class="sear-sel-bd" id="sear-sel-bd" style="height: 44px;"><!--展开式高度设置为272px，合拢时为72px,一行行高为34，可计算下-->
			<div style="width: 100px;height: 18px;line-height: 18px;padding: 2px 0;float: left;text-align: right;font-weight: 700;">车次类型：</div>
			<input type="checkbox" />GC-高铁/城际
			<input type="checkbox" />D-动车
			<input type="checkbox" />T-特快
			<input type="checkbox" />K-快速
			<input type="checkbox" />其他
			车次：<input type="text" style="width: 120px;"/>
		</div>
		<div style="width: 100%" id="title_div"></div>
		<div id="floatTable" class="t-list" style="top: 0px; position: fixed; display: none;">
			<table width="100%">
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
					<th>里程</th>
				</tr>
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
			</thead>	
			</table>
		</div>
		<div class="t-list  mt10">
		<table width="100%" id="listTable">
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
					<th>里程</th>
				</tr>
			</thead>
			<tbody id="tbody"  style="text-align:center;">
			

			</tbody>
		</table>
		</div>
		<!-- 遮罩 -->
		<div class="dhx_modal_cover"  style="display: none;text-align: center;">
			<img alt="" src="./images/loading.gif" style="margin-top: 240px;">
		</div>
	</body>
</html>
