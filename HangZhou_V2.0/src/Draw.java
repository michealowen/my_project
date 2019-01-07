
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

public class Draw extends HttpServlet {

	private static final long serialVersionUID = 1L;  
	  
    public Draw() {  
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
    	String lease = null;
    	String retn  = null;
    	String sum   = null;
    	ArrayList<String> Lease  = new ArrayList<String>();
    	ArrayList<String> Return = new ArrayList<String>();
    	ArrayList<String> Sum = new ArrayList<String>();
    	
	    String num = request.getParameter("num");
	    String dateStart = request.getParameter("dateStart");
	    String hourStart = request.getParameter("hourStart");
	    String dateEnd = request.getParameter("dateEnd");
	    String hourEnd = request.getParameter("hourEnd");
		//int sid = Integer.parseInt(ID);
		/*String sql = " SELECT LEASESTATION ,RETURNSTATION,COUNT(*) AS SUM FROM B_LEASEINFOHIS_SUM where "
				+ "leasestation in(select stationid from G_STATIONORIENT)and returnstation in (select stationid from G_STATIONORIENT) "
				+ "and leasedate BETWEEN ? and ? and LEASETIME BETWEEN ? and ?"
				+ " GROUP BY LEASESTATION,RETURNSTATION HAVING COUNT(*)>= ?";
        */
	    String sql = "SELECT LEASESTATION ,RETURNSTATION,sum(BIKENUM) FROM B_LEASEINFOHIS_SUM "
	    		+ "where leasedate BETWEEN ? and ? and LEASETIME BETWEEN ? and ? "
	    		+ "GROUP BY LEASESTATION,RETURNSTATION HAVING sum(BIKENUM)>=? ";
         Connection conn = DBUtils.getConnection();
         PreparedStatement ps = null;
         ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,dateStart);
			ps.setString(2,dateEnd);
			ps.setString(3,hourStart);
			ps.setString(4,hourEnd);
			ps.setString(5,num);
			rs = ps.executeQuery();
			while(rs.next()){
				lease = rs.getString(1);
				retn  = rs.getString(2);
				sum   = rs.getString(3);
				Lease.add(lease);
				Return.add(retn);
				Sum.add(sum);
				//System.out.println(lease+'\t'+retn+'\t'+sum);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		finally{

			DBUtils.close(rs, ps, conn);
		}

		try {
			temp.put("lease", Lease);
			temp.put("retn", Return);
			temp.put("sum", Sum);
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