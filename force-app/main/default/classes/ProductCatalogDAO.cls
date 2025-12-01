public with sharing class ProductCatalogDAO {

    public static List<String> fetchProductCatalogData() {
        // TEMP FAKE DATA
        return new List<String>{
            'ProductCatalog Item A',
            'ProductCatalog Item B',
            'ProductCatalog Item C'
        };
    }
}
