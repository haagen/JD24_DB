package se.grit;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Accounts {

    // Attributes that we will use to hold the field data
    protected int id = -1;
    protected String name = "";
    protected int noOfEmployees = -1;
    protected String status = "";

    // Blank constructor - will be used when creating a "brand" new Account
    public Accounts() { }

    // This is used when we know the Account id
    // the new object will be initialized with
    // the data from the database.
    public Accounts(int id) throws SQLException {
        String sql = "SELECT id, name, noOfEmployees, status FROM Accounts WHERE id = ?";
        PreparedStatement ps = Database.getConnection().prepareStatement(sql);
        ps.setInt(1, id);

        init(ps);
    }

    // This is used when we know the Account name
    public Accounts(String name) throws SQLException {
        String sql = "SELECT id, name, noOfEmployees, status FROM Accounts WHERE name = ?";
        PreparedStatement ps = Database.getConnection().prepareStatement(sql);
        ps.setString(1, name);

        init(ps);
    }

    // This method will execute the PreparedStatement and
    // populate the class attribtues (e.g. load the data from
    // the database).
    private void init(PreparedStatement ps) throws SQLException {
        ResultSet rs = ps.executeQuery();
        if(rs.next()) { // Load the next (first) record in the response
            this.id = rs.getInt("id");
            this.name = rs.getString("name");
            this.noOfEmployees = rs.getInt("noOfEmployees");
            this.status = rs.getString("status");
        }
    }

    // Save the object to the database
    public int save() throws SQLException {
        String sql = "name = ?, noOfEmployees = ?, status = ?";
        if(id>0) {  // We have an id we should update it
            sql = "UPDATE Accounts SET " + sql + " WHERE id = ?";
        } else {    // We don't have an id, we should insert the object
            sql = "INSERT INTO Accounts SET " + sql;
        }

        PreparedStatement ps = Database.getConnection().prepareStatement(
                sql,
                // We want to get the created ID after the insert command has finished
                // Saves us from doing a "SELECT LAST_INSERT_ID()"
                PreparedStatement.RETURN_GENERATED_KEYS
        );
        ps.setString(1, name);
        ps.setInt(2, noOfEmployees);
        ps.setString(3, status);
        if(id > 0) {    // Set the id if it is an UPDATE
            ps.setInt(4, id);
        }

        int numberOfChangedRows = ps.executeUpdate();

        if(id < 0){
            // Fetch the created id
            ResultSet rs = ps.getGeneratedKeys();
            if(rs.next()) {
                id = rs.getInt(1);
            }
        }

        return 0;
    }

    public int delete() throws SQLException {

        // Don't try to delete objects that hasn't been created first
        if(id<0){
            throw new SQLException("No Account loaded!");
        }

        String sql = "DELETE FROM Accounts WHERE id = ?";
        PreparedStatement ps = Database.getConnection().prepareStatement(sql);
        ps.setInt(1, id);
        int changedRows = ps.executeUpdate();
        if(changedRows > 0) {
            // Since the record now is delete from the database, we
            // shouldn't keep any references to the id of the record
            id = -1;
        }
        return changedRows;
    }

    public int getId() {
        return id;
    }

    /*

        Let's not allow the user to set the Id manually
        To set a specific id the constructor should be used instead.

    public void setId(int id) {
        this.id = id;
    }
     */

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getNoOfEmployees() {
        return noOfEmployees;
    }

    public void setNoOfEmployees(int noOfEmployees) {
        this.noOfEmployees = noOfEmployees;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
