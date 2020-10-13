public class RollBackSavePointDemo 
{
    
    public void createSavePoint()
    {
        Account a = new Account(Name = 'xxx');
        insert a;
        
        System.assertEquals(null, [SELECT AccountNumber FROM Account WHERE Id = :a.Id].
                            AccountNumber);
        
        // Create a savepoint while AccountNumber is null
        Savepoint sp = Database.setSavepoint();
        
        // Change the account number
        a.AccountNumber = '123';
        update a;
        System.assertEquals('123', [SELECT AccountNumber FROM Account WHERE Id = :a.Id].
                            AccountNumber);
        
        // Rollback to the previous null value
        Database.rollback(sp);
        System.assertEquals(null, [SELECT AccountNumber FROM Account WHERE Id = :a.Id].
                            AccountNumber);     
    }
    
}