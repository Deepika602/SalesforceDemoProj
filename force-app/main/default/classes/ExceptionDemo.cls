public class ExceptionDemo {
    
   public ExceptionDemo()
   {
       Try
       {
           Account ac=[SELECT Id,Name FROM Account Limit 1];
           //system.debug(ac.Type);
           String name='deepika';
           if(name=='deepika')
           {
               customException c=new customException('print error');
               throw c;
           }
       }
       catch(QueryException ex)
       {
           System.debug(ex.getMessage());
           System.debug(ex.getLineNumber());
           System.debug(ex.getStackTraceString());
       }
       catch(sObjectException ex)
       {
           System.debug(ex.getMessage());
           System.debug(ex.getLineNumber());
           System.debug(ex.getStackTraceString());
       }
       catch(ListException ex)
       {
           System.debug(ex.getMessage());
           System.debug(ex.getLineNumber());
           System.debug(ex.getStackTraceString());
       }
       catch(NullPointerException ex)
       {
           System.debug(ex.getMessage());
           System.debug(ex.getLineNumber());
           System.debug(ex.getStackTraceString());
       }
       catch(Exception ex)
       {
           System.debug(ex.getMessage());
           System.debug(ex.getLineNumber());
           System.debug(ex.getStackTraceString());
       }
   }
    
    public class customException extends Exception
    {
        public void me()
        {
            system.debug('message');
        }
    }

}