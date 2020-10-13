public class FirstApexClassFromSetup
{
//public Id id;
public String firstName;
public String lastName;
public Integer courseNo;
public Date startDate;
public Datetime endDate;
public Boolean isStarted;
public final Integer SSN;
public final Integer DL;
public static String org;
public static String department;

public FirstApexClassFromSetup()
{ 
//id='00300000003T2PGAA0';
firstName='Deepika';
lastName='Polasani';
courseNo=56;
startDate=Date.today();
endDate=startDate.addMonths(2);
isStarted=false;
SSN=123344;
DL=2332;
org='CIG';
department='Marketing';
system.debug(firstName+' '+lastName+' '+courseNo+' '+startDate+' '+endDate+' '+isStarted+' '+SSN+' '+DL+' '+org+' '+department);    
}
}