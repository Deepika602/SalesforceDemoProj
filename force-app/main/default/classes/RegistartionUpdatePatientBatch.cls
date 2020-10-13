public class RegistartionUpdatePatientBatch implements Database.Batchable<Sobject>,Database.stateful
{
    public Integer totalPatientCreated=0;
    public Integer totalPatientsActivated=0;
    public string query;
    public Set<Id> st=new Set<Id>();
    public RegistartionUpdatePatientBatch()
    {
        
     }
    public RegistartionUpdatePatientBatch(String strquery)
    {
        query=strquery;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        if(String.isblank(query))
        {
            query='SELECT id ,Name,(SELECT id,name,isActive__c from Patients__r) from Registration__c';
             system.debug('###########################################lsss');
        }
        return Database.getQueryLocator(query);
    }
     public void execute(Database.BatchableContext bc,List<Registration__c> lstData)
    {
         system.debug('#########################################'+lstData);
        
        
        List<Patient__c> lsupdate=new List<Patient__c>();
         List<Patient__c> lscreate=new List<Patient__c>();
        for(Registration__c reg:lstData)
        {
            if(reg.Patients__r.size()==0)
            {
                Patient__c pat=new Patient__c();
                pat.Registration__c=reg.id;
                pat.Name='Harika';
                pat.isActive__c=true;
                lscreate.add(pat);
                totalPatientCreated++;
            }
            else if(reg.Patients__r!=null && reg.Patients__r.size()==1)
            {
               // List<Patient__c> lspat=reg.Patients__r;
                
                for(Patient__c pat:reg.Patients__r)
                {
                    if(pat.isActive__c==false)
                    {
                        pat.isActive__c=true;
                        lsupdate.add(pat);
                        totalPatientsActivated++;
                    }
                }
                
            }
             else if(reg.Patients__r!=null && reg.Patients__r.size()>1)
             {
                Integer c=0;
                 st.add(reg.Id);
                 List<Patient__c> lspat=reg.Patients__r;
                 for(Patient__c pat:lspat)
                 {
                     if(pat.isActive__c==false)
                     {
                         c++;
                         pat.isActive__c=true;
                         totalPatientsActivated++;
                         lsupdate.add(pat);
                         if(c>0)
                         {
                             break;
                         }
                     }
                 } 
             }
        }
      insert lscreate;
       update lsupdate; 
    }
    public void finish(Database.batchableContext bc)
    {
        system.debug('Total patient created################## '+totalPatientCreated);
        system.debug('Total patients activated################## '+totalPatientsActivated);
        system.debug('no of registrations having more than one patient'+st);
        system.debug(' Context varible '+bc);
         AsyncApexJob a = [Select Id, Status,ExtendedStatus,NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email from AsyncApexJob where Id =:bc.getJobId()];
      
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject(' Batch ' + a.Status);
        mail.setPlainTextBody('Patient records created ' + totalPatientCreated+ 'no of patients activated '+ totalPatientsActivated
                             +'no of registrations are having more than one patient '+st);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
    }
}