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
public class SearchBookDTO implements Serializable {
    private String image, title, author, category;
    private int bookID, quantity;
    private String price;
    private String description;
    private int categoryID;

    public SearchBookDTO() {
    }

    public SearchBookDTO(String image, String title, String author, String category, int bookID, int quantity, String price) {
        this.image = image;
        this.title = title;
        this.author = author;
        this.category = category;
        this.bookID = bookID;
        this.quantity = quantity;
        this.price = price;
    }

    public SearchBookDTO(String image, String title, String author, int bookID, int quantity, String price, String description, int categoryID) {
        this.image = image;
        this.title = title;
        this.author = author;
        this.bookID = bookID;
        this.quantity = quantity;
        this.price = price;
        this.description = description;
        this.categoryID = categoryID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }
    
    

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
}
