import { fetchCustomersData } from '../api/customersApi.js';

export async function getCustomersData() {
    // Wrap API + apply logic
    return await fetchCustomersData();
}
