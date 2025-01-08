package se.grit;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Main {
    public static void main(String[] args) {

        // SHOW TABLES;

        try {
            Connection conn = Database.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet result = stmt.executeQuery("SHOW TABLES");

            while(result.next()) {
                System.out.println(result.getString("Tables_in_CRM"));
            }

        } catch (SQLException e) {
            Database.SQLExceptionPrint(e, true);
        }


    }
}