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
public class AccountDTO implements Serializable{
    private String username, fullname, rolename;

    public AccountDTO() {
    }

    public AccountDTO(String username, String fullname, String rolename) {
        this.username = username;
        this.fullname = fullname;
        this.rolename = rolename;
    }
    
    

    public String getUser() {
        return username;
    }

    public void setUser(String username) {
        this.username = username;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }
    
    
}
