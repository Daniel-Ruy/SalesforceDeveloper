@RestResource(urlMapping='/AccountManager/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        String id = RestContext.request.params.get('id');

        // Checa se o id foi passado
        if(String.isBlank(id)) {
            RestContext.response.statusCode = 400;
            RestContext.response.responseBody = Blob.valueOf('Missing ID');
            return null;
        }

        try {
            // Incluindo LastName na subquery para evitar SObjectException
            Account acc = [
                SELECT Id, Name, (SELECT Id, LastName FROM Contacts)
                FROM Account
                WHERE Id = :id
            ];
            return acc;
        } catch(QueryException e) {
            RestContext.response.statusCode = 404;
            RestContext.response.responseBody = Blob.valueOf('Account not found');
            return null;
        } catch(Exception e) {
            RestContext.response.statusCode = 500;
            RestContext.response.responseBody = Blob.valueOf('Unexpected error: ' + e.getMessage());
            return null;
        }
    }
}
