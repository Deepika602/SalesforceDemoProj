public class AppointmentTriggerHandler {
    
    public void onBeforeInsert(List<Appoitment__c> apptLst)
    {
        Set<Id> st=new Set<Id>();
        for(Appoitment__c app:apptLst)
        {
            st.add(app.Patient__c);  
            app.status__c='Open';
        }
        List<Patient__c> ls=[SELECT Id,Name,(SELECT Patient__c,Physician__c,AppointmentDate__c, Slot_Time__c FROM Appointments__r)
                             FROM Patient__c WHERE Id IN :st];
        for(Patient__c  p:ls){
            List<Appoitment__c> lst = p.Appointments__r;
            for(Appoitment__c app1:apptLst) {                
                for(Appoitment__c app:lst) {
                    if(	app.Patient__c == app1.Patient__c &&app.Physician__c==app1.Physician__c&& 
                       app.AppointmentDate__c==app1.AppointmentDate__c &&
                       app.Slot_Time__c == app1.Slot_Time__c) {
                           app1.addError('Invalid');
                       }
                }                
            }
        }
    }
    
    public void onBeforeUpdate(List<Appoitment__c> apptLst,Map<Id,Appoitment__c> oldMap)
    {
        Set<Id> st=new Set<Id>();
        for(Appoitment__c app:apptLst)
        {
            if(app.Branch__c!=oldMap.get(app.Id).Branch__c)
            {
            st.add(app.Patient__c); 
            }
        }
        List<Patient__c> ls=[SELECT Id,Name,(SELECT Patient__c,Physician__c,AppointmentDate__c, Slot_Time__c FROM Appointments__r)
                             FROM Patient__c WHERE Id IN :st];
        for(Patient__c  p:ls){
            List<Appoitment__c> lst = p.Appointments__r;
            for(Appoitment__c app1:apptLst) {                
                for(Appoitment__c app:lst) {
                    if(	app.Patient__c == app1.Patient__c && app.Physician__c==app1.Physician__c&&
                       app.AppointmentDate__c==app1.AppointmentDate__c &&
                       app.Slot_Time__c == app1.Slot_Time__c) {
                           app1.addError('Invalid');
                       }
                }                
            }
        }
        
    }
    
    public void onBeforeDelete(List<Appoitment__c> lstOldApp){
        for(Appoitment__c app :lstOldApp){ 
            if (Date.TODAY().daysBetween(app.AppointmentDate__c) > 1){                    
                app.addError('You cannot delete a future appointment');
            }
        }             
    }
    
    public void onAfterinsert(List<Appoitment__c> lsnew)
    {  
        Map<String,Integer> mp=new Map<String,Integer>();
        Set<Id> physIds  = new Set<Id>();
        Set<Id> stpatientId=new Set<Id>();
        for (Appoitment__c app: lsnew)
        {
            physIds.add(app.Physician__c);
            stpatientId.add(app.Patient__c);
        }

        List<AggregateResult> phys=[SELECT Physician__c,count(Id) FROM Appoitment__c where
                                    Patient__r.id IN :stpatientId group by Physician__c];
        List<Patient__c> ptLs=new List<Patient__c>();
       
      phys.sort();
      Integer i=(phys.size()-1);
        ID id=(ID)phys[i].get('Physician__c');
        for (Appoitment__c app: lsnew)
        {
            Patient__c p=new Patient__c();
            p.Primary_Physician__c=id;
            p.id=app.Patient__c;
            ptLs.add(p);
        }
        update ptLs;
        
    }

 public void onAfterUpdate(List<Appoitment__c> lsnew,Map<Id,Appoitment__c> oldMap) 
 {
Map<String,Integer> mp=new Map<String,Integer>();
        Set<Id> physIds  = new Set<Id>();
        Set<Id> stpatientId=new Set<Id>();
        for (Appoitment__c app: lsnew)
        {
             if(app.Physician__c!=oldMap.get(app.Id).Physician__c)
            {
            physIds.add(app.Physician__c);
            stpatientId.add(app.Patient__c);
            }
        }

        List<AggregateResult> phys=[SELECT Physician__c,count(Id) FROM Appoitment__c where
                                    Patient__r.id IN :stpatientId group by Physician__c];
        List<Patient__c> ptLs=new List<Patient__c>();
       
      phys.sort();
      Integer i=(phys.size()-1);
        ID id=(ID)phys[i].get('Physician__c');
        for (Appoitment__c app: lsnew)
        {
            Patient__c p=new Patient__c();
            p.Primary_Physician__c=id;
            p.id=app.Patient__c;
            ptLs.add(p);
        }
        update ptLs;        
 }
}