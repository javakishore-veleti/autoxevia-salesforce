public with sharing class ProductCatalogService {

    @AuraEnabled(cacheable=true)
    public static List<String> getProductCatalogData() {
        return ProductCatalogDAO.fetchProductCatalogData();
    }
}
