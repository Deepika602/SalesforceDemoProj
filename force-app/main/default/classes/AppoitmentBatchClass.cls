public class AppoitmentBatchClass implements Database.Batchable<Sobject>,Database.stateful
{ 
     public string query;
    public integer totalCount = 0;
    public integer hosCount=0;
    
    public AppoitmentBatchClass()
    {
        
    }
    
    public Database.QueryLocator start(Database.batchableContext bc)
    {   
        if(string.isBlank(query)){
            query = 'SELECT id ,Name,(SELECT id,name,status__c from Appointments__r) from Account';
            system.debug('###########################################lsss');
        } 
        return database.getQueryLocator(query);
    }
    public void Execute(Database.batchableContext bc,List<Account> lstData)
    {
       
        system.debug('#########################################'+lstData);
        List<Appoitment__c> appls=new List<Appoitment__c>();
        Set<Id> acc=new Set<Id>(); 
        for(Account hos:lstData)
        {
            if(hos.Appointments__r!=null)
            {
                acc.add(hos.Id);
           List<Appoitment__c> lsapp=hos.Appointments__r;
            for(Appoitment__c app:lsapp)
            {
               app.status__c='Closed';
                appls.add(app);
            }     
        }
        }
        hosCount=acc.size();
        totalCount = totalCount + appls.size();
        update appls; 
    }
    
    public void finish(Database.batchableContext bc)
    {
        system.debug('Total records##########'+totalCount);
        system.debug(' Context varible*************** '+bc);
        system.debug('Total hospital records$$$$$$$$$$$$$$$$$$$$'+hosCount);
         AsyncApexJob a = [Select Id, Status,ExtendedStatus,NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email from AsyncApexJob where Id =:bc.getJobId()];
      
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject(' Batch ' + a.Status);
        mail.setPlainTextBody('records processed ' + totalCount+   'with hospital unique'+ hosCount);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}