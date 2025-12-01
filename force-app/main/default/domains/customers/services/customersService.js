import { fetchCustomersData } from '../api/customersApi.js';

// Business logic layer for customers domain

export async function getCustomersData() {
    return await fetchCustomersData();
}
