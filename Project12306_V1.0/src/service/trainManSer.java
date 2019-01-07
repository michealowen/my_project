//编写：刘继涛      
package service;

import java.util.ArrayList;

import dao.userDao;
import entity.Train;

public class trainManSer {
	
	userDao userd;
    
	public userDao getUserd() {
		return userd;
	}

	public void setUserd(userDao userd) {
		this.userd = userd;
	}
	
	public void stationMan(Train t){
		System.out.println("车次管理service执行了");
		userd.trainMan(t);
	}
	
	public boolean stationDelete(String train_number){
		System.out.println("车次删除service执行了");
		
		return userd.trainDel(train_number);
	}
	
	public ArrayList<String> trainlist(){
		return userd.trainlist();
	}

}
