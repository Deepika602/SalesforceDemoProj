public class CountEvenNumbersList {
    public CountEvenNumbersList()
    {
    List<Integer> ls=new List<Integer>();
    for(Integer i=1;i<=10;i++)
    {
        ls.add(i);
    }
    system.debug(ls);
    Integer sum=0;
    for(Integer i=0;i<ls.size();i++)
    {
        
        if(Math.mod(i, 2)==0)
        {
            sum=sum+ls[i];
        }
        
    }
    system.debug(sum);
    }
}