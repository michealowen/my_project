//编写：刘继涛
package service;

import dao.userDao;

public class stationManSer {
	
	userDao userd;

	public userDao getUserd() {
		return userd;
	}

	public void setUserd(userDao userd) {
		this.userd = userd;
	}
	
	public void stationMan(String start,String term,int distance){
		System.out.println("站点管理service执行了");
		userd.stationMan(start, term, distance);
	}

}
