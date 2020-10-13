({
	initMethodOnLoad : function(component, event, helper)
    {
		helper.doInitHelper(component, event,helper);
	},
     onChangePatient : function(component, event, helper) 
    { 
        component.set("v.app.Patient__c",component.get("v.Patient"));
        console.log(component.get("v.app.Patient__c"));  
        alert('hi');
	},
     onChangePhysician : function(component, event, helper) 
    { 
         component.set("v.app.Physician__c",component.get("v.Physician"));
        console.log(component.get("v.app.Physician__c")); 
        alert('hiii');
	},
    onChangeHospital : function(component, event, helper) 
    { 
        component.set("v.app.Hospital__c",component.get("v.Hospital"));
        console.log(component.get("v.app.Hospital__c")); 
         alert('hreerere');
	},
      AppoitmentSubmit : function(component,event,helper)
    {
      //  var newJSRecord = component.get("v.app");
     //var copy = newJSRecord;
     //delete copy.Id;
       // console.log(JSON.stringify(copy));
        
        //alert(apprecord);
        alert('submit');
		helper.saveAppoitment(component, event,helper);
	}
})