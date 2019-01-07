
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpServlet;

public class info_kibana extends HttpServlet {

	
	    public static void main(String args[]) throws IOException{
    	
    	float x,y;  //站点经纬度
    	String name;//站点名称
    	int id;     //站点id

    	int i=1;
    	
    	File file = new File("C:\\stationInfo.json");
    	BufferedWriter writer1 = null;
    	
    	writer1 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file),"GBK"));
    	

		//String sql1= "select * from B_STATIONINFO_BRIEF ";
        String sql1="SELECT STATIONID,STATIONNAM,X,Y FROM B_STATIONINFO_BRIEF";
		
		Connection conn = DBUtils.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			i++;
			ps = conn.prepareStatement(sql1);
			rs = ps.executeQuery();
			while(rs.next()){
				i++;
				x = Float.parseFloat(rs.getString(3));
				y = Float.parseFloat(rs.getString(4));
				name = rs.getString(2);
				id  = Integer.parseInt(rs.getString(1));
				
				writer1.write("{\"index\":{\"_id\":\""+i+"\"}}"+"\r\n");
				writer1.write("{\"s_id\":"+id+",\"s_name\":\""+name+"\",\"location\":{\"lat\":"+y+",\"lon\":"+ x+"}}"+"\r\n");
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DBUtils.close(rs, ps, conn);
		}
		
		writer1.close();
		
    }  
  

  


}  