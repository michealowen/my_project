<%@ page language="java" import = "java.sql.*" import = "java.util.ArrayList" import = "java.util.*"  contentType="text/html; charset=GB18030"
    pageEncoding="UTF-8"%>
<% String path = request.getContextPath();
   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html,#whole{width:100%;height:1500px;left:0;top:0;overflow:auto;overflow-x:hidden;border:0;}
		#fresh {width:50px;height:10px;position:absolute;top:0;left:0;color:rgb(0,0,255);}
		#allmap{width:100%;height:600px;position:absolute;top:30px;font-family:"微软雅黑";}
		#form  {width:50px;height:50px;position:absolute; top:630px;left:0;font-family:"微软雅黑";}
		#gante {width:50px;height:10px;position:absolute;top:630px;left:100px;color:#00FFFF;}
		#main  {width:100%;height:300px;position:absolute;top:680px;left:0;}
		#rec   {width:50px;height:200px;position:absolute;top:500px;left:600px;color:red;}
	</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ENx4XoKCKSa33qlZI0aCjFxS4OFPZgAX"></script>
<script type="text/javascript" src="http://lbsyun.baidu.com/jsdemo/data/points-sample-data.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/CurveLine/1.5/src/CurveLine.min.js"></script>
<!-- ECharts单文件引入 -->
<script src="http://echarts.baidu.com/build/dist/echarts-all.js" charset="UTF-8"></script>
<title>杭州公共自行车查询系统</title>
</head>
<body>
<div id="whole">
<div id="fresh"><input type="button" onclick="fresh()" value="刷新站点" ></div>
<div id="allmap"></div>
<div id="main">
<div id="rec">
</div>
</div>
<div id="gante"><input type="button" onclick="gante()" value="用户租借序列视图"> </div>
<div id="form" >
    <select name="街车数量" id="sel"  onchange="select()">
    <option>---请选择---</option>
    <option value="8000">8000</option>
    <option value="4000">4000</option>
    <option value="2000">2000</option>
    <option value="1000">1000</option>
    <option value="500">500</option>
    <option value="250">250</option>   
</select>
</div>
</div>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js" ></script>
<script type="text/javascript" src="<%=path%>/js/d3.js" ></script>
<script type="text/javascript">

    var rows = new Array();
    var arr  = new Array();
    opts = {  
            width : 200,     // 信息窗口宽度  
            height: 100,     // 信息窗口高度  
            title :  "", // 信息窗口标题  
            enableMessage:true//设置允许信息窗发送短息  
            };
    
    //弧线颜色
        var options = {
            size: BMAP_POINT_SIZE_SMALL,
            shape: BMAP_POINT_SHAPE_CIRCLE,
            color: '#d340c3'
        }
    var b = d3.rgb(255,0,0);    //红色  
    var c = d3.rgb(255,255,0);  //黄色
    var a = d3.rgb(0,255,0);    //绿色  
    var compute1 = d3.interpolate(a,b);
    var compute2 = d3.interpolate(b,c);
    
    function getColor(weight){
    	if(weight>=0&&weight<=6.5)
    		return compute1(weight*2/13);
    	if(weight>6.5&&weight<=13)
    		return compute2(weight*2/13);
    }
    
    function openInfo(content,e){  
        //var p = e.target;  
        var point = new BMap.Point(e.point.lng, e.point.lat);  
        var infoWindow = new BMap.InfoWindow(content,opts);  // 创建信息窗口对象   
        map.openInfoWindow(infoWindow,point);                //开启信息窗口  
    }
    function select(arr,item){
    	var i = 0;
    	for(i=0;i<arr.length;i++){
    		if(arr[i]==item)
    			return i;
    	}
    }
    function create(id,title,pointx,pointy,address) {
    	this.id = id;
        this.title = title;
        this.pointx = pointx;
        this.pointy = pointy;
        this.address = address;
    }
   
    var map = new BMap.Map("allmap");  // 创建Map实例
    var Opoint = new BMap.Point(-73.98565,40.72779);
    map.centerAndZoom(Opoint,12);       // 初始化地图,用城市名设置地图中心点
    map.setMapStyle({style:'grayscale'});
    map.enableScrollWheelZoom(true);  //启用滚轮放大缩小  
    //向地图中添加缩放控件   
    var ctrlNav = new window.BMap.NavigationControl({  
         anchor: BMAP_ANCHOR_TOP_LEFT,  
         type: BMAP_NAVIGATION_CONTROL_LARGE  
      });  
    map.addControl(ctrlNav);  

//向地图中添加缩略图控件  
    var ctrlOve = new window.BMap.OverviewMapControl({  
        anchor: BMAP_ANCHOR_BOTTOM_RIGHT,  
        isOpen: 1  
     });  
    map.addControl(ctrlOve);  

//向地图中添加比例尺控件  
    var ctrlSca = new window.BMap.ScaleControl({  
        anchor: BMAP_ANCHOR_BOTTOM_LEFT  
      });  
    map.addControl(ctrlSca);
    
    
    function select()
    {
    	 alert("ok");
    	 map.clearOverlays();
    	 var options=$("#sel option:selected");  //获取选中的项
  	     var number=options.val();
  	     alert(options.val());
  	     $.ajax({  
           dataType:"json",         //数据类型为json格式
           data:{"num":number},
           contentType: "application/x-www-form-urlencoded; charset=utf-8", 
           type:"GET",  
           url:"/HangZhou/New_YorkSel",  
           statusCode: {404: function() {  
                alert('page not found'); }  
             },      
           success:function(data,textStatus){ 
        	    alert("ok");
        	    var counter = data.A.length;
        	    alert(counter);
        	    var baidux,baiduy;
                //var content;
                var points = [];
                for(i = 0;i<counter;i++){
                	//alert("ok");
                	baidux = data.A[i];
                	baiduy = data.B[i];	
            	    //var point = new BMap.Point(Baidux,Baiduy);
            	  	//map.addOverlay(marker);
            	  	points.push(new BMap.Point(baidux,baiduy));
            	  	//addClickHandler(content,staid,marker);
                }
                
                alert("ok");
                var pointCollection = new BMap.PointCollection(points, options);  // 初始化PointCollection
                map.addOverlay(pointCollection);  // 添加Overlay
        	    
           }
           });

    }
    
    
    function fresh()
    {
    	map.clearOverlays();
    	$.ajax({  
            dataType:"json",         //数据类型为json格式
            contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
            type:"GET",  
            url:"/HangZhou/new_york",  
            statusCode: {404: function() {  
                 alert('page not found'); }  
              },      
            success:function(data,textStatus){ 
            	alert("ok");
            	var sum = data.ID.length;
            	//alert(sum);
            	var i = 0;
 
            	alert(sum);

                
                var baidux,baiduy;
                var content;
                var points = [];
                for(i = 0;i<sum;i++){
                	//alert("ok");
                	baidux = data.X[i];
                	baiduy = data.Y[i];	
            	    //var point = new BMap.Point(Baidux,Baiduy);
            	  	//map.addOverlay(marker);
            	  	points.push(new BMap.Point(baidux,baiduy));
            	  	//addClickHandler(content,staid,marker);
                }
                
                alert("ok");
                var pointCollection = new BMap.PointCollection(points, options);  // 初始化PointCollection
                map.addOverlay(pointCollection);  // 添加Overlay
            	pointCollection.addEventListener('click', function (e) {
            		alert("click");
            		var sid=0;//名称
            		var sname="";//地址
            		var address="";//电话
            		//关于自定义信息 修改json [[经度,维度,1,名称,地址,电话]]
            		//循环查出值
            		for (i = 0; i < sum; i++) {
            		//points.push(new BMap.Point(data[i][0],data[i][1]));
            		if(data.X[i]==e.point.lng&&data.Y[i]==e.point.lat)
            		{//经度==点击的,维度
            		    alert("OK");
            			sid=data.ID[i];
            		    sname=data.Name[i];
            		    address=data.Address[i];
            		    //alert(sid+sname+address);
            		    break;
            		}
            		}
            		//alert(sid+sname+address);
            		var point = new BMap.Point(e.point.lng, e.point.lat);
            		var infowindow = new BMap.InfoWindow("ID:"+sid+"<br/>名称:"+sname+"<br/>地址:"+address, opts);
            		map.openInfoWindow(infowindow, point);
            		
  
            });
            }
    })
 
    }
    
     function  func(){
    	 var options=$("#sel option:selected");  //获取选中的项
   	     var number=options.val();
   	     alert(options.val());
   	     $.ajax({  
            dataType:"json",         //数据类型为json格式
            data:{"num":number},
            contentType: "application/x-www-form-urlencoded; charset=utf-8", 
            type:"GET",  
            url:"/HangZhou/Draw",  
            statusCode: {404: function() {  
                 alert('page not found'); }  
              },      
            success:function(data,textStatus){ 
         	    alert("ok");
         	    var counter = data.sum.length;
         	    var i = 0;
         	    var order1=0;
         	    var order2=0;
         	    for(i=0;i<counter;i++){
         	    	order1 = select(arr,data.lease[i]);
         	    	order2 = select(arr,data.retn[i]);
         	    	var PoiA=new BMap.Point(rows[order1].pointx,rows[order1].pointy);
         			var PoiB=new BMap.Point(rows[order2].pointx,rows[order2].pointy);
         		    var points = [PoiA,PoiB];
         		    var color =getColor(data.sum[i]);
         		    var curve = new BMapLib.CurveLine(points, {strokeColor:color, strokeWeight:2*data.sum[i], strokeOpacity:0.8}); //创建弧线对象
         		    map.addOverlay(curve); //添加到地图中
         		    if (order1 != order2)
         		    addArrow(curve,1,Math.PI/5,color);
         		    //curve.enableEditing(); //开启编辑功能
         		    var content = "借出站点:  " + data.lease[i] +"<br/> "
         		    + "归还站点: " + data.retn[i]  +"<br/> ";
         		    addClickHandler(content,curve);
         	    }
         	   function addClickHandler(content,curve){  
                   curve.addEventListener("click",function(e){  openInfo(" "+content,e);});
                 
          }
            }
            });
   	     }
                  
    </script>
</body>
</html>
