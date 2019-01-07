//编写：刘继涛
package entity;
/**
 * 
 * @author owen
 *
 */
public class users {
	private int userid;
	private String username;
	private int password;
	
	
	public int getUserid() {
		return userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public int getPassword() {
		return password;
	}
	public void setPassword(int password) {
		this.password = password;
	}

	public users() {
		super();
		// TODO Auto-generated constructor stub
	}
	public users(int userid, String username, int password) {
		super();
		this.userid = userid;
		this.username = username;
		this.password = password;
	}
	@Override
	public String toString() {
		return "users [userid=" + userid + ", username=" + username + ", password=" + password + "]";
	}
	
	
	
	

}
