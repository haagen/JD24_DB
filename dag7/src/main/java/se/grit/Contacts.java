package se.grit;

import jakarta.persistence.*;

@Entity
@Table(name = "Contacts")
public class Contacts {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "email")
    private String email;

    @Column(name = "accountsId")
    private int accountsId;

    public Contacts() {}

    public Contacts(String name, String email, int accountsId) {
        this.name = name;
        this.email = email;
        this.accountsId = accountsId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getAccountsId() {
        return accountsId;
    }

    public void setAccountsId(int accountsId) {
        this.accountsId = accountsId;
    }

    @Override
    public String toString() {
        return "Contacts (" +
                "id: " + id +
                "name: " + name +
                "email: " + email +
                "accountsId: " + accountsId +
                ")";
    }

}





