/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtv.util;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 *
 * @author Admin
 */
public class DatabaseConnection implements Serializable {
    public static Connection makeConnection() throws Exception {
        Connection conn = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection("jdbc:sqlserver://bookstore1410.database.windows.net:1433;database=BookStoreManagement;user=tranvanlong9876@bookstore1410;password=123456Long;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
//        Context context = new InitialContext();
//        Context tomcatContext = (Context) context.lookup("java:/comp/env");
//        DataSource ds = (DataSource) tomcatContext.lookup("bookStore");
//        Connection conn = ds.getConnection();
        return conn;
    }
}
