public class DMLPractiseDemo {
    
    public DMLPractiseDemo()
    {
        
    }
    
    public void CreatePatients(Set<Id> st)
    {
        List<Registration__c> regLs=[SELECT Id,Name FROM Registration__c where id IN :st];
        List<Patient__c> patLs=new List<Patient__c>();
        Integer i=1;
        for(Registration__c reg:regLs)
        {
            Patient__c pat=new Patient__c();
            pat.Name='sulochana'+i;
            pat.Address__c='hyd';
            pat.Registration__c=reg.Id;
            patLs.add(pat);
            i++;
        }
        
        insert patLs; 
    }
    
    public void UpdatePatients(Set<Id> st)
    {
        List<Patient__c> patLst=[SELECT Registration__r.Id,Registration__r.Email__c From Patient__c 
                                 where Registration__r.Id IN :st];
        List<Patient__c> pat=new List<Patient__c>();
        for(Patient__c pt:patLst)
        {
            pt.Email__c=pt.Registration__r.Email__c;
            pat.add(pt);
        }
        update pat;
    }
    
    public void deleteAppointment()
    {
        List<Appoitment__c> apt=[SELECT Id FROM Appoitment__c where Branch__r.Id=null];
        for(Appoitment__c appt:apt)
        {
            
            delete appt;
        }
    }
    public void undeleteAppoitment()
    {
        List<Appoitment__c> apt1=[SELECT Id FROM Appoitment__c where isDeleted=true All Rows];
        undelete apt1;
    }
    
    public void upsertregistration()
    {
        List<Registration__c> regLst=[SELECT Id,Name,Email__c,(SELECT Id FROM Patients__r) 
                                      From Registration__c];
        List<Patient__c> ptls=new List<Patient__c>();
        for(Registration__c reg:regLst)
        {
            reg.Email__c=reg.Email__c+'1';
            list<Patient__c> psst= reg.patients__r;
            if(psst.isEmpty()){               
                System.debug('Deepika');
                Patient__c p=new Patient__c();
                p.Name='Rajkumar';    
                p.Phone_Mobile__c='+1223232333';
                p.Registration__c=reg.id;
                ptls.add(p);
            }else{
                for(Patient__c plst : psst){
                    plst.Phone_Mobile__c= '+9245474754';
                    ptls.add(plst);
                }
            }   
        }
        upsert regLst;
        upsert ptls;
    }
    
}