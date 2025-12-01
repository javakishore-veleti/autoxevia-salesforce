import { LightningElement, wire } from 'lwc';
import fetchData from '@salesforce/apex/AnalyticsService.fetchData';

export default class TopAnalytics extends LightningElement {
    @wire(fetchData) records;

    get hasData() {
        return this.records?.data?.length > 0;
    }
}
