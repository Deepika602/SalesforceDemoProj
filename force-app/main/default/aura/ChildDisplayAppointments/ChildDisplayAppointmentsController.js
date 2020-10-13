({
	
	apptDisplay : function(component, event, helper) 
    {
        alert('545454');
        var parmvalues=event.getParam('arguments');
        console.log(parmvalues.ptId);
        var aMethod = component.get("c.getAppoitmentsInfo1");
        alert('55454');

        aMethod.setParams({
           'ptId':parmvalues.ptId
        });
        
        aMethod.setCallback(this,function(retVal){
            var currentState = retVal.getState(); //SUCCESS or ERROR
            if(currentState == 'SUCCESS'){
                var AppointmentList = retVal.getReturnValue();
               
                component.set("v.AppointmentList",AppointmentList);
                console.log(component.get("v.AppointmentList"));
                component.set("v.isShow",false);
            }
            else{
                alert('Error');
                console.log(error);
            }
        });

		$A.enqueueAction(aMethod);  
	}
		
   
})