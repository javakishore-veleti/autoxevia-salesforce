public with sharing class CustomersService {

    @AuraEnabled(cacheable=true)
    public static List<String> getCustomersData() {
        return CustomersDAO.fetchCustomersData();
    }
}
