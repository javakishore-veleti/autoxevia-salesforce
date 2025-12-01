import { fetchProductCatalogData } from '../api/productCatalogApi.js';

export async function getProductCatalogData() {
    // Wrap API + apply logic
    return await fetchProductCatalogData();
}
