
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

public class back extends HttpServlet {

	private static final long serialVersionUID = 1L;  
	  
    public back() {  
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
    	ArrayList<String> Time = new ArrayList<String>();
    	ArrayList<String> Sum  = new ArrayList<String>();
		String time = null;
		String sum = null;
		String ID = request.getParameter("date");
		String city = request.getParameter("name");
		System.out.println(city);
		//String sql = " SELECT LEASETIME ,COUNT(BIKENUM) AS SUM FROM T_123 WHERE LEASESTATION = ? GROUP BY LEASETIME";
		String sql = " SELECT LEASETIME ,COUNT(BIKENUM) AS SUM FROM B_LEASEINFOHIS_SUM WHERE LEASESTATION = ? GROUP BY LEASETIME";
		
		Connection conn = DBUtils.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, ID);
			rs = ps.executeQuery();
			while(rs.next()){
				time = rs.getString(1);
				sum  = rs.getString(2);
				Time.add(time);
				Sum.add(sum);
				System.out.println(time+'\t'+sum+'\t');
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
			temp.put("catergories", Time);
			temp.put("values", Sum);
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