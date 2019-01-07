//编写：刘继涛
package action;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.json.JSONException;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import entity.Train;
import service.listservice;
import service.loginservice;
import service.stationManSer;
import service.trainManSer;

public class action extends ActionSupport{
	private int account;
	private int password;      
	private loginservice loginser;
	private listservice listser;
	private String start;
	private String term;
	private int distance;  
	private stationManSer stationMser;
	
	public  int id;

	private  String Train_number;
	private  String Train_type;
	private  String Start_station;
	private  String Term_station;
	private  String Pass_station;
	private  String Tickets;
	private  String Waittime;
	private  String start_time;
	
	private  trainManSer trainMser;
	
	public String getTrain_number() {
		return Train_number;
	}
	public void setTrain_number(String train_number) {
		Train_number = train_number;
	}
	public String getTrain_type() {
		return Train_type;
	}
	public void setTrain_type(String train_type) {
		Train_type = train_type;
	}
	public String getStart_station() {
		return Start_station;
	}
	public void setStart_station(String start_station) {
		Start_station = start_station;
	}
	public String getTerm_station() {
		return Term_station;
	}
	public void setTerm_station(String term_station) {
		Term_station = term_station;
	}
	public String getPass_station() {
		return Pass_station;
	}
	public void setPass_station(String pass_station) {
		Pass_station = pass_station;
	}
	public String getTickets() {
		return Tickets;
	}
	public void setTickets(String tickets) {
		Tickets = tickets;
	}
	public String getWaittime() {
		return Waittime;
	}
	public void setWaittime(String waittime) {
		Waittime = waittime;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public trainManSer getTrainMser() {
		return trainMser;
	}
	public void setTrainMser(trainManSer trainMser) {
		this.trainMser = trainMser;
	}
	public stationManSer getStationMser() {
		return stationMser;
	}
	public void setStationMser(stationManSer stationMser) {
		this.stationMser = stationMser;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getTerm() {
		return term;
	}
	public void setTerm(String term) {
		this.term = term;
	}
	public int getDistance() {
		return distance;
	}
	public void setDistance(int distance) {
		this.distance = distance;
	}
	
	

	//HttpSession session = null;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}



	ActionContext ctx = ActionContext.getContext();
	
	
	public listservice getListser() {
		return listser;
	}
	public void setListser(listservice listser) {
		this.listser = listser;
	}
	public void setLoginser(loginservice loginser) {
		this.loginser = loginser;
	}
	/**
	 * 
	 * 
	 */
	public int getAccount() {
		return account;
	}
	public void setAccount(int account) {
		this.account = account;
	}
	public int getPassword() {
		return password;
	}
	public void setPassword(int password) {
		this.password = password;
	}

	public loginservice getLoginser() {
		return loginser;
	}
	/**
	 * ����ҵ���service
	 * 
	 */
	
	public String login() throws Exception{
		System.out.println("action执行了");
		Boolean flag=loginser.login(account, password);
        if(flag){
        	return "success";
        }else{
            return "fail";
        }
		//loginser.login();
		//return "success";
	}
	
	public String delete() throws Exception{
		System.out.println("action执行了");
		Boolean flag=loginser.delete(account);
        if(flag){
            return "success";
        }else{
            return "fail";
        }
		//loginser.login();
		//return "success";
	}
	
	
	public String stationMan() throws JSONException{
		//HttpServletRequest request = null;
		//start  = request.getParameter("start");
		//term   = request.getParameter("term");
		System.out.println(start+term+distance);     //վ�����action
		System.out.println("站点管理action执行了");
		stationMser.stationMan(start, term, distance);
		return "success";
	}
	
	public String trainMan() throws JSONException{
		System.out.println(Train_number+Train_type+Start_station+Term_station+Pass_station+Tickets+Waittime+start_time);
		Train t = new Train(20,Train_number,Train_type,Start_station,Term_station,Pass_station,Tickets,Waittime,start_time);
		trainMser.stationMan(t);
		return "success";
	}
	
	/**
	 * 删除车次的action
	 */
	private ArrayList<String> trainlist = new ArrayList();
	
	
	public ArrayList<String> getTrainlist() {
		return trainlist;
	}
	public void setTrainlist(ArrayList<String> trainlist) {
		this.trainlist = trainlist;
	}
	public String trainDel() {
		System.out.println(Train_number);
		boolean flag=trainMser.stationDelete(Train_number);
		if(flag){
        	return "success";
        }else{
            return "fail";
        }
	}
	/**
	 * 列出所有信息
	 */
	public String trainlist(){
		System.out.println("trainlist action执行了");
		
		//System.out.println(start+term);
		//result = findser.find(start,term);
		//result = findser.find(start,term);
		//result = findser.query(a);
		trainlist = trainMser.trainlist();
		
		System.out.println("trainlist action执行了");
		return "success";
	}
}
