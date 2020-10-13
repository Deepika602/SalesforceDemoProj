trigger PatientTrigger on Patient__c (before insert,before update,before delete,after insert,after update,after delete) 
{
 PatientTriggerHandler handler = new PatientTriggerHandler();
    
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
           // handler.onAfterInsert(Trigger.New);
        }
        else if(Trigger.isUpdate){
            //handler.onAfterUpdate(Trigger.New,Trigger.OldMap);
        }
        else if(Trigger.isDelete){
        //handler.onAfterDelete(Trigger.Old);
        }
    }
}