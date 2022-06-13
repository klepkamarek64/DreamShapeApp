public without sharing class AllArticlesControler {

    @AuraEnabled
    public static Map<String, Knowledge__kav> getAllKnowledgeArticles() {

        Map<String, Knowledge__Kav> artMap = new Map<String, Knowledge__Kav>();
        
        List<Knowledge__kav> artList = new List<Knowledge__kav>([SELECT Title, Article__c, UrlName FROM Knowledge__kav]);
        for(Knowledge__Kav k : artList) {
            artMap.put(k.Title, k);
        }
        return artMap;
    }

    
    @AuraEnabled
    public static Knowledge__kav getKnowledgeArticleFromUrl(String urlParam) {

        String urlName = urlParam.substring(urlParam.IndexOf('?') + 1, urlParam.length());

        List<Knowledge__kav> artList = new List<Knowledge__kav>([SELECT Title, Article__c FROM Knowledge__kav WHERE UrlName = :urlName]);
        if(artList.size() > 0){
            return artList[0];
        }else {
            return null;
        }

    }

}
