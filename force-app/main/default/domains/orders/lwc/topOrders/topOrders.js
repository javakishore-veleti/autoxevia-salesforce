import { LightningElement, wire } from 'lwc';
import fetchData from '@salesforce/apex/OrdersService.fetchData';

export default class TopOrders extends LightningElement {
    @wire(fetchData) records;

    get hasData() {
        return this.records?.data?.length > 0;
    }
}
