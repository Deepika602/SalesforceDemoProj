public class ExceptionDML {
    
    public void createExceptionRecord()
    {
        try
        {
            Account ac=[SELECT Id,Name FROM Account];
        }
        catch(Exception e)
        {
            ExceptionLog__c ex=new ExceptionLog__c(Name='ExceptionDML',ErrorMessage__c='more than one record',
                                                  MethodName__c='createExceptionRecord',StackTrace__c='line 6');
            insert ex;
        }
    }

}