import { fetchAnalyticsData } from '../api/analyticsApi.js';

export async function getAnalyticsData() {
    // Wrap API + apply logic
    return await fetchAnalyticsData();
}
