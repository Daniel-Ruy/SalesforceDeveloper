public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer numberOfContacts, String lastNamePrefix){
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i < numberOfContacts; i++){
            Contact contact = new Contact();
            contact.LastName = lastNamePrefix;
            contact.FirstName = 'Test ' + i;
            contact.Email = 'email' + i + '@test.com';
            contact.Phone = '1234567890';
            contacts.add(contact);
        }
        return contacts;
    }

}