public class DMLDemo {
    
    public DMLDemo()
    {
        
    }
    
    public void createRecord()
    {
        Account acc=new Account();
        acc.Name='BOF';
        acc.Account_Currency__c=5000;
        acc.AccountNumber='123456';
        acc.Industry='Banking';
        
        insert acc;
    }
    
    public void createRecordList()
    {
        List<Account> accLst=new List<Account>();
        Account acc=new Account();
        
        acc.Name='Paloalto';
        acc.Account_Currency__c=9000;
        acc.AccountNumber='121212';
        acc.Industry='Health';
        accLst.add(acc);
     
         Account acc1=new Account();
        acc1.Name='kaiser';
        acc1.Account_Currency__c=10000;
        acc1.AccountNumber='111111';
        acc1.Industry='Health';
        accLst.add(acc1);
        
        insert accLst;  
         List<Contact> conLst=new List<Contact>();
        for(Account acc2:accLst)
        {
            Contact con=new Contact();
            con.LastName='test';
            con.AccountId=acc2.Id;
            conLst.add(con);
        }
        if(conLst!=null && !conLst.isEmpty() )
        {
        insert conLst;
        }
    }
    
    public void createMultipleRecords()
    {
        List<Account> accLst=new List<Account>();
        for(Integer i=1;i<=3;i++)
        {
        Account acc=new Account();
        acc.Name='gilead';
        acc.Account_Currency__c=3000;
        acc.AccountNumber='222222';
        acc.Industry='Health';
        accLst.add(acc);
        }
        
        insert accLst; 
    }
    
    public void updateRecord()
    {
        List<Account> accLst=[SELECT Id,Name,AccountNumber From Account];
        List<Account> updateLst=new List<Account>();
        for(Account acc:accLst)
        {
            if(acc.AccountNumber=='222222')
            {
                 acc.Account_Currency__c=5000;   
            }
            updateLst.add(acc);
        }
        if(updateLst!=null && !updateLst.isEmpty())
        {
        update updateLst;
        }
    }
    
    public void updateRecordWithoutQuery(Set<Id> stid)
    {
        List<Account> ls=new List<Account>();
        for(Id accid:stid)
        {
            Account acc=new Account(id=accid);
            acc.Type='warm';
            ls.add(acc);
        }
        
        update ls;
    }
    
     public void deleteAccount(set<Id> setAccIds){
        List<Account> accList = new List<Account>();
        for(Id accId:setAccIds){
            Account acc = new Account(id=accId);
            accList.add(acc);
        }  
        
        delete accList;
    }
    
    public void upsertAccount()
    {
        List<Account> accls=new List<Account>();
        
        Account ac1=new Account();
        ac1.Name='maxicare';
        ac1.AccountNumber='3333333';
        ac1.AnnualRevenue=6000;
        accls.add(ac1);
        
        Account ac2=[SELECT Id,Name FROM Account where id='0013t00001Zpn7z'];
        ac2.Name=ac2.Name+' 3';
        ac2.AnnualRevenue=8000;
        accls.add(ac2);
        
        upsert accls;
        
    }
    
    public void upsertAccountWithExternalId()
    {
        List<Account> ls=new List<Account>();
        Account acc=new Account();
        acc.Account_Number_Custom__c=45678902;
        acc.AnnualRevenue=10000;
        ls.add(acc);
        
        upsert ls Account_Number_Custom__c;
        
    }
    
    public void upsertAccountWithExternalId1()
    {
        List<Account> ls=new List<Account>();
        Account acc=new Account(Account_Number_Custom__c=45678902,Phone='3312138743');
        Account acc1=new Account(Account_Number_Custom__c=44444444,Name='care hospital',Phone='9187656778');
        ls.add(acc);
         ls.add(acc1);
        
        upsert ls Account_Number_Custom__c;
        
    }
    
     public void insertOpportunityWithExternalId()
    {
        Account ac=new Account(Name='Facebook',Account_Number_Custom__c=34543245);
        
       insert ac;
            
        Opportunity acc=new Opportunity(Name='oppp4',StageName='Prospecting',
                                          CloseDate=Date.today().addDays(7));
        acc.Account=ac;
        insert acc;
        
    }
    
      public void insertOpportunityAccountWithExternalId()
    {
        Account ac=new Account(Account_Number_Custom__c=5555555);
      
            
        Opportunity acc=new Opportunity(Name='oppp4',StageName='Prospecting',
                                          CloseDate=Date.today().addDays(7));
        acc.Account=ac;
      
         Account parentacc=new Account(Name='Deepam',Account_Number_Custom__c=5555555);   
        List<DataBase.SaveResult> result=DataBase.insert(new SObject[] {
            parentacc, acc});
        
        for(DataBase.SaveResult sr:result)
        {
            if(sr.isSuccess())
            {
                System.debug('success'+sr.getId()); 
                System.debug('success'+parentacc.Name); 
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
    
    public void undeleteAccount()
    {
        List<Account> ls1=[SELECT Id,Name FROM Account];
        System.debug(ls1.size());
        List<Account> ls2=[SELECT Id,Name FROM Account All Rows];
        System.debug(ls2.size());
         List<Account> ls3=[SELECT Id,Name FROM Account where isDeleted=true All Rows];
        System.debug(ls3.size());
        
      undelete ls3;
        
         List<Account> ls4=[SELECT Id,Name FROM Account];
        System.debug(ls4.size());
        
    }
    

}