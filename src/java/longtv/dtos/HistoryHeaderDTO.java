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
public class HistoryHeaderDTO implements Serializable {
    private String orderID, fullName, username, totalPrice, discountCode, statusName, paymentName, orderTime;
    private String paymentPaypalID, paypalAccount, payAmountDollar, deliveryAddress;

    public HistoryHeaderDTO() {
    }

    
    public HistoryHeaderDTO(String orderID, String fullName, String totalPrice, String discountCode, String statusName, String paymentName, String orderTime) {
        this.orderID = orderID;
        this.fullName = fullName;
        this.totalPrice = totalPrice;
        this.discountCode = discountCode;
        this.statusName = statusName;
        this.paymentName = paymentName;
        this.orderTime = orderTime;
    }

    public HistoryHeaderDTO(String orderID, String fullName, String username, String totalPrice, String discountCode, String statusName, String paymentName, String orderTime) {
        this.orderID = orderID;
        this.fullName = fullName;
        this.username = username;
        this.totalPrice = totalPrice;
        this.discountCode = discountCode;
        this.statusName = statusName;
        this.paymentName = paymentName;
        this.orderTime = orderTime;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }
    
    

    public String getPaymentPaypalID() {
        return paymentPaypalID;
    }

    public void setPaymentPaypalID(String paymentPaypalID) {
        this.paymentPaypalID = paymentPaypalID;
    }

    public String getPaypalAccount() {
        return paypalAccount;
    }

    public void setPaypalAccount(String paypalAccount) {
        this.paypalAccount = paypalAccount;
    }

    public String getPayAmountDollar() {
        return payAmountDollar;
    }

    public void setPayAmountDollar(String payAmountDollar) {
        this.payAmountDollar = payAmountDollar;
    }
    
    

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(String totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getDiscountCode() {
        return discountCode;
    }

    public void setDiscountCode(String discountCode) {
        this.discountCode = discountCode;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getPaymentName() {
        return paymentName;
    }

    public void setPaymentName(String paymentName) {
        this.paymentName = paymentName;
    }

    public String getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }
    
    
    
}
