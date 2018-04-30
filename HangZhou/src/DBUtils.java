  
 import java.sql.Connection;
 import java.sql.DriverManager;
 import java.sql.ResultSet;
 import java.sql.SQLException;
 import java.sql.Statement;
 import java.util.ResourceBundle;
 
 /**
  * ���ݿ����������
  * @author 刘继涛
  *
  */
 public class DBUtils {
     
    //url
     public static String URL;
    //username
     public static String USERNAME;
     //password
     public static String PASSWORD;
     //oracle驱动
     public static String DRIVER;
     
     private static ResourceBundle rb = ResourceBundle.getBundle("db-config");
     
     private DBUtils(){}
     
     static{
         URL = rb.getString("jdbc.url");
         USERNAME = rb.getString("jdbc.username");
         PASSWORD = rb.getString("jdbc.password");
         DRIVER = rb.getString("jdbc.driver");
         try {
             //Class.forName(DRIVER);
        	 Class.forName("oracle.jdbc.driver.OracleDriver");
         } catch (ClassNotFoundException e) {
             e.printStackTrace();
         }
     }
     //建立连接
     public static Connection getConnection(){
         Connection conn = null;
         try {
             conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
         } catch (SQLException e) {
             e.printStackTrace();
             System.out.println("数据库连接失败");
         }
         return conn;
     }
     
     /**
      * @param rs
      * @param stat
      * @param conn
      */
     public static void close(ResultSet rs,Statement stat,Connection conn){
             try {
                 if(rs!=null)rs.close();
                 if(stat!=null)stat.close();
                 if(conn!=null)conn.close();
             } catch (SQLException e) {
                 e.printStackTrace();
             }
     }
     
 }