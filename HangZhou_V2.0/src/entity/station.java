package entity;

public class station {
	private int sid;
	private String sname;
	private double x;
	private double y;
	private double baidux;
	private double baiduy;
	private String address;
	private String serviceTime;
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public double getX() {
		return x;
	}
	public void setX(double x) {
		this.x = x;
	}
	public double getY() {
		return y;
	}
	public void setY(double y) {
		this.y = y;
	}
	public double getBaidux() {
		return baidux;
	}
	public void setBaidux(double baidux) {
		this.baidux = baidux;
	}
	public double getBaiduy() {
		return baiduy;
	}
	public void setBaiduy(double baiduy) {
		this.baiduy = baiduy;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getServiceTime() {
		return serviceTime;
	}
	public void setServiceTime(String serviceTime) {
		this.serviceTime = serviceTime;
	}
	public station(int sid, String sname, double x, double y, double baidux, double baiduy, String address,
			String serviceTime) {
		super();
		this.sid = sid;
		this.sname = sname;
		this.x = x;
		this.y = y;
		this.baidux = baidux;
		this.baiduy = baiduy;
		this.address = address;
		this.serviceTime = serviceTime;
	}
	public station() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "station [sid=" + sid + ", sname=" + sname + ", x=" + x + ", y=" + y + ", baidux=" + baidux + ", baiduy="
				+ baiduy + ", address=" + address + ", serviceTime=" + serviceTime + "]";
	}
	
	

}
