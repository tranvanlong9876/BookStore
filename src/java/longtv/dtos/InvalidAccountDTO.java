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
public class InvalidAccountDTO implements Serializable {
    private String invalidUsername, invalidPassword, invalidConfirmPassword, invalidFullname, wrongOTP, invalidEmail, invalidPhone, invalidHomeNo, invalidDistrict, invalidOldPassword;
    private boolean validateStatus;
    private int responseCode;

    public InvalidAccountDTO() {
    }

    public InvalidAccountDTO(String invalidUsername, String invalidPassword, String invalidConfirmPassword, String invalidFullname, String wrongOTP, String invalidEmail) {
        this.invalidUsername = invalidUsername;
        this.invalidPassword = invalidPassword;
        this.invalidConfirmPassword = invalidConfirmPassword;
        this.invalidFullname = invalidFullname;
        this.wrongOTP = wrongOTP;
        this.invalidEmail = invalidEmail;
    }

    public String getInvalidHomeNo() {
        return invalidHomeNo;
    }

    public void setInvalidHomeNo(String invalidHomeNo) {
        this.invalidHomeNo = invalidHomeNo;
    }

    public String getInvalidDistrict() {
        return invalidDistrict;
    }

    public void setInvalidDistrict(String invalidDistrict) {
        this.invalidDistrict = invalidDistrict;
    }

    public String getInvalidOldPassword() {
        return invalidOldPassword;
    }

    public void setInvalidOldPassword(String invalidOldPassword) {
        this.invalidOldPassword = invalidOldPassword;
    }

    public int getResponseCode() {
        return responseCode;
    }

    public void setResponseCode(int responseCode) {
        this.responseCode = responseCode;
    }
    

    public String getInvalidPhone() {
        return invalidPhone;
    }

    public void setInvalidPhone(String invalidPhone) {
        this.invalidPhone = invalidPhone;
    }
    
    

    public boolean isValidateStatus() {
        return validateStatus;
    }

    public void setValidateStatus(boolean validateStatus) {
        this.validateStatus = validateStatus;
    }

    public String getInvalidUsername() {
        return invalidUsername;
    }

    public void setInvalidUsername(String invalidUsername) {
        this.invalidUsername = invalidUsername;
    }

    public String getInvalidPassword() {
        return invalidPassword;
    }

    public void setInvalidPassword(String invalidPassword) {
        this.invalidPassword = invalidPassword;
    }

    public String getInvalidConfirmPassword() {
        return invalidConfirmPassword;
    }

    public void setInvalidConfirmPassword(String invalidConfirmPassword) {
        this.invalidConfirmPassword = invalidConfirmPassword;
    }

    public String getInvalidFullname() {
        return invalidFullname;
    }

    public void setInvalidFullname(String invalidFullname) {
        this.invalidFullname = invalidFullname;
    }

    public String getWrongOTP() {
        return wrongOTP;
    }

    public void setWrongOTP(String wrongOTP) {
        this.wrongOTP = wrongOTP;
    }

    public String getInvalidEmail() {
        return invalidEmail;
    }

    public void setInvalidEmail(String invalidEmail) {
        this.invalidEmail = invalidEmail;
    }

    @Override
    public String toString() {
        return "InvalidAccountDTO{" + "invalidUsername=" + invalidUsername + ", invalidPassword=" + invalidPassword + ", invalidConfirmPassword=" + invalidConfirmPassword + ", invalidFullname=" + invalidFullname + ", wrongOTP=" + wrongOTP + ", invalidEmail=" + invalidEmail + ", invalidPhone=" + invalidPhone + ", validateStatus=" + validateStatus + '}';
    }
    
}
