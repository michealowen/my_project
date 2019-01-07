package Test;

import java.util.ArrayList;

import service.s;

public class findAll {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		s s1= new s();
		ArrayList<String> consequence = new ArrayList<String>();
		consequence = s1.find("北京", "南京");
	    System.out.println(consequence);
        /*
		String q1="����",q2="�Ͼ�";
        if(q1.equals(q2))
        	System.out.println("1");
        else
        	System.out.println("0");
		*/
	}

}
