({
	doInitHelper : function(component,event,helper) {
		var aMethod = component.get("c.getPatPhyHospInfo");
       
        aMethod.setCallback(this,function(retVal){
            alert('enter');
            var currentState = retVal.getState(); //SUCCESS or ERROR
            alert('hi');
            if(currentState == 'SUCCESS'){
                alert('success');
                var result = retVal.getReturnValue();
                result.sobjectType ='Appoitment__c';
                
               var patList=result.patient;
                var phyList=result.physician;
                var hosList=result.acc;
               
               component.set("v.patList",patList);
               
                component.set("v.phyList",phyList);
                component.set("v.hosList",hosList);
                console.log(component.get("v.patList"));
                console.log(component.get("v.phyList"));
                console.log(component.get("v.hosList"));
            }
            else{
                alert('Error');
            }
        });

		$A.enqueueAction(aMethod);  
	},
    saveAppoitment : function(component,event,helper) {
        console.log(component.get("v.app.Name"));
        console.log(component.get("v.app.Patient__c"));
        console.log(component.get("v.app.Physician__c"));
         console.log(component.get("v.app.Hospital__c"));
        
      
        var bMethod=component.get("c.createAppoitment");
     
        bMethod.setParams(
            {
            'appt':component.get("v.app.Name"),
            'patId':component.get("v.app.Patient__c"),
            'physId':component.get("v.app.Physician__c"),
            'hospId':component.get("v.app.Hospital__c") 
            });
         bMethod.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                alert('Record is Created Successfully');
            } 
            else if (state === "INCOMPLETE") {
                console.error("INCOMPLETE");
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.error("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.error("Unknown error");
                }
            }
        });       
        $A.enqueueAction(bMethod);
    }

    
})