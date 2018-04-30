
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

public class New_YorkSel extends HttpServlet {

	private static final long serialVersionUID = 1L;  
	  
    public New_YorkSel() {  
        super();  
    }  
    
    public void destroy() {  
        super.destroy(); // Just puts "destroy" string in log  
        // Put your code here  
    }  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {
    	response.setCharacterEncoding("UTF-8");
    	System.out.println("niaho");
    	JSONObject temp=new JSONObject();
        double x;
        double y;
        ArrayList<Double> A= new ArrayList<Double>();
        ArrayList<Double> B= new ArrayList<Double>();
    	
	    String num = request.getParameter("num");
		//int sid = Integer.parseInt(ID);
		String sql = "select start_station_id,start_station_longitude,start_station_latitude,count(*) from CITI_BIKE_TRIP_DATA  group by "
				+ "start_station_id,start_station_longitude,start_station_latitude having count(*)>=?";
		
		
         Connection conn = DBUtils.getConnection();
         PreparedStatement ps = null;
         ResultSet rs = null;
		

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, num);
			rs = ps.executeQuery();
			while(rs.next()){
				x =  Double.parseDouble(rs.getString(2));
				y = Double.parseDouble(rs.getString(3));
				A.add(x);
				B.add(y);
				//System.out.println(lease+'\t'+retn+'\t'+sum+'\n');
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
			temp.put("A", A);
			temp.put("B", B);

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