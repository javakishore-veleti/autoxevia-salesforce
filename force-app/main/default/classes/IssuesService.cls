public with sharing class IssuesService {

    @AuraEnabled(cacheable=true)
    public static List<String> getIssuesData() {
        return IssuesDAO.fetchIssuesData();
    }
}
