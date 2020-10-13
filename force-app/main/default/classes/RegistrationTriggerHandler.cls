public class RegistrationTriggerHandler {
    
    
    public void onAfterInsert(List<Registration__c> registrationLst)
    {
        List<Patient__c> shareLst=new List<Patient__c>();
        
        for(Registration__c regis:registrationLst)
        {
            Patient__c patient=new Patient__c();
            patient.Registration__c=regis.Id;
            patient.Email__c=regis.Email__c;
            // patient.Name='Amrutha'+1;
            patient.Age__c=regis.Age__c;
            shareLst.add(patient);
        }
        // insert shareLst;
        QueableClassDemo qc=new QueableClassDemo(shareLst);
        System.enqueueJob(qc);
        
    }
    
    public void onAfterUpdate(List<Registration__c> registrationLst,Map<Id,Registration__c> oldMap)
    {
        Set<id> setOfParentId = new Set<Id>();
        for(Registration__c pt : registrationLst)
        {
            setOfParentId.add(pt.id);
        }
        List<Registration__c> regisLst=new List<Registration__c>([SELECT Id,Name,Email__c,(SELECT Id FROM Patients__r) 
                                                                  From Registration__c where Id IN :setOfParentId]);
        
        List<Patient__c> updatedlistChild = new List<Patient__c>();
        for(Registration__c regis:regisLst)
        {
            if(regis.Email__c!=oldMap.get(regis.id).Email__c)
            {
                list<Patient__c> psst= regis.patients__r;
                
                for(Patient__c pat:psst)
                {
                    
                    pat.Email__c=regis.Email__c;
                    updatedlistChild.add(pat);
                }
            }           
        }
        update updatedlistChild;
    }
    
    
}