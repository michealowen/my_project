//编写：刘继涛         修改：刘琦
package entity;

public class Train {
	   public  int id;
	   public  String Train_number;
	   public  String Train_type;
	   public  String Start_station;
	   public  String Term_station;
	   public  String Pass_station;
	   public  String Tickets;
	   public  String Waittime;
	   public  String start_time;
	   
	public  int getid(){
		   return id;
	   }
	   public  void setid(int id){
		   this.id = id;
	   }
	   public String Train_number(){
		   return Train_number;
	   }
	   public  void setTrain_number(String Train_number){
		   this.Train_number = Train_number;
	   }
	   public String getTrain_type(){
		   return Train_type;
	   }
	   public void setTrain_type(String Train_type){
		   this.Train_type = Train_type;
	   }
	   public String getStart_station(){
		   return Start_station;
	   }
	   public void setStart_station(String Start_station){
		   this.Start_station = Start_station;
	   }
	   public String getTerm_station(){
		   return Term_station;
	   }
	   public void setTerm_station(String Term_station){
		   this.Term_station = Term_station;
	   }
	   public String getPass_station(){
		   return Pass_station;
	   }
	   public void setPass_station(String Pass_station){
		   this.Pass_station = Pass_station;
	   }
	   public String getTickets(){
		   return Tickets;
	   }
	   public void setTikets(String Tickets){
		   this.Tickets = Tickets;
	   }
	   public String getWaittime(){
		   return Waittime;
	   }
	   public void setWaittime(String Waittime){
		   this.Waittime = Waittime;
	   }
	@Override
	public String toString() {
		return "Train [id=" + id + ", Train_number=" + Train_number + ", Train_type=" + Train_type + ", Start_station="
				+ Start_station + ", Term_station=" + Term_station + ", Pass_station=" + Pass_station + ", Tickets="
				+ Tickets + ", Waittime=" + Waittime + ", Start_time=" + start_time +"]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTrain_number() {
		return Train_number;
	}
	public void setTickets(String tickets) {
		Tickets = tickets;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	
	public Train() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Train(int id, String train_number, String train_type, String start_station, String term_station,
			String pass_station, String tickets, String waittime, String start_time) {
		super();
		this.id = id;
		Train_number = train_number;
		Train_type = train_type;
		Start_station = start_station;
		Term_station = term_station;
		Pass_station = pass_station;
		Tickets = tickets;
		Waittime = waittime;
		this.start_time = start_time;
	}
	   
	
	   
	}
