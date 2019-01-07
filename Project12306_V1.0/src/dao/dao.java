//编写：刘继涛 
package dao;

import java.util.ArrayList;

public interface dao {
	
	boolean delete(int account);
	boolean login(int account,int password);
	ArrayList<String> findpath();
}
