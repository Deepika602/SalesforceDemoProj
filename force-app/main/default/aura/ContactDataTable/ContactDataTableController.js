({  
    doInit: function(component, event, helper) 
    {
         var columns = [
            {label:'Contact Id', fieldName:'Id', type:'text'},
            {label:'Contact Name', fieldName:'Name', type:'text'},
            {label:'Contact Email', fieldName:'Email', type:'email'}
        ];
        component.set("v.headersList",columns);
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value"); 
        helper.getContactList(component, pageNumber, pageSize);
    },
     
    handleNext: function(component, event, helper) 
    {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber++;
        helper.getContactList(component, pageNumber, pageSize);
    },
     
    handlePrev: function(component, event, helper) 
    {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber--;
        helper.getContactList(component, pageNumber, pageSize);
    },
     
    onChangePageSize: function(component, event, helper) 
    {
        var page = 1;
        var pageSize = component.find("pageSize").get("v.value");
        helper.getContactList(component, page, pageSize);
    }
})