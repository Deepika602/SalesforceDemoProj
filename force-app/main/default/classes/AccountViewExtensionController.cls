public class AccountViewExtensionController {
   
   public Account acc;
   public boolean isEdit { get; set;}
   public boolean isView { get; set;
   }

    public AccountViewExtensionController(ApexPages.StandardController controller) {
    acc=(Account)controller.getRecord();
     isEdit=false;
     isView=true;
    }
    
    public void editClicked()
    {
    isView=false;
    isEdit=true;
    
    }

}