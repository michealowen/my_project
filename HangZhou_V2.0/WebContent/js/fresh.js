function fresh()
    {
    	map.clearOverlays();
    	$.ajax({  
            dataType:"json",         //数据类型为json格式
            contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
            type:"GET",  
            //url:"/HangZhou/info",  
            url:"js/stationInfo",
            statusCode: {404: function() {  
                 alert('page not found'); }  
              },      
            success:function(data,textStatus){ 
            	//alert("OK");
            	//alert(data.length);
            	var sum = data.ID.length;
            	//alert(sum);
            	var i = 0;
            	//var points = [];
            	var baidux;
            	var baiduy;
            	//alert(data.Address[10]);
            	//alert(eval('(' + data.Name[10] + ')'));
            	for(i=0;i<sum;i++){
            		rows[i]=new create(data.ID[i], data.Name[i] , data.X[i] , data.Y[i] , data.Address[i] );
            		arr[i] =data.ID[i];
            		baidux=data.X[i];
            		baiduy=data.Y[i];
            		points.push(new BMap.Point(baidux,baiduy));
            		
            	}
            	//alert(points.length);
            	var pointCollection = new BMap.PointCollection(points, options);  // 初始化PointCollection
            	pointCollection.addEventListener('click', function (e) {
            		
            		if(flag==1) return 0;
            		var sid=0;//名称
            		var sname="";//地址
            		var address="";//电话
            		//关于自定义信息 修改json [[经度,维度,1,名称,地址,电话]]
            		//循环查出值
            		for (i = 0; i < sum; i++) {
            		//points.push(new BMap.Point(data[i][0],data[i][1]));
            		if(data.X[i]==e.point.lng&&data.Y[i]==e.point.lat)
            		{//经度==点击的,维度
            		    
            			sid=data.ID[i];
            		    sname=data.Name[i];
            		    address=data.Address[i];
            		    //alert(points.length);
            		    break;
            		}
            		}
            		//alert(sid+sname+address);
            		var point = new BMap.Point(e.point.lng, e.point.lat);
            		var infowindow = new BMap.InfoWindow("ID: "+sid+"<br/>名称: "+sname+"<br/>地址: "+address, opts);
            		map.openInfoWindow(infowindow, point);
            		
            		$.ajax({  
                        dataType:"json",         //数据类型为json格式
                        data:{"date":sid,"name":"北京"},
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
                        	            data:data.values1
                        	            
                        	        },
                        	        {
                        	            name:'归还数量',
                        	            type:'line',
                        	            data:data.values2
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
             
                var myChart = echarts.init(document.getElementById("main"));
                
                var Baidux,Baiduy;
                var content;      
                map.addOverlay(pointCollection);  // 添加Overlay
           
    
            }
    })
 
    }