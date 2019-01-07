<%@ page language="java" import = "java.sql.*" import = "java.util.ArrayList" import = "java.util.*"  contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<% String path = request.getContextPath();
   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>   
<%  Class.forName("oracle.jdbc.driver.OracleDriver");
    String url="jdbc:oracle:thin:@localhost:1521:orcl";//orclΪ������ݿ��SID  sid(Oracle���ݿ�ı�ʶ��)
    String user="owen";
    String password="3856225";//����Connection(�Ự������)����
    Connection conn=DriverManager.getConnection(url,user,password);//����Statement(���)���󣬴���sql�������� 
    Statement stmt=conn.createStatement();  //SQL ���
    String sql="SELECT q.STATIONID,q.STATIONNAME,q.ADDRESS,w.BAIDU_X,w.BAIDU_Y "+
    "FROM G_STATIONINFO q INNER JOIN G_STATIONORIENT w ON q.STATIONID=w.STATIONID";
    
    //����� �������в�ѯ������ص�һ�ֶ�����һ���洢��ѯ����Ķ��󣬻����в������ݵĹ��ܣ�������ɶ����ݵĸ��¡�
    ResultSet rs=stmt.executeQuery(sql);
    %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html,#allmap {width: 100%;height: 300px;overflow: hidden;margin:0;font-family:"΢���ź�";}
		#form{width:50px;height:50px;position:absolute; top:300px;left:0;font-family:"΢���ź�";}
		#main{width:100%;height:300px;position:absolute;top:350px;left:0;}
	</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ENx4XoKCKSa33qlZI0aCjFxS4OFPZgAX"></script>
<!-- ECharts���ļ����� -->
<script src="http://echarts.baidu.com/build/dist/echarts-all.js"></script>
<title>Insert title here</title>
</head>
<body>
<div id="allmap"></div>
<div id="main"></div>
<div id="form" >
    <select name="ʱ��" id="sel"  onchange="func()">
    <option>---��ѡ��---</option>
    <option value="6">6</option>
    <option value="7">7</option>
    <option value="8">8</option>
    <option value="9">9</option>   
</select>
</div>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js" ></script>
<script type="text/javascript">
var rows = new Array();
function create(id,title,pointx,pointy,address) 
{
this.id = id;
this.title = title;
this.pointx = pointx;11
this.pointy = pointy;
this.address = address;
}
<%
float x,y;
int i = 0;
String name;
String address;
int id;
float arr1[] = new float[100];
float arr2[] = new float[100];

 while(rs.next()){
	x = Float.parseFloat(rs.getString(4));
	y = Float.parseFloat(rs.getString(5));
	name = rs.getString(2);
	id  = Integer.parseInt(rs.getString(1));
	address  = rs.getString(3);
	arr1[i]=x;
	arr2[i]=y;
%>
rows[<%=i%>]=new create(<%=id%>, "<%=name%>",<%=x%> , <%=y%> , "<%=address%>");
<%
	i++;
}
%>
    var stalist1 = new Array();
    var stalist2 = new Array();
    <%for(i = 0;i < arr1.length;i++){%>

    stalist1[<%=i%>]="<%=arr1[i]%>";
    stalist2[<%=i%>]="<%=arr2[i]%>";
    
    <%}%>
    var map = new BMap.Map("allmap");  // ����Mapʵ��
    map.centerAndZoom("����",12);      // ��ʼ����ͼ,�ó��������õ�ͼ���ĵ�
    map.enableScrollWheelZoom(true);
    var myChart = echarts.init(document.getElementById("main"));
    
    //���ù��ַŴ���С  
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
    
    //alert(rows[i].id);
    opts = {  
                    width : 200,     // ��Ϣ���ڿ��  
                    height: 100,     // ��Ϣ���ڸ߶�  
                    title :  "", // ��Ϣ���ڱ���  
                    enableMessage:true//����������Ϣ�����Ͷ�Ϣ  
        };  
    var Baidux,Baiduy;
    var content;
    for(var i = 0;i<stalist1.length;i++){
    	Baidux = stalist1[i];
    	Baiduy = stalist2[i];	
	    var point = new BMap.Point(Baidux,Baiduy);
	    //addMarker(point);
	    var marker = new BMap.Marker(point);
	    var content = "վ����:  " + rows[i].id +"<br /> "  
        + "title: " + rows[i].title  +"<br /> "  
        + "��ַ: " +  rows[i].address  +"<br /> "
        + "��γ��  " +  rows[i].pointx + rows[i].pointy +"<br /";
	  	map.addOverlay(marker);
	  	var staid = rows[i].id;
	  	addClickHandler(content,staid,marker);  
        
    }
    function addClickHandler(content,staid,marker){  
        marker.addEventListener("click",function(e){  
        openInfo(" "+content,e);
        //alert(staid);
        $.ajax({  
            dataType:"json",         //��������Ϊjson��ʽ
            data:{"date":staid},
            contentType: "application/x-www-form-urlencoded; charset=utf-8", 
            type:"GET",  
            url:"/HangZhou/back",  
            statusCode: {404: function() {  
                 alert('page not found'); }  
              },      
            success:function(data,textStatus){ 
         	    alert(data.values[1]);
           	//var myChart = echarts.init(document.getElementById("main"));
           	var option = {
            	    title : {
            	        text: 'վ�����г������Ϣ',
            	        subtext: ''
            	    },
            	    tooltip : {
            	        trigger: 'axis'
            	    },
            	    legend: {
            	        data:['���','�黹']
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
            	                formatter: '{value} ��'
            	            }
            	        }
            	    ],
            	    series : [
            	        {
            	            name:'�������',
            	            type:'line',
            	            data:data.values,
            	            /*markPoint : {
            	                data : [
            	                    {type : 'max', name: '���ֵ'},
            	                    {type : 'min', name: '��Сֵ'}
            	                ]
            	            },
            	            markLine : {
            	                data : [
            	                    {type : 'average', name: 'ƽ��ֵ'}
            	                ]
            	            }*/
            	        },
            	        {
            	            name:'�黹����',
            	            type:'line',
            	            data:data.values,
            	            /*markPoint : {
            	                data : [
            	                    {name : '�����', value : -2, xAxis: 1, yAxis: -1.5}
            	                ]
            	            },
            	            markLine : {
            	                data : [
            	                    {type : 'average', name : 'ƽ��ֵ'}
            	                ]
            	            }*/
            	        }
            	    ]
            	};
           	if(data.values!=null)
           		myChart.setOption(option);
           	else
           		alert("���������վ��û��������Ϣ");
            }  
            }); 
        //marker.addEventlistener("click",);
    });  
    }
    //++  
    function openInfo(content,e){  
        var p = e.target;  
        var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);  
        var infoWindow = new BMap.InfoWindow(content,opts);  // ������Ϣ���ڶ���   
        map.openInfoWindow(infoWindow,point);                //������Ϣ����  
    } 
    
    function  func(){ 
   	 alert("<%=basePath%>");
   	 var options=$("#sel option:selected");  //��ȡѡ�е���
   	 var date=options.val();
   	 alert(options.val());
        $.ajax({  
            dataType:"json",         //��������Ϊjson��ʽ
            data:{"date":date},
            contentType: "application/x-www-form-urlencoded; charset=utf-8", 
            type:"GET",  
            url:"/HangZhou/back",  
            statusCode: {404: function() {  
                 alert('page not found'); }  
              },      
            success:function(data,textStatus){ 
         	    alert("ok");
           	//alert(data); 
            }  
            });  
          }
	
    <%
    //�ر����ݿ�����
    rs.close();
    stmt.close();
    conn.close();
    %>    
    </script>
</body>
</html>
