public class AccountProcessor {
    @future
    public static List<Account>  accounts (List<Id> accIds){
        List<Account> accNumber = [SELECT Count(Id) FROM Account WHERE Id IN :accIds];

        return;

    }
}