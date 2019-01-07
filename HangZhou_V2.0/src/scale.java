
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

public class scale extends HttpServlet {

	private static final long serialVersionUID = 1L;  
	  
    public scale() {  
        super();  
    }  
    
    public void destroy() {  
        super.destroy(); // Just puts "destroy" string in log  
        // Put your code here  
    }  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {
    	response.setCharacterEncoding("UTF-8");
    	System.out.println("你好");
    	JSONObject temp=new JSONObject();

    	int i = 0,sum=0;
    	String[] scale0;
        String[] scale1;
        
        System.out.println(request.getParameter("scale0"));
        scale0 = request.getParameterValues("scale0");
        System.out.println(scale0.length);
        scale1 = request.getParameterValues("scale1");
		//int sid = Integer.parseInt(ID);
		String sql = " SELECT COUNT(*) FROM B_LEASEINFOHIS_SUM where leasestation in (";
		
		for(i=0;i<scale0.length-1;i++){
			sql+="'"+scale0[i]+"',";
		}
		 sql+="'"+scale0[scale0.length-1]+"')";//去掉最后一个逗号
		 
		 sql+="and returnstation in (";
		 
		 for(i=0;i<scale1.length-1;i++){
				sql+="'"+scale1[i]+"',";
			}
			 sql+="'"+scale1[scale1.length-1]+"')";//去掉最后一个逗号

		System.out.println(sql);
			 
         Connection conn = DBUtils.getConnection();
         PreparedStatement ps = null;
         ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
			sum = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		finally{

			DBUtils.close(rs, ps, conn);
		}

		try {
			temp.put("sum", sum);
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