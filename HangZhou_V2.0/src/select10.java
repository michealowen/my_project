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

public class select10 extends HttpServlet {

	private static final long serialVersionUID = 1L;  
	  
    public select10() {  
        super();  
    }  
    
    public void destroy() {  
        super.destroy(); // Just puts "destroy" string in log  
        // Put your code here  
    }  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {
    	response.setCharacterEncoding("UTF-8");
    	String id = request.getParameter("sid");
    	System.out.println(id);
    	int id1,id2;     
    	//String address;
    	int sum;
    	JSONObject temp=new JSONObject();
    	int i=0;
    	
    	//ArrayList<String> Name = new ArrayList<String>();
    	//ArrayList<String> Address = new ArrayList<String>();
    	ArrayList<Integer> ID1 = new ArrayList<Integer>();
    	ArrayList<Integer> ID2 = new ArrayList<Integer>();
    	ArrayList<Integer> SUM = new ArrayList<Integer>();
    	
		String sql= "select * from(select leasestation,returnstation,sum(bikenum) from B_LEASEINFOHIS_SUM where"
				+ " leasestation = ?  group by leasestation, returnstation order by sum(bikenum) desc) "
				+ "where rownum<=9 and leasestation!=returnstation";
        String sql1="select leasestation ,returnstation,sum(bikenum) from B_LEASEINFOHIS_SUM where leasestation in"
        		+"(?,?,?,?,?,?,?,?,?,?) and returnstation in (?,?,?,?,?,?,?,?,?,?)  group by leasestation,returnstation order by leasestation";
		Connection conn = DBUtils.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,id );
			rs = ps.executeQuery();
			while(rs.next()){
				id1  = Integer.parseInt(rs.getString(1));
				id2  = Integer.parseInt(rs.getString(2));
				sum  = rs.getInt(3);
				ID2.add(id2);
			}
			ID2.add(Integer.parseInt(id));
			ps = conn.prepareStatement(sql1);
			System.out.println(ID2.toString());
			if(ID2.size()!=10) 
			{
				//若点集不为10，则返回错误
				DBUtils.close(rs, ps, conn);
				try {
					temp.put("error", "error");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				PrintWriter out=response.getWriter();
		        out.println(temp);
		        out.close();
		        return;
			}
			for(i=0;i<20;i++){
				ps.setString(i+1, ID2.get(i%10).toString());
			}
			rs=ps.executeQuery();
			ID2.clear();
			while(rs.next()){
				id1  = Integer.parseInt(rs.getString(1));
				id2  = Integer.parseInt(rs.getString(2));
				sum  = rs.getInt(3);
				ID1.add(id1);
				ID2.add(id2);
				SUM.add(sum);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBUtils.close(rs, ps, conn);
		}
		try {
			temp.put("ID1", ID1);
			temp.put("ID2", ID2);
			temp.put("SUM", SUM);
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
            //System.out.println(ID2);		
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