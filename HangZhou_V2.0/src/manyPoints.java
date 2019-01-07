

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Util.JDBCutil;

public class manyPoints extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public manyPoints() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setCharacterEncoding("UTF-8");
		
		
		String x=request.getParameter("posix");
		String y=request.getParameter("posiy");
		System.out.print(x);
		System.out.print(y);
		Connection conn = null;
		String sql="select stationid, stationname, address, servicetime from B_STATIONINFO_BRIEF where baidu_x=? and baidu_y=?";
		conn = JDBCutil.getConnection();
		try{
			System.out.println("begin");
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, x);
			ps.setString(2, y);
		    ResultSet rs = ps.executeQuery();
		    while(rs.next())
		    {
		    	System.out.println("in");
		    	System.out.println(rs.getString(1));
		    	//System.out.println(rs.getString(1)+rs.getString(2)+rs.getString(3)+rs.getString(4));
		    }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
