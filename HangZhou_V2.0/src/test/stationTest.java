package test;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import entity.station;

public class stationTest {
	//private Session session = null;

	@Test
	public void excuteStation(){
		//json
		String posi[]={"120.11","123.4444"};
		System.out.println(posi[0]);
		System.out.println(posi[1]);
		
	}
	
	/*@Before
	public void setUp(){
		session  = Util.HibernateUtil.getSession();
	}
	@After
	public void tearDown(){
		session.close();
	}*/
}
