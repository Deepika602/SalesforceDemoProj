public class DisplayPatAppController {
      @AuraEnabled
    public static List<Patient__c> getPatients()
    {
        List<Patient__c> ls=[SELECT id,Name FROM Patient__c];
        return ls;
    }
     @AuraEnabled
    public static List<Appoitment__c> getAppoitmentsInfo(string ptId)
    {
        Patient__c p=[SELECT id,Name,(select id,name from Appointments__r) 
            from Patient__c where Patient__c.id=:ptId];
        List<Appoitment__c> ls=p.Appointments__r;
        return ls;
        
    }
     @AuraEnabled
    public static List<Appoitment__c> getAppoitmentsInfo1(Id ptId)
    {
        Patient__c p=[SELECT id,Name,(select id,name from Appointments__r) 
            from Patient__c where Patient__c.id=:ptId];
        List<Appoitment__c> ls=p.Appointments__r;
        return ls;
        
    }    
}