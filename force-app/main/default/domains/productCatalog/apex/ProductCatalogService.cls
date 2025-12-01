public with sharing class ProductCatalogService {
    // TODO: Add business logic for domain: productCatalog

    @AuraEnabled(cacheable=true)
    public static List<SObject> fetchData() {
        return ProductCatalogDAO.getRecords();
    }
}
