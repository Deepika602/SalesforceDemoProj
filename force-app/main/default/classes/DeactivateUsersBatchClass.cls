public class DeactivateUsersBatchClass implements Database.Batchable<SObject>,Database.stateful
{
  Integer total=0;
    String str='Automated Process';
  public String query = 'select id,name from user' 
      +'where IsActive=true and LastLoginDate!=Last_N_Days:5'
      +'and Name!=\'Automated Process\' and Name!=\'Data.com Clean\' ';
    
    public Database.querylocator start(Database.BatchableContext bc)
    {
        system.debug('###############');
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc,List<User> scope)
    {
        system.debug('@@@@@@@@@@@@@@@@@@'+scope);
      List<User> userList = new List<User>();
        
        for(User s:scope)
        {
            User u =(user)s;
            userList.add(u);
        }
        
        if(userList.size() > 0)
        {
            for(User usr : userList)
            {
                usr.IsActive = false;
            }
        }
        total=userList.size();
        update userList;
    }
    
    public void finish(Database.BatchableContext bc)
    {
        system.debug('@@@@@@@@@@@@@@@@@@@@@'+total);
    }
}