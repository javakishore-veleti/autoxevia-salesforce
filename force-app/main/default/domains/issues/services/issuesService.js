import { fetchIssuesData } from '../api/issuesApi.js';

export async function getIssuesData() {
    // Wrap API + apply logic
    return await fetchIssuesData();
}
