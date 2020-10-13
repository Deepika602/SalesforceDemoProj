public class PatientUpdateBatch implements Database.Batchable<Sobject>,Database.stateful
{ 
    public string query;
    public integer totalCount = 0;
    public List<Registration__c> ls;
    
    public PatientUpdateBatch(){
        // query = 'Select id,name from account';
    }
    
    public List<Registration__c> updatePatient()
    {
        //ls=new List<Registration__c>();
         ls=[Select Id,name from Registration__c where Id not In (select Registration__c from Patient__c)];
       // ls=[Select Id,name,(SELECT Name from Patients__r) from Registration__c];
       system.debug('@@@@@@@@@@@@@@@@@@'+ls);
        return ls;
    }
    
    public PatientUpdateBatch(string strQuery){
        query = strQuery;
    }
    
    
    public Database.QueryLocator start(Database.batchableContext bc){
        //string query='Select id,name from account';
        if(string.isBlank(query)){
            query = 'select name,id from Patient__c where Registration__c=null';
        } 
        return database.getQueryLocator(query);
        
        //retrun new iterateClassDemo();
    }
    public void Execute(Database.batchableContext bc,List<Patient__c> lstData)
    {
        ls=updatePatient();
        system.debug('#########################################'+ls);
        List<Patient__c> pls=new List<Patient__c>();
        for(Patient__c pat:lstData)
        {
            for(Registration__c reg:ls)
            {
                if(reg.patients__r==null)
                {   
                    pat.Registration__c=reg.id;
                }
            }
        }
        totalCount = totalCount + lstData.size();
        update lstData; 
    }
    
    public void finish(Database.batchableContext bc)
    {
        system.debug('Total records##########'+totalCount);
        system.debug(' Context varible '+bc);
    }
}