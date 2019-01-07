//编写：刘继涛
package service;

import java.util.ArrayList;

import org.json.JSONObject;

import dao.userDao;

public class loginservice {
	
	private userDao userd;

	public void setUserd(userDao userd) {
		this.userd = userd;
	}

	public boolean login(int account,int password){
		System.out.println("登录service执行了");
		return userd.login(account,password);
		//return true;
		}
	public boolean delete(int account){
		System.out.println("删除用户service执行了");
		return userd.delete(account);
		//return true;
		}
	
	

}
