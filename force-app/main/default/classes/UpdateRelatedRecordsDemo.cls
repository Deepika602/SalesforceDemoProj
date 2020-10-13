public class UpdateRelatedRecordsDemo {
    
    public void updateRecords()
    {
        Contact con=[SELECT Account.Industry,Name FROM Contact where Name='Joe Plumber'];	
        con.Email='d@gmail.com';
        con.Account.Industry='Banking';
        update con;
        update con.Account;

                                 
        
    }

}