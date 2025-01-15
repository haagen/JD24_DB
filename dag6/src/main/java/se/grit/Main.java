package se.grit;

import java.sql.SQLException;

public class Main {
    public static void main(String[] args) {

        /*
        String password = "password";
        String hashedPassword = Hashing.hash(password);
        System.out.println("Mitt klartext lösenord: " + password);
        System.out.println("Mitt hashade lösenord:" + hashedPassword);
        */

        /*
        String dbPassword = "23b0c4aafda7d27c1581c7e77be9a4f73bc95fd20644ba8f6ab4c5f1ffbe9f9d71b79b76510751ab993c60f72b5ca40a";

        if(Hashing.Verify("qwerty", dbPassword)) {
            System.out.println("Lösenordet stämde!");
        } else {
            System.out.println("Det var fel lösenord!");
        }
        */

        /*
            //Create a new Account
        Accounts a = new Accounts();
        a.setName("Oskars Surströmming AB");
        a.setNoOfEmployees(45);
        a.setStatus("Customer");
            //a.setId(6);   // We cannot use this method -- has been removed from the Accounts class.
        */

        try {
            //Accounts a = new Accounts(4);
            //Accounts a = new Accounts("Volvo Cars AB");
            //a.save();
            Accounts a = new Accounts(6);
            a.delete();
            System.out.println(a.getName() + " har id " + a.getId());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}