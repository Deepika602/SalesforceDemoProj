public class VfPageConceptsDemoController {

    public void displayMessage() {
         //Apexpages.severity.FATAL
        //Apexpages.severity.ERROR
        //Apexpages.severity.WARNING
        //Apexpages.severity.FATAL
        //Apexpages.severity.INFO
        //Apexpages.severity.CONFIRM
        Apexpages.message message = new Apexpages.message(Apexpages.severity.ERROR,'Please verify your data before proceeding.');
        ApexPages.addMessage(message);
    
    }


    public PageReference navigateToAccountView() {
    PageReference ref=new PageReference('/0013t00001Zpn8I');
    return ref;
        
    }


    public PageReference navigateToAccountView1() {
        return page.firstVFPage;
    }


    public PageReference navigateToAccountView2()
     {
        string acid='0013t00001Zpn8I';
        PageReference ref=page.AccountView;
        ref.getParameters().put('Id',acid);
        ref.getParameters().put('aName','ABCAccount');
        ref.setRedirect(true);
        
        return ref;
            
    }
    
    @RemoteAction
    public static string remoteActionCall(string name1,string name2){
        
        return name1+'~'+name2;
    }

}