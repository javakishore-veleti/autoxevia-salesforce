import { fetchAnalyticsData } from '../api/analyticsApi.js';

// Business logic layer for analytics domain

export async function getAnalyticsData() {
    return await fetchAnalyticsData();
}
