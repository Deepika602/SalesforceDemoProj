public class RegistrationBatchSchedule implements Schedulable  {
    
    public void execute(schedulableContext sc)
    {
        PatientCreationBatch pc=new PatientCreationBatch();
        Database.executeBatch(pc);
         QueableClassDemo qc=new QueableClassDemo();
        System.enqueueJob(qc);
    }

}