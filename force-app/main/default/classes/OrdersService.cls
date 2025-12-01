public with sharing class OrdersService {

    @AuraEnabled(cacheable=true)
    public static List<String> getOrdersData() {
        return OrdersDAO.fetchOrdersData();
    }
}
