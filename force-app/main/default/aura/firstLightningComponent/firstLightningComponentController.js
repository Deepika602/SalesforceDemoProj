({  
	initMethodOnLoad : function(component, event, helper) { 
        component.set("v.accName","Controller acc");   
        component.set("v.accName",component.get("v.rating"));     
	},
    onChangeRating : function(component, event, helper) { 
        component.set("v.accName",component.get("v.rating"));       
	},
    
    submitButtonClicked : function(component, event, helper) {
        var accN=component.get("v.accName");
        component.set("v.accName","Controller acc");
        alert(accN);
		helper.submitButtonClickedHelper(component, event, helper);
	},
    cancelButtonClicked : function(component, event, helper) {
		
	},
})