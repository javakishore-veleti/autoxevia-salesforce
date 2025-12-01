public with sharing class CustomersService {
    // TODO: Add business logic for domain: customers

    @AuraEnabled(cacheable=true)
    public static List<SObject> fetchData() {
        return CustomersDAO.getRecords();
    }
}
