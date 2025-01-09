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

            String sql = "INSERT INTO Contacts (";
            sql += "name, email, accountsId";
            sql += ") VALUES (";
            sql += "'Sture Svensson',";
            sql += "'sture.svensson@gritacademy.se',";
            sql +="1";
            sql += ")";

            System.out.println(sql);
            int changedRows = stmt.executeUpdate(sql);
            System.out.println("Vi ändrade " + changedRows + " rader i databasen");

            // Du kan hämta det ID som skapades för kontakten med
            // hjälp av getGeneratedKeyes() på Statement objektet.
            // ResultSet keys = stmt.getGeneratedKeys();

        } catch (SQLException e) {
            Database.SQLExceptionPrint(e, true);
        }


    }
}