package Test;

public class test {
	public static void main(String args[]){
		//计算等待时间
		String a="0102030405";
		int waittime=0;
		String s="abdhklo";
		System.out.println(s.substring(s.length()-1));
		int index1=s.indexOf('a');
		int index2=s.indexOf('k');
		System.out.println(index1+" "+index2);
		for(int i=1;i<(index2-index1);i++){
			waittime+=Integer.parseInt(a.substring(2*i-2, 2*i));
		}
		System.out.println(waittime);
	}

}
