public with sharing class XeviaSettingsController {
    @AuraEnabled(cacheable=true)
    public static String getSiteName() {
        XeviaSettings__mdt settings = [
            SELECT SiteName__c
            FROM XeviaSettings__mdt
            LIMIT 1
        ];
        return settings.SiteName__c;
    }
}