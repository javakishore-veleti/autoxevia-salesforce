public with sharing class AnalyticsService {

    @AuraEnabled(cacheable=true)
    public static List<String> getAnalyticsData() {
        return AnalyticsDAO.fetchAnalyticsData();
    }
}
