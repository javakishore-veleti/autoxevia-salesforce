import { LightningElement, wire } from 'lwc';
import fetchData from '@salesforce/apex/IssuesService.fetchData';

export default class TopIssues extends LightningElement {
    @wire(fetchData) records;

    get hasData() {
        return this.records?.data?.length > 0;
    }
}
