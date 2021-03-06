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
    <select name="时间" id="sel"  onchange="func()">
    <option>---请选择---</option>
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="5">5</option>
    <option value="7">7</option>
    <option value="9">9</option>   
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
    function addArrow(polyline,length,angleValue,color1){ //绘制箭头的函数  
    	var linePoint=polyline.getPath();//线的坐标串  
    	var arrowCount=linePoint.length; 
    	middle=arrowCount/2;
    	  
    	var pixelStart=map.pointToPixel(linePoint[Math.floor(middle)]);  
    	var pixelEnd=map.pointToPixel(linePoint[Math.floor(middle)+1]);
    	var pixelFinal=map.pointToPixel(linePoint[Math.floor(middle)+2]);
    	var angle=angleValue;//箭头和主线的夹角  
    	var r=length; // r/Math.sin(angle)代表箭头长度  
    	var delta=0; //主线斜率，垂直时无斜率  
    	var param=0; //代码简洁考虑  
    	var pixelTemX,pixelTemY;//临时点坐标  
    	var pixelX,pixelY,pixelX1,pixelY1;//箭头两个点  
    	if(pixelFinal.x-pixelStart.x==0){ //斜率不存在是时  
    	    pixelTemX=pixelEnd.x;  
    	    if(pixelFinal.y>pixelStart.y)  
    	    {  
    	    pixelTemY=pixelEnd.y-r;  
    	    }  
    	    else  
    	    {  
    	    pixelTemY=pixelEnd.y+r;  
    	    }     
    	    //已知直角三角形两个点坐标及其中一个角，求另外一个点坐标算法  
    	    pixelX=pixelTemX-r*Math.tan(angle);   
    	    pixelX1=pixelTemX+r*Math.tan(angle);  
    	    pixelY=pixelY1=pixelTemY;  
    	}  
    	else  //斜率存在时  
    	{  
    	    delta=(pixelFinal.y-pixelStart.y)/(pixelFinal.x-pixelStart.x);  
    	    param=Math.sqrt(delta*delta+1);  
    	  
    	    if((pixelFinal.x-pixelStart.x)<0) //第二、三象限  
    	    {  
    	    pixelTemX=pixelEnd.x+ r/param;  
    	    pixelTemY=pixelEnd.y+delta*r/param;  
    	    }  
    	    else//第一、四象限  
    	    {  
    	    pixelTemX=pixelEnd.x- r/param;  
    	    pixelTemY=pixelEnd.y-delta*r/param;  
    	    }  
    	    //已知直角三角形两个点坐标及其中一个角，求另外一个点坐标算法  
    	    pixelX=pixelTemX+ Math.tan(angle)*r*delta/param;  
    	    pixelY=pixelTemY-Math.tan(angle)*r/param;  
    	  
    	    pixelX1=pixelTemX- Math.tan(angle)*r*delta/param;  
    	    pixelY1=pixelTemY+Math.tan(angle)*r/param;  
    	}  
    	  
    	var pointArrow=map.pixelToPoint(new BMap.Pixel(pixelX,pixelY));  
    	var pointArrow1=map.pixelToPoint(new BMap.Pixel(pixelX1,pixelY1));  
    	var Arrow = new BMap.Polyline([  
    	    pointArrow,  linePoint[Math.ceil(middle)],  pointArrow1  ], {strokeColor:color1, strokeWeight:4, strokeOpacity:1});  
    	map.addOverlay(Arrow);  
    	 
    	}  
    var map = new BMap.Map("allmap");  // 创建Map实例
    map.centerAndZoom("杭州",12);       // 初始化地图,用城市名设置地图中心点
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
    
    function fresh()
    {
    	map.clearOverlays();
    	$.ajax({  
            dataType:"json",         //数据类型为json格式
            contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
            type:"GET",  
            url:"/HangZhou/easy_info",  
            statusCode: {404: function() {  
                 alert('page not found'); }  
              },      
            success:function(data,textStatus){ 
            	alert("ok");
            	var sum = data.ID.length;
            	//alert(sum);
            	var i = 0;
            	for(i=0;i<sum;i++){
            		rows[i]=new create(data.ID[i], data.Name[i] , data.X[i] , data.Y[i] , data.Address[i] );
            		arr[i] =data.ID[i];
            	}
            	//alert(rows.length);
             
                var myChart = echarts.init(document.getElementById("main"));
                
                var Baidux,Baiduy;
                var content;
                for(i = 0;i<rows.length;i++){
                	Baidux = rows[i].pointx;
                	Baiduy = rows[i].pointy;	
            	    var point = new BMap.Point(Baidux,Baiduy);
            	    //addMarker(point);
            	    var marker = new BMap.Marker(point);
            	    var content = "站点编号:  " + rows[i].id +"<br /> "  
                    + "title: " + rows[i].title  +"<br /> "  
                    + "地址: " +  rows[i].address  +"<br /> "
                    + "经纬度  " +  rows[i].pointx + rows[i].pointy +"<br /";
            	  	map.addOverlay(marker);
            	  	var staid = rows[i].id;
            	  	addClickHandler(content,staid,marker);                      
                }
                            
                function addClickHandler(content,staid,marker){  
                    marker.addEventListener("click",function(e){  
                    openInfo(" "+content,e);
                    //alert(staid);
                    $.ajax({  
                        dataType:"json",         //数据类型为json格式
                        data:{"date":staid},
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
                        type:"GET",  
                        url:"/HangZhou/back",  
                        statusCode: {404: function() {  
                             alert('page not found'); }  
                          },      
                        success:function(data,textStatus){ 
                       	//var myChart = echarts.init(document.getElementById("main"));
                       	var option = {
                        	    title : {
                        	        text: '站点自行车租借信息',
                        	        subtext: ''
                        	    },
                        	    tooltip : {
                        	        trigger: 'axis'
                        	    },
                        	    legend: {
                        	        data:['借出','归还']
                        	    },
                        	    toolbox: {
                        	        show : true,
                        	        feature : {
                        	            mark : {show: true},
                        	            dataView : {show: true, readOnly: false},
                        	            magicType : {show: true, type: ['line', 'bar']},
                        	            restore : {show: true},
                        	            saveAsImage : {show: true}
                        	        }
                        	    },
                        	    calculable : true,
                        	    xAxis : [
                        	        {
                        	            type : 'category',
                        	            boundaryGap : false,
                        	            data :data.catergories
                        	        }
                        	    ],
                        	    yAxis : [
                        	        {
                        	            type : 'value',
                        	            axisLabel : {
                        	                formatter: '{value} 辆'
                        	            }
                        	        }
                        	    ],
                        	    series : [
                        	        {
                        	            name:'借出数量',
                        	            type:'line',
                        	            data:data.values
                        	            
                        	        },
                        	        {
                        	            name:'归还数量',
                        	            type:'line',
                        	            data:data.values
                        	        }
                        	    ],
                        	    noDataLoadingOption: {
                                    text: '暂无数据',
                                    effect: 'bubble',
                                    effectOption: {
                                        effect: {
                                            n: 0
                                        }
                                    }
             }
                        	};                       	
                       		myChart.refresh();
                       		myChart.setOption(option);        
                        }  
                        }); 
                });  
                }
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
         	    alert(counter);
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
