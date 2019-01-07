
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
    	System.out.println("你好");
    	JSONObject temp=new JSONObject();
    	//ArrayList<Integer> Time = new ArrayList<Integer>();
    	//ArrayList<Integer> Sum  = new ArrayList<Integer>();
		int time = 0;
		String sum = null;
		String ID = request.getParameter("date");
		//String city = request.getParameter("name");		
		String leaseSum[]= new String[24];
		String returnSum[]=new String[24];
		for(int i=0;i<24;i++){
			leaseSum[i]="0";
			returnSum[i]="0";
		}
		String Time[]={"00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"};
		
		//String sql = " SELECT LEASETIME ,COUNT(BIKENUM) AS SUM FROM T_123 WHERE LEASESTATION = ? GROUP BY LEASETIME";
		String sql1 = " SELECT LEASETIME ,COUNT(BIKENUM) AS SUM FROM B_LEASEINFOHIS_SUM WHERE LEASESTATION = ? GROUP BY LEASETIME";
		String sql2 = " SELECT LEASETIME ,COUNT(BIKENUM) AS SUM FROM B_LEASEINFOHIS_SUM WHERE RETURNSTATION = ? GROUP BY LEASETIME";
		
		Connection conn = DBUtils.getConnection();
		PreparedStatement ps1 = null,ps2 = null;
		ResultSet rs1 = null,rs2 = null;
		
		try {
			ps1 = conn.prepareStatement(sql1);
			ps1.setString(1, ID);
			ps2 = conn.prepareStatement(sql2);
			ps2.setString(1, ID);
			rs1 = ps1.executeQuery();
			rs2 = ps2.executeQuery();
			while(rs1.next()){
				time = rs1.getInt(1);
				sum  = rs1.getString(2);
				System.out.println(time+"\t"+sum+"\t");
				leaseSum[time%24] = sum;
			}
			
			while(rs2.next()){
				time = rs2.getInt(1);
				sum  = rs2.getString(2);
				System.out.println(time+"\t"+sum+"\t");
				returnSum[time%24] = sum;
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBUtils.close(rs1, ps1, conn);
			DBUtils.close(rs2, ps2, conn);

		}
        
		try {
			
				temp.put("catergories", Time);
				temp.put("values1", leaseSum);
				temp.put("values2", returnSum);
			//temp.put("catergories", Time);
			//temp.put("values", Sum);
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