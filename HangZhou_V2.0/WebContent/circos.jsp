<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<% String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
		body, html,
		#whole{width:100%;height:700px;left:0;top:0;overflow:auto;overflow-x:hidden;border:0;}
		#map{width:54%;height:600px;position:absolute;top:30px;font-family:"΢���ź�";border:2px solid gray;}
		#circos{top:30px;position:absolute;left:750px;height:600px;border:1px solid red;right:10px;}	
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
<title>��ͼ</title>
</head>
<body onload="show();func()">
<div id="whole">
<div id="map"></div>
<div id="circos"></div>
</div>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js" ></script>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script type="text/javascript" src="http://lbsyun.baidu.com/jsdemo/data/points-sample-data.js"></script>
<script type="text/javascript">
var sum;
var counter;
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
	// �ٶȵ�ͼAPI����
	var map = new BMap.Map("map");  // ����Mapʵ��
    map.centerAndZoom("����",12);       // ��ʼ����ͼ,�ó��������õ�ͼ���ĵ�
    map.setMapStyle({style:'grayscale'});
    map.enableScrollWheelZoom(true);  //���ù��ַŴ���С  
    //���ͼ��������ſؼ�   
    var ctrlNav = new window.BMap.NavigationControl({  
         anchor: BMAP_ANCHOR_TOP_LEFT,  
         type: BMAP_NAVIGATION_CONTROL_LARGE  
      });  
    map.addControl(ctrlNav);  

//���ͼ���������ͼ�ؼ�  
    var ctrlOve = new window.BMap.OverviewMapControl({  
        anchor: BMAP_ANCHOR_BOTTOM_RIGHT,  
        isOpen: 1  
     });  
    map.addControl(ctrlOve);  

//���ͼ����ӱ����߿ؼ�  
    var ctrlSca = new window.BMap.ScaleControl({  
        anchor: BMAP_ANCHOR_BOTTOM_LEFT  
      });  
    map.addControl(ctrlSca);
    var rows = new Array();
    var arr  = new Array();
    var info = new Array();
    var info1= new Array(); 
    var counter;     //������Ŀ��
    var svg = d3.select("#circos").append("svg");
    function  func(){
         var number=1;
  	     $.ajax({  
           dataType:"json",         //��������Ϊjson��ʽ
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
        	    	for (var j = 0; j < counter - 1 - i; j++) // ���αȽ����ڵ�����Ԫ��,ʹ�ϴ���Ǹ������
    	            {
    	                if (info[j].num < info[j+1].num)            // ��������ĳ�A[i] >= A[i + 1],���Ϊ���ȶ��������㷨
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
    function show(){
    $.ajax({  
        dataType:"json",         //��������Ϊjson��ʽ
        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
        type:"GET",  
        url:"/HangZhou/info",  
        statusCode: {404: function() {  
             alert('page not found'); }  
          },      
        success:function(data,textStatus){
        	alert("OK");
        	sum = data.ID.length;
        	//alert(sum);
        	var i = 0;
        	for(i=0;i<sum;i++){
        		rows[i]=new create(data.ID[i], data.Name[i] , data.X[i] , data.Y[i] , data.Address[i] );
        		arr[i] =data.ID[i];
        	
        	}
        	var Baidux,Baiduy;
            //var content;
            alert(rows.length);
            for(i = 0;i<rows.length;i++){
            	Baidux = rows[i].pointx;
            	Baiduy = rows[i].pointy;	
            	points.push(new BMap.Point(baidux,baiduy));
            	//var point = new BMap.Point(Baidux,Baiduy);
        	    //var point = new BMap.Point(rows[i].pointx,rows[i].pointy);
        	    //addMarker(point);
        	    //var marker = new BMap.Marker(point);        	   
        	  	//map.addOverlay(marker);
        	  	var staid = rows[i].id;
        	  	var staname = rows[i].name;
        	  	//addClickHandler(staid,marker);            
            }
            var pointCollection = new BMap.PointCollection(points, options);  // ��ʼ��PointCollection
            pointCollection.addEventListener('click', function (e) {
        		alert("click");
        		for (i = 0; i < sum; i++) {
            		//points.push(new BMap.Point(data[i][0],data[i][1]));
            		if(data.X[i]==e.point.lng&&data.Y[i]==e.point.lat)
            		{//����==�����,ά��
            		    alert("OK");
            			staid=data.ID[i];
            		    sname=data.Name[i];
            		    address=data.Address[i];
            		    //alert(sid+sname+address);
            		    break;
            		}
            		}
        		//staid=sid;
        		svg.remove();
       		 alert("OK");
       		 var i=1;		 
       		 var j=3;//
       		 var isOrnot=0; 		 
       		 i=0;
       		 //stationName[]=[];
       		 var stationName = new Array(4);
       		 //stationName[0]=sname;
       		 for(j=16;j>=1;j--){
       			 info1[j] = new creat(0,0,0);
       		 }
       		 j=3;
       		 while(j>=1&&i<counter){
       			 if(info[i].id1==staid)
       				 {
       				 if(info[i].id2==staid)
       					 {
       					 j++;
       					 isOrnot=1;
       					 alert(j);
       					 }
       				 info1[j]=new creat(info[i].id1,info[i].id2,info[i].num);
       				 //stationName[j]=info[i].
       				 alert(info1[j].id1+info1[j].id2+info1[j].num);
       				 j--;
       				 //alert(j);
       				 }			 
       			 i++;
       		 }
       		 alert(info1[4].num);
       		 for(i=0;i<counter;i++){
       			 if(info[i].id1==info1[1].id2)
       				 {
       				 if(info[i].id2==staid)
       					 {
       					 info1[8]= new creat(info[i].id1,info[i].id2,info[i].num);
       					 }
       				 else if(info[i].id2==info1[1].id2)
       					 {
       					 info1[5]= new creat(info[i].id1,info[i].id2,info[i].num);
       					 }
       				 else if(info[i].id2==info1[2].id2)
       					 {
       					 info1[6]= new creat(info[i].id1,info[i].id2,info[i].num);
       					 }
       				 else if(info[i].id2==info1[3].id2)
       					 {
       					 info1[7]= new creat(info[i].id1,info[i].id2,info[i].num);
       					 }
       				 }
       			 else if(info[i].id1==info1[2].id2)
       				 {
       				 if(info[i].id2==staid)
   					 {
   					 info1[12]= new creat(info[i].id1,info[i].id2,info[i].num);
   					 }
   				 else if(info[i].id2==info1[1].id2)
   					 {
   					 info1[9]= new creat(info[i].id1,info[i].id2,info[i].num);
   					 }
   				 else if(info[i].id2==info1[2].id2)
   					 {
   					 info1[10]= new creat(info[i].id1,info[i].id2,info[i].num);
   					 }
   				 else if(info[i].id2==info1[3].id2)
   					 {
   					 info1[11]= new creat(info[i].id1,info[i].id2,info[i].num);
   					 }
       				 }
       			 else if(info[i].id1==info1[3].id2)
       				 {
       				 if(info[i].id2==staid)
   					 {
   					 info1[16]= new creat(info[i].id1,info[i].id2,info[i].num);
   					 }
   				 else if(info[i].id2==info1[1].id2)
   					 {
   					 info1[13]= new creat(info[i].id1,info[i].id2,info[i].num);
   					 }
   				 else if(info[i].id2==info1[2].id2)
   					 {
   					 info1[14]= new creat(info[i].id1,info[i].id2,info[i].num);
   					 }
   				 else if(info[i].id2==info1[3].id2)
   					 {
   					 info1[15]= new creat(info[i].id1,info[i].id2,info[i].num);
   					 }   				 
       				 }
       			 i++;
       		 }
       		 //��ͼ�Ĳ���
       		//1.��������
       			// ������
       			//var city_name = [ "����" , "�Ϻ�" , "����" , "����" , "���"  ];
       			var stationID = [staid,info1[1].id2,info1[2].id2,info1[3].id2];
       			// �����˿ڵ���Դ����
       			//				����		�Ϻ�
       			//	����		1000		3045
       			//	�Ϻ�		3214		2000
       			// ��ʾ�����е��˿���1000�������Ա��أ���3045���������Ϻ����������˿�Ϊ 1000 + 3045
       			// �Ϻ��е��˿���2000�������Ա��أ���3214�������Ա������������˿�Ϊ 3214 + 2000
       			var population = [
       			  //[ info1[4].num,info1[1].num,info1[2].num,info1[3].num],
       			  [parseInt(info1[4].num),parseInt(info1[1].num),parseInt(info1[2].num),parseInt(info1[3].num)],
       			  [parseInt(info1[8].num),parseInt(info1[5].num),parseInt(info1[6].num),parseInt(info1[7].num)],
       			  [parseInt(info1[12].num),parseInt(info1[9].num),parseInt(info1[10].num),parseInt(info1[11].num)],
       			  [parseInt(info1[16].num),parseInt(info1[13].num),parseInt(info1[14].num),parseInt(info1[15].num)],	
       			];
       			alert(info1[4].num);


       			//2.ת�����ݣ������ת���������
       			var chord_layout = d3.layout.chord()
       				                 .padding(0.03)		//�ڵ�֮��ļ��
       				                 .sortSubgroups(d3.descending)	//����
       				                 .matrix(population);	//�������

       			var groups = chord_layout.groups();
       			var chords = chord_layout.chords();

       			console.log( groups );
       			console.log( chords );
       			
       			//3.SVG����ͼ����ɫ�����Ķ���
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
       			//4.���ƽڵ㣨�����飬�ж��ٸ����л����ٸ����Σ��������Ƴ�������
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
       					

       			//5.�����ڲ��ң������г����˿ڵ���Դ������5*5=25������
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
            
        }  
        }); 
    
    
    
    
    /*
    function addClickHandler(staid,marker){
    	//alert("OK");
    	 //svg.remove(); 
    	 marker.addEventListener("click",function(e){
    		 svg.remove();
    		 alert("OK");
    		 var i=1;		 
    		 var j=3;//
    		 var isOrnot=0; 		 
    		 i=0;
    		 //stationName[]=[];
    		 var stationName = new Array(4);
    		 //stationName[0]=sname;
    		 for(j=16;j>=1;j--){
    			 info1[j] = new creat(0,0,0);
    		 }
    		 j=3;
    		 while(j>=1&&i<counter){
    			 if(info[i].id1==staid)
    				 {
    				 if(info[i].id2==staid)
    					 {
    					 j++;
    					 isOrnot=1;
    					 alert(j);
    					 }
    				 info1[j]=new creat(info[i].id1,info[i].id2,info[i].num);
    				 //stationName[j]=info[i].
    				 alert(info1[j].id1+info1[j].id2+info1[j].num);
    				 j--;
    				 //alert(j);
    				 }			 
    			 i++;
    		 }
    		 alert(info1[4].num);
    		 for(i=0;i<counter;i++){
    			 if(info[i].id1==info1[1].id2)
    				 {
    				 if(info[i].id2==staid)
    					 {
    					 info1[8]= new creat(info[i].id1,info[i].id2,info[i].num);
    					 }
    				 else if(info[i].id2==info1[1].id2)
    					 {
    					 info1[5]= new creat(info[i].id1,info[i].id2,info[i].num);
    					 }
    				 else if(info[i].id2==info1[2].id2)
    					 {
    					 info1[6]= new creat(info[i].id1,info[i].id2,info[i].num);
    					 }
    				 else if(info[i].id2==info1[3].id2)
    					 {
    					 info1[7]= new creat(info[i].id1,info[i].id2,info[i].num);
    					 }
    				 }
    			 else if(info[i].id1==info1[2].id2)
    				 {
    				 if(info[i].id2==staid)
					 {
					 info1[12]= new creat(info[i].id1,info[i].id2,info[i].num);
					 }
				 else if(info[i].id2==info1[1].id2)
					 {
					 info1[9]= new creat(info[i].id1,info[i].id2,info[i].num);
					 }
				 else if(info[i].id2==info1[2].id2)
					 {
					 info1[10]= new creat(info[i].id1,info[i].id2,info[i].num);
					 }
				 else if(info[i].id2==info1[3].id2)
					 {
					 info1[11]= new creat(info[i].id1,info[i].id2,info[i].num);
					 }
    				 }
    			 else if(info[i].id1==info1[3].id2)
    				 {
    				 if(info[i].id2==staid)
					 {
					 info1[16]= new creat(info[i].id1,info[i].id2,info[i].num);
					 }
				 else if(info[i].id2==info1[1].id2)
					 {
					 info1[13]= new creat(info[i].id1,info[i].id2,info[i].num);
					 }
				 else if(info[i].id2==info1[2].id2)
					 {
					 info1[14]= new creat(info[i].id1,info[i].id2,info[i].num);
					 }
				 else if(info[i].id2==info1[3].id2)
					 {
					 info1[15]= new creat(info[i].id1,info[i].id2,info[i].num);
					 }   				 
    				 }
    			 i++;
    		 }
    		 //��ͼ�Ĳ���
    		//1.��������
    			// ������
    			//var city_name = [ "����" , "�Ϻ�" , "����" , "����" , "���"  ];
    			var stationID = [staid,info1[1].id2,info1[2].id2,info1[3].id2];
    			// �����˿ڵ���Դ����
    			//				����		�Ϻ�
    			//	����		1000		3045
    			//	�Ϻ�		3214		2000
    			// ��ʾ�����е��˿���1000�������Ա��أ���3045���������Ϻ����������˿�Ϊ 1000 + 3045
    			// �Ϻ��е��˿���2000�������Ա��أ���3214�������Ա������������˿�Ϊ 3214 + 2000
    			var population = [
    			  //[ info1[4].num,info1[1].num,info1[2].num,info1[3].num],
    			  [parseInt(info1[4].num),parseInt(info1[1].num),parseInt(info1[2].num),parseInt(info1[3].num)],
    			  [parseInt(info1[8].num),parseInt(info1[5].num),parseInt(info1[6].num),parseInt(info1[7].num)],
    			  [parseInt(info1[12].num),parseInt(info1[9].num),parseInt(info1[10].num),parseInt(info1[11].num)],
    			  [parseInt(info1[16].num),parseInt(info1[13].num),parseInt(info1[14].num),parseInt(info1[15].num)],	
    			];
    			alert(info1[4].num);


    			//2.ת�����ݣ������ת���������
    			var chord_layout = d3.layout.chord()
    				                 .padding(0.03)		//�ڵ�֮��ļ��
    				                 .sortSubgroups(d3.descending)	//����
    				                 .matrix(population);	//�������

    			var groups = chord_layout.groups();
    			var chords = chord_layout.chords();

    			console.log( groups );
    			console.log( chords );
    			
    			//3.SVG����ͼ����ɫ�����Ķ���
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
    			//4.���ƽڵ㣨�����飬�ж��ٸ����л����ٸ����Σ��������Ƴ�������
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
    					

    			//5.�����ڲ��ң������г����˿ڵ���Դ������5*5=25������
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
    			//svg.remove();
    		 
    		 
    	 })
    	
    	
    	
    }
    */
    function remove(){
    	svg.remove();
    }
</script>
</body>
</html>