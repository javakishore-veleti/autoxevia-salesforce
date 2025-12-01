public with sharing class OrdersService {
    // TODO: Add business logic for domain: orders

    @AuraEnabled(cacheable=true)
    public static List<SObject> fetchData() {
        return OrdersDAO.getRecords();
    }
}
