trigger AppointmentTrigger on Appoitment__c (before insert,before update,before delete,after insert,after update,after delete) 
{


 AppointmentTriggerHandler handler = new AppointmentTriggerHandler();
    
    If(Trigger.isBefore){
        if(Trigger.isInsert){
            //handler.onBeforeInsert(Trigger.New);
        }
        else if(Trigger.isUpdate){
            //handler.onBeforeUpdate(Trigger.New,Trigger.OldMap);
        }
        else if(Trigger.isDelete){
      //handler.onBeforeDelete(Trigger.Old);
        }
    }
    else if(Trigger.isAfter){
        if(Trigger.isInsert){
           //handler.onAfterInsert(Trigger.New);
        }
        else if(Trigger.isUpdate){
            //handler.onAfterUpdate(Trigger.New,Trigger.OldMap);
        }
        else if(Trigger.isDelete){
        
        }
    }
}