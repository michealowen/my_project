//编写：刘继涛  
package entity;

public class station {
	private int id;
	private String First_station;
	private String Next_station;
	private int Run_distance;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirst_station() {
		return First_station;
	}
	public void setFirst_station(String first_station) {
		First_station = first_station;
	}
	public String getNext_station() {
		return Next_station;
	}
	public void setNext_station(String next_station) {
		Next_station = next_station;
	}
	public int getRun_distance() {
		return Run_distance;
	}
	public void setRun_distance(int run_distance) {
		Run_distance = run_distance;
	}
	
	public station() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "station [id=" + id + ", First_station=" + First_station + ", Next_station=" + Next_station
				+ ", Run_distance=" + Run_distance + "]";
	}
	
	
}
