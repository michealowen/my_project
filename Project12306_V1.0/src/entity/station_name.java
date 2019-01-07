//编写：刘继涛
package entity;

public class station_name {
	private String realname;//վ����
	private String   code;
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	@Override
	public String toString() {
		return "station_name [realname=" + realname + ", code=" + code + "]";
	}
	public station_name() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

}
