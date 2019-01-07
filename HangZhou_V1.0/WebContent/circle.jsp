<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<% String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<style type="text/css">
		body, html,
		#whole{width:100%;height:700px;left:0;top:0;overflow:auto;overflow-x:hidden;border:0;float:left;}
		#map{float:left;width:54%;height:600px;width:50%;top:30px;font-family:"微软雅黑";border:2px solid gray;}
		#circos{float:left;top:30px;height:600px;width:40%;top:30px;border-radius:5px solid red;right:10px;}	
</style>
<style>

	.chord path {
  		fill-opacity: 0.67;
  		stroke: #000;
  		stroke-width: 0.5px;
	}
	</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ENx4XoKCKSa33qlZI0aCjFxS4OFPZgAX"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/CurveLine/1.5/src/CurveLine.min.js"></script>
<title>弦图</title>
</head>
<body onload="show()">
<div id="whole">
<div id="map"></div>
<div id="circos"></div>
</div>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js" ></script>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script type="text/javascript" src="http://lbsyun.baidu.com/jsdemo/data/points-sample-data.js"></script>
<script type="text/javascript">
function create(id,title,pointx,pointy,address) {
	this.id = id;
    this.title = title;
    this.pointx = pointx;
    this.pointy = pointy;
    this.address = address;
}
function creat(id1,id2,num) {
	this.id1 = id1;
    this.id2 = id2;
    this.num = num;
}
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
	// 百度地图API功能
	var map = new BMap.Map("map");  // 创建Map实例
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
    var rows = new Array();
    var arr  = new Array();
    var info = new Array();
    var info1= new Array(); 
    var counter;     //数组条目数
    var svg = d3.select("#circos").append("svg");
    
    function func()
    {
    	 var number=1;
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
       	    counter = data.sum.length;
       	    var i = 0;
       	    for(i=0;i<counter;i++){
       	    	info[i] = new creat(data.lease[i],data.retn[i],data.sum[i]);
       	    }
       	    var temp1,temp2,temp3;
       	    for(i=0;i<counter;i++){
       	    	for (var j = 0; j < counter - 1 - i; j++) // 依次比较相邻的两个元素,使较大的那个向后移
   	            {
   	                if (info[j].num < info[j+1].num)            // 如果条件改成A[i] >= A[i + 1],则变为不稳定的排序算法
   	                {
   	                    temp1=info[j].id1;
   	                    temp2=info[j].id2;
   	                    temp3=info[j].num;
   	                    info[j].num=info[j+1].num;
   	                    info[j].id1=info[j+1].id1;
   	                    info[j].id2=info[j+1].id2;
   	                    info[j+1].num=temp3;
   	                    info[j+1].id1=temp1;
   	                    info[j+1].id2=temp2;
   	                }
   	                    
   	            }
       	    	
       	    }
       	    //alert(info[1].id1);
       	           	              	   
          }
          });
 	     }
    	
    
    function show()
    {
    	 $.ajax({  
    	        dataType:"json",         //数据类型为json格式
    	        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
    	        type:"GET",  
    	        url:"/HangZhou/info",  
    	        statusCode: {404: function() {  
    	             alert('page not found'); }  
    	          },      
    	        success:function(data,textStatus){
    	        	alert("ok");
                	var sum = data.ID.length;       //站点信息数据的数量，有多少站点
                	alert(sum);
                	var i = 0;
                	var points = [];
                	var baidux;
                	var baiduy;
                	for(i=0;i<sum;i++){
                		rows[i]=new create(data.ID[i], data.Name[i] , data.X[i] , data.Y[i] , data.Address[i] );
                		arr[i] =data.ID[i];
                		baidux=data.X[i];
                		baiduy=data.Y[i];
                		points.push(new BMap.Point(baidux,baiduy));
                		
                	}
                	//alert(rows.length);
                	var pointCollection = new BMap.PointCollection(points, options);  // 初始化PointCollection
                	pointCollection.addEventListener('click', function (e) {
                		alert("click");
         
                		//alert(counter);
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
                			staid=data.ID[i];
                		    sname=data.Name[i];
                		    address=data.Address[i];
                		    break;
                		}
                		}
                		//alert(sid+sname+address);
                		var point = new BMap.Point(e.point.lng, e.point.lat);
                		var infowindow = new BMap.InfoWindow("ID:"+staid+"<br/>名称:"+sname+"<br/>地址:"+address, opts);
                		map.openInfoWindow(infowindow, point);
                		
                		
                		var population = [];  //先声明一维
                		$.ajax({  
              	          dataType:"json",         //数据类型为json格式
              	          data:{"sid":staid},
              	          contentType: "application/x-www-form-urlencoded; charset=utf-8", 
              	          type:"GET",  
              	          url:"/HangZhou/select10",  
              	          statusCode: {404: function() {  
              	               alert('page not found'); }  
              	            },      
              	          success:function(data,textStatus){ 
              	        	alert("进入select10")
              	       	    //alert("ok");
              	        	alert(data.ID1.length);
              	        	alert(data.ID1[0]);
                            var flag=0;
              	        	var i=0;
              	        	var id1=data.ID1[0];
              	        	//var population = new Array();  //先声明一维
              	        	for(var k=0;k<10;k++){
              	        		population[k]=[0,0,0,0,0,0,0,0,0,0];
              	        	}

              	        	var stationID = [];
              	        	stationID[0]=data.ID1[0];
              	        	for(k=0;k<10;k++){    //一维长度为i,i为变量，可以根据实际情况改变
              	        		//alert("ok");
              	        		stationID[k]=data.ID1[i];
              	        		var hang=[];  //声明二维，每一个一维数组里面的一个元素都是一个数组；
              	        	 
              	        	for(j=0;j<10;j++){   //一维数组里面每个元素数组可以包含的数量p，p也是一个变量；
              	        	if(data.ID1[i]!=id1){
              	        		flag=1;
              	        		id1=data.ID1[i];
              	        		//要换行了
              	        		//alert("换行");
              	        		k--;
              	        		break;
              	        	}
              	        	
              	        	hang[j]=data.SUM[i];    //这里将变量初始化，我这边统一初始化为空，后面在用所需的值覆盖里面的值
              	        	i++;
              	        	
              	        	 }
              	        		if(!flag){
              	      	
              	        		//alert(hang);
              	        	    population[k]=hang;
              	        		}
              	        		flag=0;
              	        	}
              	        	
              	        	//alert(population);
              	        	//var stationID = [data.ID1[0],data.ID1[1],data.ID1[2],data.ID1[3],data.ID1[4],data.ID1[5],data.ID1[6],data.ID1[7],data.ID1[8],data.ID1[9]];
              	        	

              	        	       //var stationID = [ "北京" , "上海" , "广州" , "深圳" , "香港"  ];
              	        	        
              	        	       /*var a=[];
              	        	       a[0]=1;
              	        	       a[1]=2;
              	        	       a[2]=5;
              	        	       var b=[];
              	        	       b[0]=a;
              	        	       b[1]=a;
              	        	       alert(b);
              	        	       */
              	        	       /* var po = [
              	        	          [ 1000,  3045　 , 4567　, 1234 , 3714 ],
              	        	          [ 3214,  2000　 , 2060　, 124  , 3234 ],
              	        	          [ 8761,  6545　 , 3000　, 8045 , 647  ],
              	        	          [ 3211,  1067  , 3214 , 4000  , 1006 ],
              	        	          [ 2146,  1034　 , 6745 , 4764  , 5000 ]
              	        	        ];
              	        	        alert(po);*/
              	        	var chord_layout = d3.layout.chord()
			                 .padding(0.03)		//节点之间的间隔
			                 .sortSubgroups(d3.descending)	//排序
			                 .matrix(population);	//输入矩阵

		var groups = chord_layout.groups();
		var chords = chord_layout.chords();

		console.log( groups );
		console.log( chords );
		
		//3.SVG，弦图，颜色函数的定义
		var width  = 600;
		var height = 600;
		var innerRadius = width/2 * 0.7;
		var outerRadius = innerRadius * 1.1;

		var color20 = d3.scale.category20();
		//svg.remove();  
		svg = d3.select("#circos").append("svg");
		
		var element=svg.attr("width", width)
			.attr("height", height)
		    .append("g")
           .attr("transform","translate(300,300)");
		//4.绘制节点（即分组，有多少个城市画多少个弧形），及绘制城市名称
		var outer_arc =  d3.svg.arc()
					 .innerRadius(innerRadius)
					 .outerRadius(outerRadius);
		
		var g_outer = element.append("g");
		
		g_outer.selectAll("path")
				.data(groups)
				.enter()
				.append("path")
				.style("fill", function(d) { return color20(d.index); })
				.style("stroke", function(d) { return color20(d.index); })
				.attr("d", outer_arc );
			
		g_outer.selectAll("text")
				.data(groups)
				.enter()
				.append("text")
				.each( function(d,i) { 
					d.angle = (d.startAngle + d.endAngle) / 2; 
					d.name = stationID[i];
				})
				.attr("dy",".35em")
				.attr("transform", function(d){
					return "rotate(" + ( d.angle * 180 / Math.PI ) + ")" +
						   "translate(0,"+ -1.0*(outerRadius+10) +")" +
						    ( ( (d.angle > Math.PI*3/4 )&&( d.angle < Math.PI*5/4) ) ? "rotate(180)" : "");
				})
				.text(function(d){
					return d.name;
				});
				

		//5.绘制内部弦（即所有城市人口的来源，即有5*5=25条弧）
		var inner_chord =  d3.svg.chord()
						.radius(innerRadius);
		
		element.append("g")
			.attr("class", "chord")
		    .selectAll("path")
			.data(chords)
		    .enter()
			.append("path")
			.attr("d", inner_chord )
		    .style("fill", function(d) { return color20(d.source.index); })
			.style("opacity", 1)
			.on("mouseover",function(d,i){
				d3.select(this)
					.style("fill","yellow");
			})
			.on("mouseout",function(d,i) { 
				d3.select(this)
					.transition()
                   .duration(1000)
					.style("fill",color20(d.source.index));
			});
              	        	
              	        	
              	          }
              	          });
                		//alert("出ajax");
                		//alert(population);
                	 svg.remove();
               		 alert("OK");
               		

               			
                		});    
                    map.addOverlay(pointCollection);  // 添加Overlay 
    	        }         //与funvtion 的success对应
    	        });        //与ajax对应
    	
    	
    	
    }



</script>
</body>
</html>