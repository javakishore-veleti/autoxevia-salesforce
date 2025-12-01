import { fetchLeadsData } from '../api/leadsApi.js';

export async function getLeadsData() {
    // Wrap API + apply logic
    return await fetchLeadsData();
}
