/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.dtos;

import java.io.Serializable;

/**
 *
 * @author Admin
 */
public class BookCartListDTO implements Serializable {
    private String bookName, bookImage, bookAuthor;
    private int bookID, bookQuantity;
    private float bookPrice;
    private String priceCastToVietnameseCurrency, totalPriceCastToVietNameseCurrency;
    private boolean enoughQuantity;
    private int maxQuantity;
    private boolean minusQuantity;

    public BookCartListDTO() {
    }

    public BookCartListDTO(String bookName, String bookImage, String bookAuthor, int bookQuantity, String priceCastToVietnameseCurrency, String totalPriceCastToVietNameseCurrency) {
        this.bookName = bookName;
        this.bookImage = bookImage;
        this.bookAuthor = bookAuthor;
        this.bookQuantity = bookQuantity;
        this.priceCastToVietnameseCurrency = priceCastToVietnameseCurrency;
        this.totalPriceCastToVietNameseCurrency = totalPriceCastToVietNameseCurrency;
    }

    public BookCartListDTO(String bookName, String bookImage, String bookAuthor, int bookID, float bookPrice) {
        this.bookName = bookName;
        this.bookImage = bookImage;
        this.bookAuthor = bookAuthor;
        this.bookID = bookID;
        this.bookPrice = bookPrice;
    }

    public boolean isMinusQuantity() {
        return minusQuantity;
    }

    public void setMinusQuantity(boolean minusQuantity) {
        this.minusQuantity = minusQuantity;
    }
    
    

    public boolean isEnoughQuantity() {
        return enoughQuantity;
    }

    public void setEnoughQuantity(boolean enoughQuantity) {
        this.enoughQuantity = enoughQuantity;
    }

    public int getMaxQuantity() {
        return maxQuantity;
    }

    public void setMaxQuantity(int maxQuantity) {
        this.maxQuantity = maxQuantity;
    }

    public String getPriceCastToVietnameseCurrency() {
        return priceCastToVietnameseCurrency;
    }

    public void setPriceCastToVietnameseCurrency(String priceCastToVietnameseCurrency) {
        this.priceCastToVietnameseCurrency = priceCastToVietnameseCurrency;
    }

    public String getTotalPriceCastToVietNameseCurrency() {
        return totalPriceCastToVietNameseCurrency;
    }

    public void setTotalPriceCastToVietNameseCurrency(String totalPriceCastToVietNameseCurrency) {
        this.totalPriceCastToVietNameseCurrency = totalPriceCastToVietNameseCurrency;
    }

    

    public String getBookImage() {
        return bookImage;
    }

    public void setBookImage(String bookImage) {
        this.bookImage = bookImage;
    }

    public String getBookAuthor() {
        return bookAuthor;
    }

    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public int getBookQuantity() {
        return bookQuantity;
    }

    public void setBookQuantity(int bookQuantity) {
        this.bookQuantity = bookQuantity;
    }

    public float getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(float bookPrice) {
        this.bookPrice = bookPrice;
    }

    @Override
    public String toString() {
        return "BookCartListDTO{" + "bookName=" + bookName + ", bookImage=" + bookImage + ", bookAuthor=" + bookAuthor + ", bookID=" + bookID + ", bookQuantity=" + bookQuantity + ", bookPrice=" + bookPrice + ", priceCastToVietnameseCurrency=" + priceCastToVietnameseCurrency + ", totalPriceCastToVietNameseCurrency=" + totalPriceCastToVietNameseCurrency + ", enoughQuantity=" + enoughQuantity + ", maxQuantity=" + maxQuantity + ", minusQuantity=" + minusQuantity + '}';
    }

    
    
}
