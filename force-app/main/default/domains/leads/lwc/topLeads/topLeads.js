import { LightningElement, wire } from 'lwc';
import fetchData from '@salesforce/apex/LeadsService.fetchData';

export default class TopLeads extends LightningElement {
    @wire(fetchData) records;

    get hasData() {
        return this.records?.data?.length > 0;
    }
}
