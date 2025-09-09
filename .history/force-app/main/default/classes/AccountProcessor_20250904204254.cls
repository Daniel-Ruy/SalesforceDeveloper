public class AccountProcessor {
    @future
    public static void accounts(List<Id> accIds) {
        List<Account> accNumber = [SELECT Count(Id) FROM Account WHERE Id IN :accIds];

        // return removido, @future não retorna nada
    }
}
