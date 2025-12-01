public with sharing class IssuesService {
    // TODO: Add business logic for domain: issues

    @AuraEnabled(cacheable=true)
    public static List<SObject> fetchData() {
        return IssuesDAO.getRecords();
    }
}
