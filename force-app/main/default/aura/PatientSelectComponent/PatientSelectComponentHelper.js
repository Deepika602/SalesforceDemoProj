({
	doInitHelper : function(component,event,helper) {
		var aMethod = component.get("c.getPatients");
       
        aMethod.setCallback(this,function(retVal){
            alert('enter');
            var currentState = retVal.getState(); //SUCCESS or ERROR
            alert('hi');
            if(currentState == 'SUCCESS'){
                alert('success');
                var patList = retVal.getReturnValue();
               
               component.set("v.patList",patList);
                console.log(component.get("v.patList"));
               
            }
            else{
                alert('Error');
            }
        });
        $A.enqueueAction(aMethod);  
	},
    doDisplayAppointment : function(component, event, helper)
    {
    var aMethod = component.get("c.getAppoitmentsInfo");
        alert(component.get("v.recordId"));
        aMethod.setParams({
            'patId':component.get("v.recordId")
        });
        
        aMethod.setCallback(this,function(retVal){
            var currentState = retVal.getState(); //SUCCESS or ERROR
            if(currentState == 'SUCCESS'){
                var AppointmentList = retVal.getReturnValue();
               
                component.set("v.AppointmentList",AppointmentList);
                console.log(component.get("v.AppointmentList"));
            }
            else{
                alert('Error');
                console.log(error);
            }
        });

		$A.enqueueAction(aMethod);  
	}
})