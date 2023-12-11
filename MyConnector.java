import java.sql.*;

/**
     *
     * @author 1BestCsharp
     */public class MyConnector {


        // create a function to connect with mysql database

        public static Connection getConnection(){

            Connection con = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost/java_login_register", "root", "");
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }

            return con;
        }

    }

