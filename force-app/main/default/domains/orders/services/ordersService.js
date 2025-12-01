import { fetchOrdersData } from '../api/ordersApi.js';

export async function getOrdersData() {
    // Wrap API + apply logic
    return await fetchOrdersData();
}
