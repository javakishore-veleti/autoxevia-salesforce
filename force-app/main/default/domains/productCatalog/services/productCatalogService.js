import { fetchProductCatalogData } from '../api/productCatalogApi.js';

// Business logic layer for productCatalog domain

export async function getProductCatalogData() {
    return await fetchProductCatalogData();
}
