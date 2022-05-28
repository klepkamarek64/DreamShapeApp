import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import My_Resource from '@salesforce/resourceUrl/dreamShapeImg';

export default class ContactUsBanner extends NavigationMixin(LightningElement) {
    
    @api navMenuName;
    dreamShapeImg = My_Resource;

    navigateToContactUsPage() {

        this[NavigationMixin.Navigate]({
                type: 'comm__namedPage',
                attributes: {
                    name: 'contact_us__c'
                }
            });
        }
}