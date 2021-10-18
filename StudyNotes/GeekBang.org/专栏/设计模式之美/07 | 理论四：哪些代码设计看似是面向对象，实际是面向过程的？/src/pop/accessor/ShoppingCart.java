package pop.accessor;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ShoppingCart {
    private int itemsCount;
    private double totalPrice;
    private List<ShoppingCartItem> items = new ArrayList<>();

    public static void main(String[] args) {
        ShoppingCart cart = new ShoppingCart();
        // ...
        cart.getItems().clear();

        cart.addItem(new ShoppingCartItem());
        List<ShoppingCartItem> items = cart.getItems();
        ShoppingCartItem item = items.get(0);
        item.setPrice(19.0); // 这里修改了item的价格属性
        items.clear(); //抛出UnsupportedOperationException异常
    }

    public int getItemsCount() {
        return this.itemsCount;
    }

    public void setItemsCount(int itemsCount) {
        this.itemsCount = itemsCount;
    }

    public double getTotalPrice() {
        return this.totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public List<ShoppingCartItem> getItems() {
        return Collections.unmodifiableList(this.items);
    }

    public void addItem(ShoppingCartItem item) {
        items.add(item);
        itemsCount++;
        totalPrice += item.getPrice();
    }

    public void clear() {
        items.clear();
        itemsCount = 0;
        totalPrice = 0.0;
    }
}
