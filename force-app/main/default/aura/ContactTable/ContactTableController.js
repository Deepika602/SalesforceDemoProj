({
	doInit : function(component, event, helper) {
        var columns = [
            {label:'Contact Id', fieldName:'Id', type:'text'},
            {label:'Contact Name', fieldName:'Name', type:'text'},
            {label:'Contact Email', fieldName:'Email', type:'email'}
        ];
        component.set("v.headersList",columns);
        
		var aMethod = component.get("c.getContactRecords");
        
        aMethod.setCallback(this,function(retVal){
            alert('enter');
            var currentState = retVal.getState(); //SUCCESS or ERROR
            alert('hi');
            if(currentState == 'SUCCESS'){
                alert('success');
                var conList = retVal.getReturnValue();
                component.set("v.conList",conList);
                console.log(component.get("v.conList"));
                console.log(conList.length);
               var conTempList = [];
                for(var i=0;i<5;i++){
                    conTempList.push(conList[i]);     
                }
                component.set("v.conListTemp",conTempList);
                console.log(conTempList);
                   
            }
            else{
                alert('Error');
            }
        });

		$A.enqueueAction(aMethod);  
	
	},
    btnClicked : function(component, event, helper) {
        alert('hi');
      console.log(component.get("v.selectedContacts"));
    },
     onRowSelected : function(component, event, helper) {
         var selectedcons=event.getParam('selectedRows');
         component.set("v.selectedContacts",selectedcons);
        console.log(component.get("v.selectedContacts"));
    },
    onChangePageSize: function(component, event, helper) 
    {
        var conList = component.get("v.conList");
        var pNumber = component.get("v.pageNumber");
        var pSize = component.get("v.pageSize");
        var conTempList = [];
        var firstVal = 1;
        var limitVal =pSize;
        for(var i=firstVal;i<=limitVal;i++){
            conTempList.push(conList[i]);     
        }
        component.set("v.conListTemp",conTempList);
        console.log(conTempList);
    },
    NextClicked: function(component, event, helper) 
    {
        alert('Method');
		var conList = component.get("v.conList");
        var pNumber = component.get("v.pageNumber");
        var pSize = component.get("v.pageSize");
        var conTempList = [];
        var firstVal = pNumber*pSize;
        var limitVal =pNumber*pSize +pSize;
        for(var i=firstVal;i<limitVal;i++){
            conTempList.push(conList[i]);     
        }
        component.set("v.conListTemp",conTempList);
        console.log(conTempList);
        pNumber++;
    }
})