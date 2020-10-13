public class RegistrationPatientCreateBatch implements Database.Batchable<Sobject>,Database.stateful
{
    public Integer totalCount=0;
    public string query;
    public RegistrationPatientCreateBatch()
    {
        // query='Select Id,name from Registration__c where Id not In (select Registration__c from Patient__c)';
    }
    public RegistrationPatientCreateBatch(String strquery)
    {
        query=strquery;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        if(String.isblank(query))
        {
            query='Select Id,name from Registration__c where Id not In (select Registration__c from Patient__c)';
        }
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc,List<Registration__c> lstData)
    {
        List<Patient__c> lspat=new List<Patient__c>();
        for(Registration__c reg:lstData)
        {
            Patient__c pat=new Patient__c();
            pat.Registration__c=reg.id;
            pat.Name='Amrutha'+1;
            lspat.add(pat);
        }
        
        totalCount = totalCount + lspat.size();
        insert lspat;    
    }
    public void finish(Database.batchableContext bc)
    {
        system.debug('Total records################## '+totalCount);
        system.debug(' Context varible '+bc);
    }
    
}