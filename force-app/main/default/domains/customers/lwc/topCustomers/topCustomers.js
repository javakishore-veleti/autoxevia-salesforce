import { LightningElement, wire } from 'lwc';
import fetchData from '@salesforce/apex/CustomersService.fetchData';

export default class TopCustomers extends LightningElement {
    @wire(fetchData) records;

    get hasData() {
        return this.records?.data?.length > 0;
    }
}
