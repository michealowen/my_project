import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBConnect {
	private static String url="jdbc:oracle:thin:@localhost:1521:orcl";	//systemΪ��½oracle���ݿ���û���
	private static String user="owen";  //managerΪ�û���system������
	private static String password="3856225";
	public static Connection conn;
	public static PreparedStatement ps;
	public static ResultSet rs;
	public static Statement st ;//�������ݿ�ķ���
	public static void getConnection(){
		try {
			//��ʼ��������
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//�������ݿ������ַ������ƣ������conn��ֵ
			conn=DriverManager.getConnection(url, user, password);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

}
