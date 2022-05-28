@isTest
public with sharing class AllArticlesControlerTest {

    @isTest
    public static void getKnowledgeArticle() {
        Knowledge__kav art = new Knowledge__kav(Title ='TestArt', Article__c ='Test Article', UrlName = 'Article01');

        insert art;

        Map<String, Knowledge__kav> resultMap = new Map<String, Knowledge__kav>();
        resultMap =  AllArticlesControler.getAllKnowledgeArticles();
        String title = 'TestArt';
        System.assertEquals(art, resultMap.get(title));

    }

    @isTest
    public static void getKnowledgeArticleFromUrl() {

        Knowledge__kav article1 = new Knowledge__kav(Title ='TestArt', Article__c ='Test Article', UrlName = 'keto-diett');
        insert article1;

        String url ='keto-diett';
        Knowledge__kav result = AllArticlesControler.getKnowledgeArticleFromUrl(url);        
 
        System.assertEquals(article1.Article__c, result.Article__c);

    }

}
