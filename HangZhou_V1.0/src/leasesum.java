
import java.sql.* ;


public class leasesum {
	
	//orclΪoracle���ݿ��е����ݿ�����localhost��ʾ���ӱ�����oracle���ݿ�
	   //1521Ϊ���ӵĶ˿ں�
		private static String url="jdbc:oracle:thin:@localhost:1521:orcl";   //systemΪ��½oracle���ݿ���û���
		private static String user="owen";                                   //managerΪ�û���system������
		private static String password="3856225";
		public static Connection conn;
		public static PreparedStatement ps;
		public static ResultSet rs;
		public static Statement st ;
		
		
		
		//�������ݿ�ķ���
		public void getConnection(){
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
		 //�����ܷ���oracle���ݿ����ӳɹ�

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		String date = null;
		String station = null;
		leasesum sum = new leasesum();
		sum.getConnection();
		if(conn==null){
			System.out.println("��oracle���ݿ�����ʧ�ܣ�");
		}else{
			System.out.println("��oracle���ݿ����ӳɹ���");				
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
