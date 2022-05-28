import { LightningElement } from 'lwc';

export default class ContactUsForm extends LightningElement {

    get options() {
        return [
            { label: 'Cooperation', value: 'cooperation' },
            { label: 'Business offer', value: 'new' },
            { label: 'Other', value: 'other' },
        ];
    }

    name;
    email;
    phone;
    subject;
    description;
    showButton;

    validateIputs(event) {
        this.clickedButtonLabel = event.target.label;

        var inp=this.template.querySelectorAll("lightning-input");

        inp.forEach(function(element) {
            
            if(element.name == "name") {
                this.name = element.value;
            }
            else if(element.name == "email") {
                this.email = element.value;
            }
            else if(element.name == "phone") {
                this.phone= element.value;
            }
            else if(element.name == "subject") {
                this.subject = element.value;
            }
            else if(element.name == "description") {
                this.subject = element.value;
            }
        },this);

        if(this.name != '' && this.email != '' && this.phone != '') {

            this.showButton = true;
        }else{
            this.showButton = false;
        }
    }

    handleSubjectChange(event) {
        this.value = event.detail.value;
    }

    showToast() {
        this.template.querySelector('c-custom-toast').showToast('success', 'Thank you for your message !');
    }

}