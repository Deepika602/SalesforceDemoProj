public class QueableClassDemo implements queueable{
  
   public List<Patient__c> ls;
    public QueableClassDemo(List<Patient__c> lspat)
    {
        ls=lspat;
    }
    
    public QueableClassDemo()
    {
        
    }
    
    public void execute(queueableContext qc)
    {
       /* List<Registration__c> regls=[select id,Name from Registration__c where id in :stregid];
        List<
            for(Registration__c reg:regls)*/
     // Account acc=new Account();
     // acc.Name='acc1';
        if(ls!=null)
        {
        insert ls;
        }
    }

}