public class SOSLDemoClass {
    
    public SOSLDemoClass()
    {
        
    }
    
    public void SOSLDemo()
    {
        List<List<SObject>> sobj=[Find 'te*' IN ALL FIELDS Returning Account(Id,Name)
                                ,Contact(Id,Name),Opportunity(Id,Name)];
        System.debug('outerlist size '+sobj.size());
        List<Account> acc=sobj[0];
         List<Contact> con=sobj[1];
         List<Opportunity> opp=sobj[2];
        System.debug(acc);
          System.debug(con);
          System.debug(opp);
    }
    
    public void dynamicSOSLObjectDemo(String searchstr)
    {
        String quer='FIND \'' + searchstr + '\' IN ALL FIELDS Returning Account(Id,Name),Contact(Id,Name),Opportunity(Id,Name)';
               
         List<List<sObject>> sobj = Search.query(quer);
         System.debug('outerlist size '+sobj.size());
        List<Account> acc=sobj[0];
        for(Account ac:acc)
        {
            System.debug(ac.Id);
            System.debug(ac.Name);
        }
         List<Contact> con=sobj[1];
         List<Opportunity> opp=sobj[2];
        System.debug(acc);
          System.debug(con);
          System.debug(opp);
    }
}