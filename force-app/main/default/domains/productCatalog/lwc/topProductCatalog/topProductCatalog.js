import { LightningElement, wire } from 'lwc';
import fetchData from '@salesforce/apex/ProductCatalogService.fetchData';

export default class TopProductCatalog extends LightningElement {
    @wire(fetchData) records;

    get hasData() {
        return this.records?.data?.length > 0;
    }
}
