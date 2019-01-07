//编写：刘继涛
package service;

import java.util.ArrayList;

import dao.userDao;

public class listservice {
	
	private userDao userd;
	
	

	public userDao getUserd() {
		return userd;
	}



	public void setUserd(userDao userd) {
		this.userd = userd;
	}



	public ArrayList<String> liststation(){
		System.out.println("list service执行了");
		return userd.getAllstationInfo();
	}

}
