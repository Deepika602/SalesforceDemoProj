public class RegistrationController {
    public String name ;
    public Date dob;
    public Integer age;
    public Integer salary;
    public Boolean isPatient;
    
  public void assignValues()
 {
  name='Deepika';
  dob=Date.newInstance(1985, 01, 09);
  age=36;
  salary=3000;
  isPatient=true;
}
    public RegistrationController()
    {
    assignValues();
    name='Karthik';
    dob=Date.newInstance(1984, 09, 07);
    age=36;
    salary=5000;
    isPatient=true; 
    }
    
}