public class AccountProcessor {
    @future
    public static countContacts(List<Id> accIds) {
        List<Account> accNumber = [SELECT Count(Id) FROM Account WHERE Id IN :accIds];

        for(Account acc : accNumber) {
            acc.Number_of_Contacts__c = returnCount(accNumber);
        }
        update accNumber;
    };
        })
    }
}
