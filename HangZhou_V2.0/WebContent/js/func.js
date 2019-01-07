function  func(){
	//划线
	     var timeStart = document.getElementById("timeSelStart").value;
	     var dateStart = timeStart.substring(0,10);
	     var hourStart = timeStart.substring(11,13);
	     var timeEnd   = document.getElementById("timeSelEnd").value;
	     var dateEnd   = timeEnd.substring(0,10);
	     var hourEnd   = timeEnd.substring(11,13);
    	 var options=$("#sel option:selected");  //获取选中的项
   	     var number=options.val();
   	     //alert(options.val());
   	     
   	     $.ajax({  
            dataType:"json",         //数据类型为json格式
            data:{"num":number,"dateStart":dateStart,"hourStart":hourStart,"dateEnd":dateEnd,"hourEnd":hourEnd},
            contentType: "application/x-www-form-urlencoded; charset=utf-8", 
            type:"GET",  
            url:"/HangZhou/Draw",  
            statusCode: {404: function() {  
                 alert('page not found'); }  
              },      
            success:function(data,textStatus){ 
         	    //alert("ok");
         	    var counter = data.sum.length;
         	    //alert(counter);
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
         		    var curve = new BMapLib.CurveLine(points, {strokeColor:color, strokeWeight:0.1*data.sum[i], strokeOpacity:0.8}); //创建弧线对象
         		    map.addOverlay(curve); //添加到地图中
         		    if (order1 != order2)
         		    addArrow(curve,1,Math.PI/6,color,data.sum[i]);
         		    //curve.enableEditing(); //开启编辑功能
         		    var content = "借出站点:  " + data.lease[i] +"<br/> "
         		    + "归还站点: " + data.retn[i]  +"<br/> "
         		    +"流量: " + data.sum[i]  +"<br/> ";
         		    addClickHandler(content,curve);
         	    }
         	   function addClickHandler(content,curve){  
                   curve.addEventListener("click",function(e){  openInfo(" "+content,e);});
                 
          }
            }
            });
   	     }