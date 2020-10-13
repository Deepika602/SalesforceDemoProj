public class PatientCreationBatch implements Database.Batchable<Sobject>,Database.stateful,Schedulable
{ 
    public string query;
    public integer totalCount = 0;
    public PatientCreationBatch(){
       // query = 'Select id,name from account';
    }
    
    public PatientCreationBatch(string strQuery){
        query = strQuery;
    }
    
    public PatientCreationBatch(set<id> accIdSet){
        query = 'Select id,name from account where id in :accIdSet';
    }
    
    public Database.QueryLocator start(Database.batchableContext bc){
        //string query='Select id,name from account';
        if(string.isBlank(query)){
            query = 'Select id,name from account';
        }
        
        return database.getQueryLocator(query);
        
        //retrun new iterateClassDemo();
    }
    public void Execute(Database.batchableContext bc,List<Account> lstData){
        for(Account acc:lstData)
        {
            
            acc.Name = acc.Name+'';
        }
        
        totalCount = totalCount + lstData.size();
        update lstData;    
    }
    public void finish(Database.batchableContext bc)
    {
        system.debug('Total records '+totalCount);
        system.debug(' Context varible '+bc);
    }
    public void execute(schedulableContext sc)
    {
        PatientCreationBatch pc=new PatientCreationBatch();
        Database.executeBatch(pc);
         QueableClassDemo qc=new QueableClassDemo();
        System.enqueueJob(qc);
    }
}