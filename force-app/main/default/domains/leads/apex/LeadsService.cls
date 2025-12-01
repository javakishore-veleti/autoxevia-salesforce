public with sharing class LeadsService {
    // TODO: Add business logic for domain: leads

    @AuraEnabled(cacheable=true)
    public static List<SObject> fetchData() {
        return LeadsDAO.getRecords();
    }
}
