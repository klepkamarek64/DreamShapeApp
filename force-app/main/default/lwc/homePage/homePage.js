import { LightningElement, api } from 'lwc';
import getAllArticlesJS from '@salesforce/apex/AllArticlesControler.getAllKnowledgeArticles';

export default class HomePage extends LightningElement {

  @api allArticles;

  connectedCallback() {
    getAllArticlesJS()
      .then(result => {
          this.allArticles = result;             
      })
      .catch(error => {          
      });
    
}



}