package fps;

public class Order {
	public int orderId,userId,canteenId,totalItem,totalPrice;
	public int quantity[],refMenu[],price[];
	public String dateTime,deliveryTime,status,paymentType,remark;
	public Order() {}
	public Order(int orderId, int userId, int canteenId, int totalItem, int totalPrice, int[] quantity, int[] refMenu,
			int[] price, String dateTime, String deliveryTime, String status, String paymentType ,String remark) {
		super();
		this.orderId = orderId;
		this.userId = userId;
		this.canteenId = canteenId;
		this.totalItem = totalItem;
		this.totalPrice = totalPrice;
		this.quantity = quantity;
		this.refMenu = refMenu;
		this.price = price;
		this.dateTime = dateTime;
		this.deliveryTime = deliveryTime;
		this.status = status;
		this.paymentType = paymentType;
		this.remark = remark;
	}
	
	
}
