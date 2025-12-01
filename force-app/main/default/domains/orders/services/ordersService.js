import { fetchOrdersData } from '../api/ordersApi.js';

// Business logic layer for orders domain

export async function getOrdersData() {
    return await fetchOrdersData();
}
