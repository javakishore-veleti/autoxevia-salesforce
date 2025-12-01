import { LightningElement } from 'lwc';

export default class AutoXeviaBanner extends LightningElement {
    handleClick() {
        window.location.href = "/my-xevia-journey";
    }
}
