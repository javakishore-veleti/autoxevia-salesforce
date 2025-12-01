import { fetchIssuesData } from '../api/issuesApi.js';

// Business logic layer for issues domain

export async function getIssuesData() {
    return await fetchIssuesData();
}
