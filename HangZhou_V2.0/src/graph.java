import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.JSONException;
import org.json.JSONObject;

public class graph {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		JSONObject temp=new JSONObject();
		
		ArrayList<String> Lease  = new ArrayList<String>();
    	ArrayList<String> Return = new ArrayList<String>();
    	ArrayList<String> Sum = new ArrayList<String>();
		
		String lease;
		String retn;
		String sum;
		
		String sql="select leasestation,returnstation,sum(bikenum) from B_LEASEINFOHIS_SUM  GROUP BY LEASESTATION , RETURNSTATION";
		
		Connection conn = DBUtils.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				lease = rs.getString(1);
				retn  = rs.getString(2);
				sum   = rs.getString(3);
				Lease.add(lease);
				Return.add(retn);
				Sum.add(sum);
				System.out.println(lease+'\t'+retn+'\t'+sum);
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
            System.out.println("OK");
			System.out.println(temp);

	}

}
