//编写:刘继涛
package service;

import java.util.List;
import java.util.Scanner;
import java.util.ArrayList;
public class s {
	static String[] str= {"abdhklo","olkhgfe","efghklo","dhgfe","efghd","abdhkl","lkhdba","cfghi","nmjfca"};
	static ArrayList<String> soure=new ArrayList<String>();
	static char[] ch= {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o'};
	
    private static void dfs_rec(ArrayList<ArrayList<Integer>> adjLists, boolean[] visited, int v, int d,
            List<Integer> path) {
    	String strchar ="";
        visited[v] = true;
        path.add(v);
        if (v == d) {
            for (int i = 0; i < path.size(); i++) {
                strchar+=ch[path.get(i)];
            }
            soure.add(strchar);
            /*
            for(int j=0;j<9;j++) {
            	if((str[j].indexOf(strchar))!=-1) {
            		soure.add(str[j]);

            	}
            }*/
            strchar="";
        }
        else{
            for (int w : adjLists.get(v)) {
                if (!visited[w]) {
                    dfs_rec(adjLists, visited, w, d, path);
                }
            }
        }
        path.remove(path.size() - 1);
        visited[v] = false;
    }
    public static void dfs(ArrayList<ArrayList<Integer>> adjLists, int s, int d) {
        int n = adjLists.size();
        boolean[] visited = new boolean[n];

        List<Integer> path = new ArrayList<Integer>();
        int path_index = 0; 
        String str ="";
        dfs_rec(adjLists, visited, s, d, path);
    }
    public  ArrayList<String> find(String start,String term) {
        ArrayList<ArrayList<Integer>> adjLists = new ArrayList<ArrayList<Integer>>();
        String[] city={"北京","天津","石家庄","济南","西安","郑州","商丘","徐州","连云港","武汉","南京","上海","长沙","南昌","杭州"};
        //String[] city={"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o"};
        int a=0,b=0;
        System.out.print(start+"    "+term);
        for(int i=0;i<15;i++){
        	//System.out.print(1);
        	if(start.equals(city[i])){
        		a=i;
        		break;
        	}
        }
        for(int i=0;i<15;i++){
        	if(term.equals(city[i])){
        		b=i;
        		break;
        	}
        }
        System.out.println(a+"   "+b);
        final int n = 16;
        
        for (int v = 0; v < n; v++) {
            adjLists.add(new ArrayList<Integer>());
        }
        adjLists.get(0).add(1);
        adjLists.get(0).add(2);
        adjLists.get(0).add(6);
        // a---------
        adjLists.get(1).add(0);
        adjLists.get(1).add(3);
        // b---------
        adjLists.get(2).add(0);
        adjLists.get(2).add(5);
        // c---------
        adjLists.get(3).add(1);
        adjLists.get(3).add(7);
        // d---------
        adjLists.get(4).add(5);
        // e---------
        adjLists.get(5).add(2);
        adjLists.get(5).add(4);
        adjLists.get(5).add(6);
        adjLists.get(5).add(9);
        // f---------
        adjLists.get(6).add(0);
        adjLists.get(6).add(7);
        adjLists.get(6).add(13);
        adjLists.get(6).add(5);
        // g---------  
        adjLists.get(7).add(3);
        adjLists.get(7).add(6);
        adjLists.get(7).add(8);
        adjLists.get(7).add(10);
        // h--------- 
        adjLists.get(8).add(7);
        // i--------- 
        adjLists.get(9).add(5);
        adjLists.get(9).add(12);
        // j--------- 
        adjLists.get(10).add(7);
        adjLists.get(10).add(11);
        // k--------- 
        adjLists.get(11).add(14);
        adjLists.get(11).add(10);
        // l--------- 
        adjLists.get(12).add(13);
        adjLists.get(12).add(9);
        // m--------- 
        adjLists.get(13).add(6);
        adjLists.get(13).add(14);
        adjLists.get(13).add(12);
        // n--------- 
        adjLists.get(14).add(11);
        adjLists.get(14).add(13);
        // o--------- 
        dfs(adjLists, a, b);
        return soure;
    }
}
