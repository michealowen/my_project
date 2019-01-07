package entity;

import java.util.Date;

public class record {
	private Date leasedate;
	private int time;
	private int leasestation;
	private int returnstation;
	private int num;
	public Date getLeasedate() {
		return leasedate;
	}
	public void setLeasedate(Date leasedate) {
		this.leasedate = leasedate;
	}
	public int getTime() {
		return time;
	}
	public void setTime(int time) {
		this.time = time;
	}
	public int getLeasestation() {
		return leasestation;
	}
	public void setLeasestation(int leasestation) {
		this.leasestation = leasestation;
	}
	public int getReturnstation() {
		return returnstation;
	}
	public void setReturnstation(int returnstation) {
		this.returnstation = returnstation;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public record() {
		super();
		// TODO Auto-generated constructor stub
	}
	public record(Date leasedate, int time, int leasestation, int returnstation, int num) {
		super();
		this.leasedate = leasedate;
		this.time = time;
		this.leasestation = leasestation;
		this.returnstation = returnstation;
		this.num = num;
	}
	@Override
	public String toString() {
		return "record [leasedate=" + leasedate + ", time=" + time + ", leasestation=" + leasestation
				+ ", returnstation=" + returnstation + ", num=" + num + "]";
	}
	
	

}
