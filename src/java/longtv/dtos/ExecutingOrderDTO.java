/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.dtos;

/**
 *
 * @author Admin
 */
public class ExecutingOrderDTO {
    private int statusChangeFrom, statusChangeToID, type;
    private String statusChangeTo, description, dateOfCreate; 
    

    public ExecutingOrderDTO() {
    }

    public ExecutingOrderDTO(int statusChangeFrom, String statusChangeTo, String description, String dateOfCreate, int type) {
        this.statusChangeFrom = statusChangeFrom;
        this.statusChangeTo = statusChangeTo;
        this.description = description;
        this.dateOfCreate = dateOfCreate;
        this.type = type;
    }

    public int getStatusChangeToID() {
        return statusChangeToID;
    }

    public void setStatusChangeToID(int statusChangeToID) {
        this.statusChangeToID = statusChangeToID;
    }
    
    

    public int getStatusChangeFrom() {
        return statusChangeFrom;
    }

    public void setStatusChangeFrom(int statusChangeFrom) {
        this.statusChangeFrom = statusChangeFrom;
    }

    public String getStatusChangeTo() {
        return statusChangeTo;
    }

    public void setStatusChangeTo(String statusChangeTo) {
        this.statusChangeTo = statusChangeTo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDateOfCreate() {
        return dateOfCreate;
    }

    public void setDateOfCreate(String dateOfCreate) {
        this.dateOfCreate = dateOfCreate;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    
    
    
}
