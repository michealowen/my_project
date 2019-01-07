//编写：刘继涛       修改：刘琦
package dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import entity.Train;
import entity.station;
import entity.station_name;
import entity.users;

/**
 * 
 * @author owen
 *
 */
public class userDao extends HibernateDaoSupport implements dao {

	public boolean login(int account, int password) {
		System.out.println("dao的登录方法执行了");
		List<users> u = this.getHibernateTemplate().find("from users where userid=? and password=?", account, password);
		Boolean flag = false;
		if (u.size() > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean delete(int account) {
		// TODO Auto-generated method stub
		System.out.println("dao的删除方法执行了");
		List<users> u = this.getHibernateTemplate().find("from users where userid=? ", account);
		// this.getHibernateTemplate().delete(u);
		Boolean flag = false;
		if (u.size() > 0) {
			flag = true;
			this.getHibernateTemplate().delete(u.get(0));
		}
		return flag;
	}

	public ArrayList<String> findpath() {
		ArrayList<String> path = new ArrayList<String>();
		List<Train> trains = this.getHibernateTemplate().find("from Train");
		// iterator it = new itertor();
		for (int i = 0; i < trains.size(); i++) {
			path.add(trains.get(i).getStart_station() + trains.get(i).getPass_station()
					+ trains.get(i).getTerm_station());
			System.out.println(path);
		}
		return path;

	}

	public ArrayList<String> findpa(String start, String end) {
		ArrayList<String> path = new ArrayList<String>();
		char a = 'a';
		char b = 'a';
		String[] city = { "北京", "天津", "石家庄", "济南", "郑州", "商丘", "西安", "连云港", "武汉", "长沙", "南昌", "南京", "上海", "杭州", "徐州" };
		for (int i = 0; i < 15; i++) {
			if (city[i] == start) {
				a += i;
			}
		}
		for (int i = 0; i < 15; i++) {
			if (city[i] == start) {
				b += i;
			}
		}
		List<Train> trains = this.getHibernateTemplate().find("from Train where Start_station=? and Term_station=?", a,
				b);
		for (int i = 0; i < trains.size(); i++) {
			path.add(trains.get(i).getStart_station() + trains.get(i).getPass_station()
					+ trains.get(i).getTerm_station());
			System.out.println(path);
		}
		return path;
	}
	/*
	 * public char[] getAllcode(){ //找出所有站点代号 char code[]={}; List<station_name>
	 * station_names = this.getHibernateTemplate().find("from station_name ");
	 * for(int i = 0;i <station_names.size();i++){
	 * code[i]=station_names.get(i).getCode(); } return code; }
	 */

	public ArrayList<String> getAllstationInfo() {
		// 找出所有站点信息
		System.out.println("list dao开始执行");
		ArrayList<String> info = new ArrayList<String>(); // 装有所有站点信息的字符串
		info.add("ssss");
		List<station_name> station_names = this.getHibernateTemplate().find("from station_name ");
		for (int i = 0; i < station_names.size(); i++) {
			// code[i]=station_names.get(i).getCode();
			System.out.println(i);
			info.add(station_names.get(i).getCode() + station_names.get(i).getRealname());
		}
		System.out.println(info);
		return info;
	}
    /*
	public ArrayList<String> query(ArrayList<String> str) throws JSONException {
		
		// TODO Auto-generated method stub
		// System.out.println(str.get(0).substring(0,1)+str.get(0).substring(str.get(0).length()-1,str.get(0).length())+str.get(0).substring(1,str.get(0).length()-1));
		// JSONObject data = new JSONObject();
		System.out.println("dao");
		ArrayList<String> all = new ArrayList<String>();
		for (int i = 0; i < str.size(); i++) {
			String c1 = str.get(i).substring(0, 1);
			String c2 = str.get(i).substring(str.get(i).length() - 1, str.get(i).length());
			String str1 = str.get(i).substring(1, str.get(i).length() - 1);
			System.out.println(c1 + c2 + str1);
			List<Train> trains = this.getHibernateTemplate()
					.find("from Train where Start_station =? and Term_station =? and Pass_station =?", c1, c2, str1);
			all.add(trains.get(0).getTrain_number() + "," + trains.get(0).getStart_time() + "," + "23:12" + "," + "26小时"
					+ "," + "250" + "," + trains.get(0).getTickets());
			System.out.println(trains.size());
		}

		System.out.println(all);
		return all;
	}
	*/
	
public ArrayList<String> query(ArrayList<String> str) throws JSONException {
		
		System.out.println("生成车票信息的dao");
		System.out.println(str);
	    SQLQuery query;
	    Number dis;  //里程
	    double price=0;//票价
	    int arrivetime = 0;//到达时间
	    double runtime = 0;//火车运行时间
	    int run;
	    int waittime = 0;//火车中途停留时间
	    int index1,index2;//起始站和终点站在字符串中的次序
	    int tickets = 0;//余票
	    String s;
	    Session session = this.getSession();              //创建过多的session会导致连接不够用
	    Transaction tx = session.beginTransaction(); 
		ArrayList<String> all = new ArrayList<String>();
		for (int i = 0; i < str.size(); i++) {
			System.out.println("i="+i);
			List<Train> trains = this.getHibernateTemplate()
					.find("from Train where concat(Start_station,Pass_station,Term_station) like"+ "'%"+str.get(i)+"%'" );
			if(trains.size()==0)
				continue;
			String queryString = "select sum(run_distance) from station where ";
			for(int k=1;k<str.get(i).length();k++){
				System.out.println("开始计算路程"+k);
		
				queryString +="first_station="+"'"+str.get(i).charAt(k-1)+"'"+" and next_station= "+"'"+str.get(i).charAt(k)+"'";
				if(k!=str.get(i).length()-1)
					queryString +=" or ";
			}
			System.out.println(queryString);
			//this.getSession().beginTransaction();
			query = session.createSQLQuery(queryString);

			System.out.println("距离是");
			//System.out.println(query.toString());
			dis =  (Number)query.list().get(0);
			System.out.println(dis);

			for(int n = 0; n < trains.size(); n++){
				System.out.println("列车"+n);
				switch(trains.get(n).getTrain_type())
				{
				    case "K":price=Math.ceil(0.2*dis.doubleValue());runtime=dis.doubleValue()/80;break;
				    case "T":price=Math.ceil(0.24*dis.doubleValue());runtime=dis.doubleValue()/100;break;
				    case "D":price=Math.ceil(0.5*dis.doubleValue());runtime=dis.doubleValue()/200;break;
				    case "G":price=Math.ceil(0.6*dis.doubleValue());runtime=dis.doubleValue()/300;break;
				}
				
				s=trains.get(n).getStart_station()+trains.get(n).getPass_station()+trains.get(n).getTerm_station();
				index1=s.indexOf(str.get(i).charAt(0));
				index2=s.indexOf(str.get(i).substring(str.get(i).length()-1));
				for(int t=1;t<(index2-index1);t++){
					waittime+=Integer.parseInt(trains.get(n).getWaittime().substring(2*t-2, 2*t));
				}
				for(int t=1;t<=(index2-index1);t++){
					tickets+=Integer.parseInt(trains.get(n).getTickets().substring(2*t-2, 2*t));
				}
				run=(int) ((Math.floor(runtime)+(waittime+(runtime-Math.floor(runtime))*60)/60)*100+(waittime+(runtime-Math.floor(runtime))*60)%60);
				System.out.println(run);
				//arrivetime=(int) ((Double.parseDouble(trains.get(n).getStart_time())/100+Math.floor(runtime))*100+(runtime-Math.floor(runtime))*60+Double.parseDouble(trains.get(n).getStart_time())%100);
				arrivetime=Integer.parseInt(trains.get(n).getStart_time())+run;
				arrivetime=(arrivetime/100+(arrivetime%100)/60)*100+(arrivetime%100)%60;
				all.add(trains.get(n).getTrain_number() + "," + trains.get(n).getStart_time() + "," + arrivetime + "," + run
					+ "," + price + "," + tickets +"," +dis);
			}

			
		}
        tx.commit();
		session.close();
		System.out.println(all);
		return all;
	}
	
	

	public ArrayList<String> calculate(ArrayList<String> str) {
		

		return str;
	}

	public void stationMan(String start, String term, int distance) {
		int id = 30;
		System.out.println("存储station的dao");
		station s = new station();
		s.setId(id);
		s.setFirst_station(start);
		s.setNext_station(term);
		s.setRun_distance(distance);
		this.getHibernateTemplate().save(s);
		System.out.println("添加完成");
	}

	public void trainMan(Train t) {
		int id = 10;
		System.out.println("存储train的dao");
		System.out.println(t.Train_number);
		this.getHibernateTemplate().save(t);
		System.out.println("列车添加完成");
	}

	public boolean trainDel(String train_number) {
		System.out.println("车次删除的dao执行了");
		List<Train> t = this.getHibernateTemplate().find("from Train where Train_number=? ", train_number);
		Boolean flag = false;
		if (t.size() > 0) {
			flag = true;
			this.getHibernateTemplate().delete(t.get(0));
		}
		return flag;
	}

	/**
	 * 列出所有车次信息
	 */
	public ArrayList<String> trainlist() {
		System.out.println("列出所有车次信息的dao");
		ArrayList<String> all = new ArrayList<String>();
		List<Train> t = this.getHibernateTemplate().find("from Train");
		for (int i = 0; i < t.size(); i++) {
			all.add(t.get(i).getTrain_number() + "," + t.get(i).getStart_time() + "," + "23:12" + "," + "26小时" + ","
					+ "250" + "," + t.get(i).getTickets());
		}
		System.out.println(all);
		return all;
	}

}
