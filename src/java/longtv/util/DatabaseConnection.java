/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.util;

import java.io.Serializable;
import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 *
 * @author Admin
 */
public class DatabaseConnection implements Serializable {
    public static Connection makeConnection() throws Exception {
        Context context = new InitialContext();
        Context tomcatContext = (Context) context.lookup("java:/comp/env");
        DataSource ds = (DataSource) tomcatContext.lookup("bookStore");
        Connection conn = ds.getConnection();
        return conn;
    }
}
