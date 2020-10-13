public class PatientTriggerHandler 
{
    public void onBeforeInsert(List<Patient__c> patientLst)
    {
        Set<Id> st=new Set<Id>();
        Map<id, Registration__c> mapRegis = new Map<id, Registration__c>();
        for(Patient__c pat:patientLst)
        {
            st.add(pat.Registration__c);
        }
        List<Registration__c> regLst=[SELECT Id,Name From Registration__c where id IN :st];
        if (!regLst.isEmpty()) {
            for (Registration__c reg : regLst) {
                mapRegis.put(reg.Id, reg);
            }
            for(Patient__c pat:patientLst)
            {
                 Registration__c reg=new Registration__c();
                if(mapRegis.containsKey(reg.Id)) {
                    pat.addError(' Patient already contains Registration - ' + mapRegis.get(pat.Registration__c).Name);
                }
            }
        }
    }
    public void onBeforeUpdate(List<Patient__c> patientLst,Map<Id,Patient__c> oldMap)
    {
        Set<Id> st=new Set<Id>();
        Map<id, Registration__c> mapRegis = new Map<id, Registration__c>();
        for(Patient__c pat:patientLst)
        {
           // st.add(oldMap.get(pat.id).Registration__c);
           st.add(pat.Registration__c);
        }
        List<Registration__c> regLst=[Select Id,Name,(Select Id From Patients__r) From Registration__c Where Id IN : st];
 
         for (Registration__c reg : regLst) {
                
                mapRegis.put(reg.Id, reg);
        }
        for(Patient__c pat:patientLst)
            {
                if(pat.Registration__c!=oldMap.get(pat.id).Registration__c)
                {
                    system.debug('#################################');
                Registration__c reg=new Registration__c();
                reg.id=pat.Registration__c;
                if((mapRegis.containskey(reg.Id))&&(mapRegis.get(reg.Id).Patients__r.size()>1)) {
                    System.debug('@#@#@#@#@#@#@##@#@@#@#@#@#@#');
                    pat.addError('Patient already contains Registration - ' + mapRegis.get(pat.Registration__c).Name);
                }
            }
            }
    }
    public void onAfterUpdate(List<Patient__c> patientLst,Map<Id,Patient__c> oldMap)
    {
        Map<Id,Physician__c> mp=new Map<Id,Physician__c>();
        List<Patient__c> ptLs=new List<Patient__c>();
        Set<id> setOfParentIdnew = new Set<Id>();
        Set<id> setOfParentIdold = new Set<Id>();
        Set<id> setOfPatientId=new Set<Id>();
        for(Patient__c pt : patientLst)
        {
            if(pt.Primary_Physician__c!=oldMap.get(pt.Id).Primary_Physician__c)
            {
                setOfParentIdnew.add(pt.Primary_Physician__c);
                setOfParentIdold.add(oldMap.get(pt.Id).Primary_Physician__c);    
                setOfPatientId.add(pt.Id);
            } 
            
        }
        
        
        Map<Id,Physician__c> phyForUpdate = new Map<ID,Physician__c>([SELECT Id,No_of_Patients__c FROM Physician__c
                                                                      where Id IN :setOfParentIdnew]);  
        Map<Id,Physician__c> phyForUpdateOld=new Map<ID,Physician__c>([SELECT Id,No_of_Patients__c FROM Physician__c
                                                                       where Id IN :setOfParentIdold]); 
      

      //  List<AggregateResult> phys=[SELECT Physician__c,count(Id) FROM Appoitment__c where
                                 //   Patient__r.id IN :setOfPatientId group by Physician__c];     
       
        for(Physician__c pt : phyForUpdate.values())
        {
            Physician__c myParentOpp = phyForUpdate.get(pt.Id);
            if(myParentOpp.No_of_Patients__c!=null)
            {
            myParentOpp.No_of_Patients__c=myParentOpp.No_of_Patients__c+1;
            }
            else
            {
                myParentOpp.No_of_Patients__c=1;
            }
            mp.put(myParentOpp.Id,myParentOpp);
        }
         
        for(Physician__c pt1 : phyForUpdateOld.values())
        {
            Physician__c myParent=phyForUpdateOld.get(pt1.Id);
             if(myParent.No_of_Patients__c>1)
             {
            myParent.No_of_Patients__c=myParent.No_of_Patients__c-1;
             }
            else
            {
                myParent.No_of_Patients__c=0;
            }
            mp.put(myParent.Id,myParent);
        }

        update mp.values();   
}  
    public void onAfterDelete(List<Patient__c> lstOldApp)
    {
        Set<id> setOfParentIdnew = new Set<Id>();
        for(Patient__c p:lstOldApp)
        {
            setOfParentIdnew.add(p.Primary_Physician__c);
        }
        Map<Id,Physician__c> OppForUpdate = new Map<ID,Physician__c>([SELECT Id,No_of_Patients__c FROM Physician__c
                                                                      where Id IN :setOfParentIdnew]); 
        for(Physician__c pt : OppForUpdate.values())
        {
            Physician__c myParentOpp = OppForUpdate.get(pt.Id);
            myParentOpp.No_of_Patients__c=myParentOpp.No_of_Patients__c-1;
        }
        update OppForUpdate.values();
    }
}