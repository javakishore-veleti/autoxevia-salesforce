public with sharing class AnalyticsService {
    // TODO: Add business logic for domain: analytics

    @AuraEnabled(cacheable=true)
    public static List<SObject> fetchData() {
        return AnalyticsDAO.getRecords();
    }
}
