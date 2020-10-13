public class SampleDemo
{
    public void createPatient(Set<Id> st)
    {
        List<Registration__c> regLst=[SELECT Id,Name,Email__c, (SELECT Id FROM Patients__r) 
                                      From Registration__c where id IN :st];
        try
        {
          for(Registration__c reg:regLst)
          {
           for(Patient__c pt:reg.Patients__r)
           {
              if(pt.Id==null)
           {
               System.debug('Deepika');
               Patient__c p=new Patient__c();
               p.Name='Rajkumar';    
               p.Phone_Mobile__c='+1223232333';
              insert p;
           } 
            else if(pt.Id!=null)
           {
               CustomException c=new CustomException('it is 1-1 reletionship');
             throw c;
           }   
        }
    }

}
        catch(CustomException ex)
        {
            System.debug(ex.getMessage());
        }
    }
public class CustomException extends Exception
{
    
}
      
}