//编写：刘继涛      修改：刘琦
package action;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import service.findpathService;
import service.loginservice;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

public class findpathaction extends HttpServlet {
	
	private static final long serialVersionUID = 1L; 
	HttpServletRequest request=null;
	private String start;
	private String term;
	ArrayList<String> result;
	private ArrayList<String> allresult ;
	public ArrayList<String> getAllresult() {
		return allresult;
	}
	public void setAllresult(ArrayList<String> allresult) {
		this.allresult = allresult;
	}
	public ArrayList<String> getResult() {
		return result;
	}
	public void setResult(ArrayList<String> result) {
		this.result = result;
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

	private findpathService findser;
	public findpathService getFindser() {
		return findser;
	}
	public void setFindser(findpathService findser) {
		this.findser = findser;
	}
	
	
	public String findpath() throws JSONException, UnsupportedEncodingException{
		//HttpServletRequest request = null;
		//start  = request.getParameter("start");
		//term   = request.getParameter("term");
		System.out.println(start+term);
		result = findser.find(start,term);  //得到图中两点间的所有路径
		//System.out.println(result);
		//result = findser.find(start,term);
		//result = findser.query(a);
		allresult = findser.query(result);  
		
		System.out.println("action执行了");
		return "success";
	}
	

}
