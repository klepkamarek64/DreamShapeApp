import { LightningElement, api } from 'lwc';
import getKnowledgeArticleJS from '@salesforce/apex/AllArticlesControler.getKnowledgeArticleFromUrl';

export default class Articles extends LightningElement {

     @api
     allArticles;
     articleBody;

    connectedCallback() {
      getKnowledgeArticleJS ({urlParam : window.location.href})
        .then(result => {    
            this.articleBody = result.Article__c;
    
        })
        .catch(error => {  
            console.log('errror: ' + JSON.stringify(error));
        
        });
      
  }

}