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
public class ErrorServletDTO implements Serializable {
    private String errorServlet, errorDetail;

    public ErrorServletDTO() {
    }

    public ErrorServletDTO(String errorServlet, String errorDetail) {
        this.errorServlet = errorServlet;
        this.errorDetail = errorDetail;
    }

    public String getErrorServlet() {
        return errorServlet;
    }

    public void setErrorServlet(String errorServlet) {
        this.errorServlet = errorServlet;
    }

    public String getErrorDetail() {
        return errorDetail;
    }

    public void setErrorDetail(String errorDetail) {
        this.errorDetail = errorDetail;
    }
    
    
}
