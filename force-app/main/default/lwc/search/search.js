import { LightningElement } from 'lwc';
import searchArticles from '@salesforce/apex/DreamShapeLwcController.searchArticles';

export default class Search extends LightningElement {
    
error;
data;

    changeHandler(event) {
        console.log('###change');
        console.log('###change : ' + event.target.value);
        searchArticles({keyword: event.target.value})
        .then((data,error) => {
            if (data) {
                this.error = undefined;
                this.data=data;
                console.log(JSON.stringify(data))
            } else if (error) {
                this.error = error;
                console.log(JSON.stringify(error));

            }
        });
    }



    

}