

public class StaInfo implements java.io.Serializable{
	
		/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
		public static int id;//Õ¾ºÅÂë
		public static String name;
		public static String phone;
		public static String address;
		public static float x;
		public static float y;
	
	//StaInfo info = new StaInfo();
	
	public void setname(String name){
		this.name = name;
	}
	public String getname(){
		return name;
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public float getX() {
		return x;
	}

	public void setX(float x) {
		this.x = x;
	}

	public float getY() {
		return y;
	}

	public void setY(float y) {
		this.y = y;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		

	}

}
