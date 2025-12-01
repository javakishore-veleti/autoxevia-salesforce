import { LightningElement, wire } from 'lwc';
import getSiteName from '@salesforce/apex/XeviaSettingsController.getSiteName';

export default class XevHeader extends LightningElement {
    siteName;

    @wire(getSiteName)
    wiredSettings({ data }) {
        if (data) {
            this.siteName = data;
        }
    }
}
