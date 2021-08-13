/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.util;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class ConvertInput implements Serializable {
    public static String[] convertToFructualPrice(int frucID) throws Exception {
        String[] frucPrice = new String[2];
        switch(frucID) {
            case 1: 
                frucPrice[0] = "1";
                frucPrice[1] = "100000";
                return frucPrice;
            case 2: 
                frucPrice[0] = "100001";
                frucPrice[1] = "300000";
                return frucPrice;
            case 3: 
                frucPrice[0] = "300001";
                frucPrice[1] = "1000000";
                return frucPrice;
            case 4: 
                frucPrice[0] = "1000001";
                frucPrice[1] = "3000000";
                return frucPrice;
            case 5:
                frucPrice[0] = "3000001";
                frucPrice[1] = "2100000000000";
                return frucPrice;
            default:
                frucPrice[0] = "1";
                frucPrice[1] = "2100000000000";
                return frucPrice;
        }
    }
    
    public static Timestamp convertInputDateTime(String expireDate) throws Exception {
        String[] splitDateAndTime = expireDate.split("T");
        String validDateTime = splitDateAndTime[0] + " " + splitDateAndTime[1];
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date date = sdf.parse(validDateTime);
        Timestamp time = new Timestamp(date.getTime());
        return time;
    }
}
