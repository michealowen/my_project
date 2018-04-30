
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

public class Orient extends HttpServlet {

	private static final long serialVersionUID = 1L;  
	  
    public Orient() {  
        super();  
    }  
    
    public void destroy() {  
        super.destroy(); // Just puts "destroy" string in log  
        // Put your code here  
    }  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {
    	response.setCharacterEncoding("UTF-8");
    	
    	float x,y;  //经纬度
    	String name;//站点名称
    	int id;     //站点id
    	String address;//站点地址
    	JSONObject temp=new JSONObject();
    	
    	ArrayList<String> Name = new ArrayList<String>();
    	ArrayList<String> Address = new ArrayList<String>();
    	ArrayList<Integer> ID = new ArrayList<Integer>();
    	ArrayList<Float> X = new ArrayList<Float>();
    	ArrayList<Float> Y = new ArrayList<Float>();
		String sql = " SELECT q.STATIONID,q.STATIONNAME,q.ADDRESS,w.BAIDU_X,w.BAIDU_Y "+
    "FROM G_STATIONINFO q INNER JOIN G_STATIONORIENT w ON q.STATIONID=w.STATIONID";
		//String sql1= "select * from B_STATIONINFO_BRIEF ";

		Connection conn = DBUtils.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				x = Float.parseFloat(rs.getString(4));
				y = Float.parseFloat(rs.getString(5));
				name = rs.getString(2);
				id  = Integer.parseInt(rs.getString(1));
				address  = rs.getString(3);
				Name.add(name);
				ID.add(id);
				Address.add(address);
				X.add(x);
				Y.add(y);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			//通过工具类关闭数据库连接
			DBUtils.close(rs, ps, conn);
		}
        //向前台的页面输出结果
		try {
			temp.put("X", X);
			temp.put("Y", Y);
			temp.put("Name",Name );
			temp.put("ID", ID);
			temp.put("Address", Address);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		
			System.out.println(temp);
        PrintWriter out=response.getWriter();
        out.println(temp);
        out.close();
    }  
  
    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
  
        response.setContentType("text");  
        PrintWriter out = response.getWriter();  
        out.flush();  
        out.close();  
    }  
  

    public void init() throws ServletException {  
        // Put your code here  
    }  
  
}  