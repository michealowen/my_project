
import java.sql.* ;


public class leasesum {
	
	//orcl为oracle数据库中的数据库名，localhost表示连接本机的oracle数据库
	   //1521为连接的端口号
		private static String url="jdbc:oracle:thin:@localhost:1521:orcl";   //system为登陆oracle数据库的用户名
		private static String user="owen";                                   //manager为用户名system的密码
		private static String password="3856225";
		public static Connection conn;
		public static PreparedStatement ps;
		public static ResultSet rs;
		public static Statement st ;
		
		
		
		//连接数据库的方法
		public void getConnection(){
			try {
				//初始化驱动包
				Class.forName("oracle.jdbc.driver.OracleDriver");
				//根据数据库连接字符，名称，密码给conn赋值
				conn=DriverManager.getConnection(url, user, password);
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		 //测试能否与oracle数据库连接成功

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		String date = null;
		String station = null;
		leasesum sum = new leasesum();
		sum.getConnection();
		if(conn==null){
			System.out.println("与oracle数据库连接失败！");
		}else{
			System.out.println("与oracle数据库连接成功！");				
		}
		try{
			st = conn.createStatement();
			rs = st.executeQuery(" SELECT LEASETIME ,COUNT(BIKENUM) AS SUM FROM T_123 "
					+ "WHERE LEASESTATION = '6228' GROUP BY LEASETIME");
		while(rs.next()){
			date    = rs.getString(1);
			station = rs.getString(2);
			//time =   Integer.parseInt(rs.getString(3));
			//summary = Integer.parseInt(rs.getString(4));
			System.out.println(date+'\t'+station+'\t');
		}
		
		
		
		conn.close();
	}
	catch(Exception e)
	{
	   e.printStackTrace();	
	}
	
       
	}

}
