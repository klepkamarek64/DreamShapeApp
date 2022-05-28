import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getMenus from '@salesforce/apex/DreamShapeLwcController.getAllNavigationMenu';


export default class HorizontalMenu extends NavigationMixin(LightningElement) {

    @api allMenus;
    @api navMenuName;
    
    connectedCallback() {
        
      getMenus({navigationName : this.navMenuName})
          .then(result => {
              this.allMenus = result;             
          })
          .catch(error => {
              console.log('Error : ' + JSON.stringify(error));
              
          });

        }

        navigateToPage() {

            var pageName = event.target.dataset.name;

            pageName = pageName.replace('-', '_');
            pageName = pageName + '__c';
            pageName = pageName.replace('/', '');

            this[NavigationMixin.Navigate]({
                type: 'comm__namedPage',
                attributes: {
                    name: pageName
                }
            });
        }

        navigateToHomePage() {
            
            this[NavigationMixin.Navigate]({
                type: 'comm__namedPage',
                attributes: {
                    name: 'Home'
                }
            });
        }


}