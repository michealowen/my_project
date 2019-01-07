import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBConnect {
	private static String url="jdbc:oracle:thin:@localhost:1521:orcl";	//system为登陆oracle数据库的用户名
	private static String user="owen";  //manager为用户名system的密码
	private static String password="3856225";
	public static Connection conn;
	public static PreparedStatement ps;
	public static ResultSet rs;
	public static Statement st ;//连接数据库的方法
	public static void getConnection(){
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

}
