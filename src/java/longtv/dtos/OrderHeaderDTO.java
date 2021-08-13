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
public class OrderHeaderDTO implements Serializable {
    private String orderID, username, paidAccountPaypal, amountPaypal, paymentID, voucherApplied, deliveryAddress;
    private int paymentType, status;
    private float totalPrice;

    public OrderHeaderDTO() {
    }

    public OrderHeaderDTO(String orderID, String username, int status, String paidAccountPaypal, String amountPaypal, String paymentID, int paymentType) {
        this.orderID = orderID;
        this.username = username;
        this.status = status;
        this.paidAccountPaypal = paidAccountPaypal;
        this.amountPaypal = amountPaypal;
        this.paymentID = paymentID;
        this.paymentType = paymentType;
    }
    
    public OrderHeaderDTO(String orderID, String username, int status, int paymentType) {
        this.orderID = orderID;
        this.username = username;
        this.status = status;
        this.paymentType = paymentType;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }    

    public String getVoucherApplied() {
        return voucherApplied;
    }

    public void setVoucherApplied(String voucherApplied) {
        this.voucherApplied = voucherApplied;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getAmountPaypal() {
        return amountPaypal;
    }

    public void setAmountPaypal(String amountPaypal) {
        this.amountPaypal = amountPaypal;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getPaidAccountPaypal() {
        return paidAccountPaypal;
    }

    public void setPaidAccountPaypal(String paidAccountPaypal) {
        this.paidAccountPaypal = paidAccountPaypal;
    }

    public int getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(int paymentType) {
        this.paymentType = paymentType;
    }

    public String getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(String paymentID) {
        this.paymentID = paymentID;
    }
    
    
}
