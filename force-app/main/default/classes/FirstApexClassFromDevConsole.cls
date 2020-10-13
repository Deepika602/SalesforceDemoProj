public class FirstApexClassFromDevConsole {
    private ID id;
private String firstName;
private String lastName;
private Integer courseNo;
private Date startDate;
private Datetime endDate;
private Boolean isStarted;
Date myDate = Date.newInstance(1987, 12, 17);
Date firstDate = myDate.toStartOfMonth();
Date myDate1 = Date.today();
Date weekStart = myDate1.toStartofWeek();    
public void assignValues()
 {
     id='00300000003T2PGAA0';
firstName='Deepika';
lastName='Polasani';
courseNo=56;
startDate=Date.today();
endDate=startDate.addMonths(2);
isStarted=false;
     System.debug(id);
    System.debug(firstName); 
      System.debug(lastName); 
      System.debug(courseNo); 
      System.debug(startDate); 
      System.debug(endDate); 
     System.debug(isStarted); 
     System.debug(firstDate);
      System.debug(weekStart);
 }
}