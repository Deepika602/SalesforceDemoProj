public class SOQLDemoClass {
    public void SOQLDemoClass()
    {
        
    }
    public void SOQLDemo()
    {
        Map<Id,Account> mp=new Map<Id,Account>([SELECT Id,Name,CreatedById,LastModifiedById FROM Account]);
        Set<Id> st=new Set<Id>();
        List<Account> ls=new List<Account>();
        st=mp.keySet();
        ls=mp.Values();
        System.debug(mp.get('0013t00001XGAQ6AAP').Name);
        for(ID aa:mp.keySet())
        {
            System.debug(aa);
        }
        for(Account aa:mp.values())
        {
            System.debug(aa);
        } 
        
        Map<Id,Account> mp1=new Map<Id,Account>();
        List<Account> ls12=[SELECT Id,Name from Account];
        for(Account a:ls12)
        {
            mp1.put(a.Id,a);
        }
        System.debug('Map '+mp1);
    }
    
    public void SOQLAggregateDemo()
    {
        List<AggregateResult> result=[SELECT StageName,count(Id),sum(amount),
                                      max(amount),min(amount) from Opportunity Group by StageName];
        for(AggregateResult agr:result)
        {   
            System.debug(agr.get('StageName'));
            System.debug(agr.get('expr0'));
            System.debug(agr.get('expr1'));
            System.debug(agr.get('expr2'));
            System.debug(agr.get('expr3'));
        }
    }
    
    public void SOQLChildToParentStandardObject()
    {
        List<Opportunity> ls=[SELECT AccountId,Account.Name,Account.Type,ownerId,createdById,
                              LastModifiedById,
                              Quote__r.ImplementationContact__r.owner.Name from Opportunity];
        Opportunity op=ls[0];
        System.debug(op.Quote__r.ImplementationContact__r.Email__c);
        System.debug(op.Account.Name);  
        System.debug(op.ownerId);
    }
    
    public void SOQLChildToParentMapStandardObject()
    {
        Map<Id,Opportunity> opp=new Map<Id,Opportunity>([SELECT Id,AccountId,Account.Name,Account.Type,ownerId,createdById,
                                                         LastModifiedById,
                                                         Quote__r.ImplementationContact__r.owner.Name from Opportunity]);
        for(Opportunity op:opp.values())
        {
            System.debug(op.AccountId);
            System.debug(op.Account.Name);
        }
        for(Id op:opp.keySet())
        {
            System.debug(opp.get(op));
            
        }
        
        
        
    }
    
    public void SOQLChildToParentCustomObject()
    {
        List<Technology__c> ls1=[SELECT Trainer__r.Trainer_salary__c,Id,Name,CreatedById,
                                 LastModifiedById FROM Technology__c];
        for(Technology__c t:ls1)
        {
            system.debug(t.Trainer__r.Trainer_salary__c);
            system.debug(t.LastModifiedById);
        }
    }
    public void SOQLParentToChild()
    {
        
        //SELECT id,Name,(SELECT id,Name from Students__r) FROM Account
        List<Account> acc=[Select id,Name,(SELECT id,Name from Opportunities),
                           (SELECT id,Name from Contacts) from Account];
        Account ac1=acc[6];
        System.debug(ac1);
        List<Opportunity> o=ac1.Opportunities;
        for(Opportunity opp:o)
        {
            System.debug(opp);
        }
        List<Contact> ct=ac1.Contacts;
        for(Contact con:ct)
        {
            System.debug(con);
        }
        
        
        List<Account> ac=[SELECT id,Name,(SELECT id,Name from Students__r) FROM Account];
        
        Account a=ac[6];
        List<Student__c> st=a.Students__r;
        for(Student__c stud:st)
        {
            System.debug('Custom '+stud);
        }
        
    }  
    
    public void SOQLParentToChild1()
    {
        Map<Id,Account> mp=new Map<Id,Account>([Select id,Name,(SELECT id,Name from Opportunities),
                                                (SELECT id,Name from Contacts) from Account]);
        Map<Id,List<Opportunity>> rolpp=new Map<Id,List<Opportunity>>();
        List<Opportunity> ls=new List<Opportunity>();
        for(Account a:mp.values())
        {
            if(a.Opportunities.size()>1)
            {
                rolpp.put(a.Id,a.Opportunities);
                ls=rolpp.get(a.Id);
            }
        }
        System.debug('Opportunity Map '+rolpp);
        System.debug(ls); 
    }
    public void dynamicSOQLDemo(String stageName)
    {
        String quer='SELECT Id,Name from Opportunity where Account.Name=\'Apex Technologies\'';
        if(String.isNotBlank(stageName))
        {
            quer=quer+'And stageName=:stageName';
        }
        List<Opportunity> opp=DataBase.query(quer);
        System.debug(opp);
    }
    
    
    
    
    
    
    
    
    
}