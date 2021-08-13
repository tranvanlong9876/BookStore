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
public class VoucherDTO implements Serializable {
    private String discountCode, discountDesc, expiredDate;
    private String discountPercent;

    public VoucherDTO() {
    }

    public VoucherDTO(String discountCode, String discountDesc, String discountPercent) {
        this.discountCode = discountCode;
        this.discountDesc = discountDesc;
        this.discountPercent = discountPercent;
    }

    public VoucherDTO(String discountCode, String discountDesc, String expiredDate, String discountPercent) {
        this.discountCode = discountCode;
        this.discountDesc = discountDesc;
        this.expiredDate = expiredDate;
        this.discountPercent = discountPercent;
    }

    public String getDiscountCode() {
        return discountCode;
    }

    public void setDiscountCode(String discountCode) {
        this.discountCode = discountCode;
    }

    public String getDiscountDesc() {
        return discountDesc;
    }

    public void setDiscountDesc(String discountDesc) {
        this.discountDesc = discountDesc;
    }

    public String getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(String expiredDate) {
        this.expiredDate = expiredDate;
    }

    public String getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(String discountPercent) {
        this.discountPercent = discountPercent;
    }
    
    
}
