({
	initMethodOnLoad : function(component, event, helper) {
		helper.doInitHelper(component, event,helper);
	},
    onChangePatient : function(component, event, helper) {
        alert('hi43434');
        console.log(component.get("v.Patient"));
        component.set("v.recordId",component.get("v.Patient"));
		helper.doDisplayAppointment(component, event,helper);
	}
})