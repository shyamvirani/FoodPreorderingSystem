package fps;
import java.sql.*;

public class DataRetrival {

	public static Order retival(Connection con,ResultSet rs) {
		Order o = null;
		try {		
		o=new Order();
		
			o.orderId = rs.getInt("pkorder_id");
			o.userId = rs.getInt("fkuser_id");
			o.canteenId = rs.getInt("fkcanteen_id");
			o.totalItem = rs.getInt("total_item");
			o.dateTime = rs.getString("dateTime");
			o.deliveryTime = rs.getString("delivery_time");
			o.refMenu = csvToArray(rs.getString("ref_menu"));
			o.status = rs.getString("status");
			o.quantity = csvToArray(rs.getString("quantity"));
			o.price = csvToArray(rs.getString("price"));
			o.paymentType = rs.getString("payment_type");
			o.totalPrice = rs.getInt("total_price");
			o.remark = rs.getString("remark");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return o;
	}

	public static int [] csvToArray(String str){
		String str2 [] = str.split(",");
		int arr[] = new int [str2.length];
		for(int i=0;i<str2.length;i++){
			arr[i] = Integer.parseInt(str2[i]);
		}
		return arr;	
	}
	
	public static String arrayToCsv(int arr[]){
		String str = "";
		for(int i=0;i<arr.length;i++){
			str = str + arr[i] +",";
		}
		return str;
	}

}