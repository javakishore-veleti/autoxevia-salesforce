import { fetchLeadsData } from '../api/leadsApi.js';

// Business logic layer for leads domain

export async function getLeadsData() {
    return await fetchLeadsData();
}
