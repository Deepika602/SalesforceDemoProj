public class demoController {
    public String name ;
    public String email;
    public String phone;
    public Integer age;
    public Integer salary;
    public Date dob;
    public Date joinedDate;
    public Boolean isMatched;
    public Boolean isSalaryProvided;
    public demoController()
    { 
    }
    
    public demoController(String nam,Integer age1)
    {
        name=nam;
        age=age1;
        system.debug(name);
        system.debug(age);
        
    }
     public demoController(String nme, Integer ag, Integer slary)
    {
        name=nme;
        age=ag;
        salary=slary;
        system.debug(name);
        system.debug(age);
        system.debug(salary);
        }
    
       
}