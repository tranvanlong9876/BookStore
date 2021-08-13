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
public class InvalidVoucherDTO implements Serializable {
    private String invalidDiscountCode, invalidDiscountDesc, invalidExpiredDate;
    private String invalidDiscountPercent;
    private boolean isValidVoucher;

    public InvalidVoucherDTO() {
    }

    public boolean isIsValidVoucher() {
        return isValidVoucher;
    }

    public void setIsValidVoucher(boolean isValidVoucher) {
        this.isValidVoucher = isValidVoucher;
    }
    
    public String getInvalidDiscountCode() {
        return invalidDiscountCode;
    }

    public void setInvalidDiscountCode(String invalidDiscountCode) {
        this.invalidDiscountCode = invalidDiscountCode;
    }

    public String getInvalidDiscountDesc() {
        return invalidDiscountDesc;
    }

    public void setInvalidDiscountDesc(String invalidDiscountDesc) {
        this.invalidDiscountDesc = invalidDiscountDesc;
    }

    public String getInvalidExpiredDate() {
        return invalidExpiredDate;
    }

    public void setInvalidExpiredDate(String invalidExpiredDate) {
        this.invalidExpiredDate = invalidExpiredDate;
    }

    public String getInvalidDiscountPercent() {
        return invalidDiscountPercent;
    }

    public void setInvalidDiscountPercent(String invalidDiscountPercent) {
        this.invalidDiscountPercent = invalidDiscountPercent;
    }
    
    
    
}
