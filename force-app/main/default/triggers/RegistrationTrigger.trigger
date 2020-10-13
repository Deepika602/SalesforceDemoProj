trigger RegistrationTrigger on Registration__c (after insert,after update) 
{
RegistrationTriggerHandler handler = new RegistrationTriggerHandler();
    
    If(Trigger.isBefore){
        if(Trigger.isInsert){
           
        }
        else if(Trigger.isUpdate){
            
        }
        else if(Trigger.isDelete){
        
        }
    }
    else if(Trigger.isAfter){
        if(Trigger.isInsert){
            //handler.onAfterInsert(Trigger.New);
        }
        else if(Trigger.isUpdate){
            //handler.onAfterUpdate(Trigger.New,Trigger.oldMap);
        }
        else if(Trigger.isDelete){
        
        }
    }
}