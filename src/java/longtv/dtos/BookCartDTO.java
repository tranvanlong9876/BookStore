/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.dtos;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Admin
 */
public class BookCartDTO {

    private Map<Integer, BookCartListDTO> bookLists;
    private float totalPriceOfCart;
    private String totalPriceOfCartWithVietnameseCurrency;
    private VoucherDTO voucher;
    private float totalPriceOfCartCheckOut;
    private String totalPriceOfCartCheckOutWithVietnameseCurrency;
    private String discountPriceString;
    private String homeNumber;
    private String deliveryAddress;
    private boolean isVerifyOTP;

    public boolean isIsVerifyOTP() {
        return isVerifyOTP;
    }

    public void setIsVerifyOTP(boolean isVerifyOTP) {
        this.isVerifyOTP = isVerifyOTP;
    }

    public String getHomeNumber() {
        return homeNumber;
    }

    public void setHomeNumber(String homeNumber) {
        this.homeNumber = homeNumber;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public float getTotalPriceOfCartCheckOut() {
        return totalPriceOfCartCheckOut;
    }

    public void setTotalPriceOfCartCheckOut(float totalPriceOfCartCheckOut) {
        this.totalPriceOfCartCheckOut = totalPriceOfCartCheckOut;
    }

    public String getTotalPriceOfCartCheckOutWithVietnameseCurrency() {
        return totalPriceOfCartCheckOutWithVietnameseCurrency;
    }

    public void setTotalPriceOfCartCheckOutWithVietnameseCurrency(String totalPriceOfCartCheckOutWithVietnameseCurrency) {
        this.totalPriceOfCartCheckOutWithVietnameseCurrency = totalPriceOfCartCheckOutWithVietnameseCurrency;
    }

    public String getDiscountPriceString() {
        return discountPriceString;
    }

    public void setDiscountPriceString(String discountPriceString) {
        this.discountPriceString = discountPriceString;
    }

    public VoucherDTO getVoucher() {
        return voucher;
    }

    public void setVoucher(VoucherDTO voucher) {
        this.voucher = voucher;
    }

    public BookCartDTO() {
        bookLists = new HashMap<>();
    }

    public Map<Integer, BookCartListDTO> getBookLists() {
        return bookLists;
    }

    public void setBookLists(Map<Integer, BookCartListDTO> bookLists) {
        this.bookLists = bookLists;
    }

    public float getTotalPriceOfCart() {
        return totalPriceOfCart;
    }

    public void setTotalPriceOfCart(float totalPriceOfCart) {
        this.totalPriceOfCart = totalPriceOfCart;
    }

    public String getTotalPriceOfCartWithVietnameseCurrency() {
        return totalPriceOfCartWithVietnameseCurrency;
    }

    public void setTotalPriceOfCartWithVietnameseCurrency(String totalPriceOfCartWithVietnameseCurrency) {
        this.totalPriceOfCartWithVietnameseCurrency = totalPriceOfCartWithVietnameseCurrency;
    }

    public void countTotalPriceOfCart() { //Subtotal
        float sum = 0;
        for (int i : this.bookLists.keySet()) {
            sum += (bookLists.get(i).getBookPrice() * bookLists.get(i).getBookQuantity());
        }
        this.totalPriceOfCart = sum;
    }
    
    public float getDiscountPrice() {
        float discountPrice = 0;
        if(voucher != null) {
            discountPrice = totalPriceOfCart * Integer.parseInt(voucher.getDiscountPercent()) / 100;
        }
        return discountPrice;
    }

    public void countTotalPriceCheckOut() {
        if (voucher != null) {
            totalPriceOfCartCheckOut = totalPriceOfCart - (totalPriceOfCart * Integer.parseInt(voucher.getDiscountPercent()) / 100);
        } else {
            totalPriceOfCartCheckOut = totalPriceOfCart;
        }
    }
    public void addBookToCart(BookCartListDTO dto) {
        bookLists.put(dto.getBookID(), dto);
        bookLists.get(dto.getBookID()).setEnoughQuantity(true);
    }

    public void removeBookFromCart(int bookID) {
        bookLists.remove(bookID);
    }

    public void updateBookInCart(int bookID, int newQuantity) {
        bookLists.get(bookID).setBookQuantity(newQuantity);
    }

}
