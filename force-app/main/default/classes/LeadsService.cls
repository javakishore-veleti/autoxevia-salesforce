public with sharing class LeadsService {

    @AuraEnabled(cacheable=true)
    public static List<String> getLeadsData() {
        return LeadsDAO.fetchLeadsData();
    }
}
