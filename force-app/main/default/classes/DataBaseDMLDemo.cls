public class DataBaseDMLDemo {
    
    public DataBaseDMLDemo()
    {
        
    }
    public void createAccount()
    {
        List<Account> lsacc=new List<Account>{new Account(Name='Tesla'),new Account()};
            
        
        List<DataBase.SaveResult> results=DataBase.insert(lsacc,false);
        Map<Id,Account> mp=new Map<Id,Account>();
        for(Account accc:lsacc)
        {
            mp.put(accc.Id, accc);
        }
        for(DataBase.SaveResult sr:results)
        {
            if(sr.isSuccess())
            {
                System.debug('success'+sr.getId()); 
                System.debug(mp.get(sr.getId()));
            }
            else
            {
                for(DataBase.Error er:sr.getErrors())
                {
                    System.debug('failure'+er.getMessage());
                    System.debug(er.getStatusCode());
                    System.debug(er.getFields());
                    System.debug(er.fields);  
                }
            }
        }
    }
    
    public void createExceptionLogRecordOnFailure()
    {
        Account ac=new Account(Name='MGM');
        insert ac;
       
        List<Branch__c> lsacc=new List<Branch__c>{new Branch__c(Name='koti',Hospital__c=ac.id),new Branch__c(),new Branch__c()};
            
            List<DataBase.SaveResult> results=DataBase.insert(lsacc,false);
        List< ExceptionLog__c> ls=new List< ExceptionLog__c>();
        for(DataBase.SaveResult sr:results)
        {
            if(sr.isSuccess())
            {
                System.debug('success'+sr.getId()); 
               
            }
            else
            {
                for(DataBase.Error er:sr.getErrors())
                {
                    ExceptionLog__c ex=new ExceptionLog__c(Name='DataBaseDMLDemo',ErrorMessage__c=er.getMessage(),
                                                           MethodName__c='createExceptionLogRecordOnFailure',
                                                           StackTrace__c=er.message);
                    
                    insert ex;
                    System.debug('failure'+er.getMessage());
                    System.debug(er.getStatusCode());
                    System.debug(er.getFields());
                    System.debug(er.fields);
                    
                }
            }
        }
    }
    
    public void checkAutoResponseMail()
    {
        Account a = new Account(name='Acme Plumbing');
        
        insert a;
        
        Contact c = new Contact(email='deepika.polasani@gmail.com', firstname='Joe',lastname='Plumber', accountid=a.id);
        
        insert c;
        
        Database.DMLOptions dlo = new Database.DMLOptions();
        
        dlo.EmailHeader.triggerAutoResponseEmail = true;
        
        Case ca = new Case(subject='Plumbing Problems', contactid=c.id);
        
        database.insert(ca, dlo);
    }
    
    
}