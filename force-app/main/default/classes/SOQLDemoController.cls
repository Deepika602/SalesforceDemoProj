public class SOQLDemoController {
    
    public List<Account> getHospitals()
    {
        List<Account> hos=new List<Account>([SELECT Id,Name,(SELECT Id,Name FROM Appointments__r) 
                                               FROM Account]);
        return hos;
    }
    
    public List<Physician__c> getAppointments(Id Id)
    {
        List<Physician__c> phy=new List<Physician__c>([SELECT Id,Name,(SELECT Id,Name FROM Appointments__r) 
                                                     FROM Physician__c where Id=:Id]);
        return phy;
    }
    
    public List<Patient__c> getPatients(Set<ID> st)
    {
        
        List<Patient__c> patient=new List<Patient__c>([SELECT Id,Name From Patient__c where Registration__r.Id IN :st]);
                                                    
      return patient; 
    }
    
    public Set<ID> GetHospitalFromPatient()
    {
        List<Patient__c> patients=new List<Patient__c>([SELECT Id,Name,(SELECT Id,Hospital__r.Id, Name FROM Appointments__r) FROM Patient__c]);
        List<Appoitment__c> appoint=new List<Appoitment__c>();
         Set<Id> st=new Set<Id>();
        for(patient__c pt:patients)
        {
            if(pt.Appointments__r!=null)
            {
               for(Appoitment__c app:pt.Appointments__r)
               {
                   appoint.add(app);
                   st.add(app.Hospital__r.Id);
               }
            }
        }
        
       return st;      
    }
    
    public List<Appoitment__c> getAppointmentsWithHospital(ID id)
    {
        List<Account> ac=[SELECT Id,Name,(SELECT ID,Name FROM Appointments__r
                                          where Hospital__r.Id=:id) From Account];                    
        List<Appoitment__c> ls=new List<Appoitment__c>();
        for(Account acc:ac)
        {
            if(acc.Appointments__r!=null)
            {
                 for(Appoitment__c apt:acc.Appointments__r)
                {
                    ls.add(apt);
                }
             }
         }
      return ls;
      }
    
    public List<String> getBranches()
    {
        list<Account> lst=[SELECT Id,Name,(SELECT ID,Name FROM Branches__r) From Account];
        String HospitalName;
        String BrancheName;
        String result;
        List<String> ls=new List<String>();
        for(Account acc:lst)
        {
            HospitalName=acc.Name;
            if(acc.Branches__r!=null)
            {
                for(Branch__c br:acc.Branches__r)
                {
                    BrancheName=br.Name;
                    result=HospitalName+' - '+BrancheName;
                    ls.add(result);
                }
                
            }
        }
        return ls;
    }
    
    public Map<Id,Integer> getPatientStats()
    {
        List<AggregateResult> result=[SELECT Patient__r.Id patient,count(Id) total from Appoitment__c
                                       Group by Patient__r.Id];
        Map<Id,Integer> mp=new Map<Id,Integer>();
        for(AggregateResult agr:result)
        {  
          mp.put((Id)agr.get('patient'),(Integer)agr.get('total'));
         }
        return mp;
    }
}