public class WrapperClassDemo 
{
    public String Username;
    Public Integer age;
    Public Account acc;
    Public Contact con;
    
    public WrapperClassDemo()
    {   
        
    }
    
    public WrapperClassDemo(String Username,Integer age,Account acc,Contact con)
    {
        this.Username=Username;
        this.age=age;
        this.acc=new Account();
        this.con=new Contact();
    }
    
    public WrapperClassDemo getUserInfo()
    {
        WrapperClassDemo wc=new WrapperClassDemo();
        wc.Username='Ramu';
        wc.age=35;
        wc.acc=new Account();
        wc.acc.AccountNumber='22323233';
        wc.acc.Active__c='yes';
        wc.acc.AnnualRevenue=5000;
        wc.acc.Industry='Banking';
        wc.con=new Contact();
        return wc;
    }
    
    public List<WrapperClassDemo> getUsersInfo()
    {
        List<WrapperClassDemo> ls=new List<WrapperClassDemo>();
        WrapperClassDemo wc=new WrapperClassDemo();
        wc.Username='Deepu';
        wc.age=40;
        wc.acc=new Account();
        wc.acc.AccountNumber='22323233';
        wc.acc.Active__c='yes';
        wc.acc.AnnualRevenue=5000;
        wc.acc.Industry='Banking';
        wc.con=new Contact();
        wc.con.AssistantName='karthik';
        ls.add(wc);
        
        WrapperClassDemo wc1=new WrapperClassDemo('Arun',34,new Account(),new Contact());
        ls.add(wc1);
        return ls;
    }

}