package test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Util.JDBCutil;

import org.json.JSONException;
import org.json.JSONObject;

public class testselect {
	
	public static void main(String args[]){
		//String id = request.getParameter("sid");
    	String id = "2220";
		System.out.println(id);
    	int id1,id2;     //站点id
    	//String address;//站点地址
    	int sum;
    	JSONObject temp=new JSONObject();
    	
    	//ArrayList<String> Name = new ArrayList<String>();
    	//ArrayList<String> Address = new ArrayList<String>();
    	ArrayList<Integer> ID1 = new ArrayList<Integer>();
    	ArrayList<Integer> ID2 = new ArrayList<Integer>();
    	ArrayList<Integer> SUM = new ArrayList<Integer>();
    	
		String sql= "select * from(select leasestation,returnstation,sum(bikenum) from B_LEASEINFOHIS_SUM where"
				+ " leasestation = ? and leasestation!=returnstation group by leasestation, returnstation order by sum(bikenum) desc) "
				+ "where rownum<=10";
		//String sql1="select * from B_STATIONINFO_BRIEF";

		Connection conn = JDBCutil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,id );
			//ps.setInt(1, 2220);
			//rs=conn.
			rs = ps.executeQuery();
			while(rs.next()){
				id1  = Integer.parseInt(rs.getString(1));       //查询数据库是从第零列开始的
				id2  = Integer.parseInt(rs.getString(2));
				sum  = rs.getInt(3);
				ID1.add(id1);
				ID2.add(id2);
				SUM.add(sum);
				//System.out.println(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			//通过工具类关闭数据库连接
			JDBCutil.close(ps, conn);
		}
        //向前台的页面输出结果
		try {
			temp.put("ID1", ID1);
			temp.put("ID2", ID2);
			temp.put("SUM", SUM);
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		
			System.out.println(temp);
	}

}
