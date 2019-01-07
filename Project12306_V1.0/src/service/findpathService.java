//编写：刘继涛
package service;

import java.util.ArrayList;
import java.util.Scanner;

import org.json.JSONException;
import org.json.JSONObject;

import dao.userDao;


public class findpathService {
	
	private userDao userd;
	
	public void setUserd(userDao userd) {
		this.userd = userd;
	}
	
	public ArrayList<String> find(String start,String term){
	    s s1 = new s();
	    s.soure.clear();
	    ArrayList<String> consequence = new ArrayList<String>();
	    consequence = s1.find(start, term);
	    System.out.println(consequence);
	    //s.soure.clear();
	    return consequence;
		
	}
	
public ArrayList<String> query(ArrayList<String> str) throws JSONException{
		
		return userd.query(str);
	}
	

}
