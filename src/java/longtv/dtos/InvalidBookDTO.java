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
public class InvalidBookDTO implements Serializable {
    private String invalidImage, invalidTitle, invalidDescription, invalidAuthor, invalidPrice, invalidQuantity;
    private boolean isValidBook;
    private String invalidNewCategory;

    public InvalidBookDTO() {
    }
    
    

    public boolean isIsValidBook() {
        return isValidBook;
    }

    public String getInvalidNewCategory() {
        return invalidNewCategory;
    }

    public void setInvalidNewCategory(String invalidNewCategory) {
        this.invalidNewCategory = invalidNewCategory;
    }

    public void setIsValidBook(boolean isValidBook) {
        this.isValidBook = isValidBook;
    }

    public String getInvalidImage() {
        return invalidImage;
    }

    public void setInvalidImage(String invalidImage) {
        this.invalidImage = invalidImage;
    }

    public String getInvalidTitle() {
        return invalidTitle;
    }

    public void setInvalidTitle(String invalidTitle) {
        this.invalidTitle = invalidTitle;
    }

    public String getInvalidDescription() {
        return invalidDescription;
    }

    public void setInvalidDescription(String invalidDescription) {
        this.invalidDescription = invalidDescription;
    }

    public String getInvalidAuthor() {
        return invalidAuthor;
    }

    public void setInvalidAuthor(String invalidAuthor) {
        this.invalidAuthor = invalidAuthor;
    }

    public String getInvalidPrice() {
        return invalidPrice;
    }

    public void setInvalidPrice(String invalidPrice) {
        this.invalidPrice = invalidPrice;
    }

    public String getInvalidQuantity() {
        return invalidQuantity;
    }

    public void setInvalidQuantity(String invalidQuantity) {
        this.invalidQuantity = invalidQuantity;
    }
    
    
    
}
