global without sharing class DreamShapeLwcController {

    @AuraEnabled
    global static List<NavigationMenuItem> getAllNavigationMenu(String navigationName ) {
      
        
        return [SELECT Label,Type, Target, TargetPrefs, DefaultListViewId, NavigationLinkSetId, Position 
        FROM NavigationMenuItem where status = 'Live' AND NavigationLinkSet.DeveloperName = :navigationName];
    }









    //DO OGARNIĘCIA SEARCH

    @AuraEnabled(cacheable=true)
    global static List<Knowledge__kav> searchArticles(String searchText) {
      
        searchText = String.escapeSingleQuotes(searchText).replaceAll('%20', ' ');
        List<Knowledge__kav> knowledgeArticlesList = new List<Knowledge__kav>();
        searchText = String.escapeSingleQuotes(searchText).replaceAll('[-!.,?<>;:{}@#$%"\'^&*()]', '?');
        searchText = String.escapeSingleQuotes(searchText).replaceAll('["]', '?');
        searchText = buildOrQuery(searchText);

        String q = '';
        q += 'FIND {' + searchText + '} RETURNING Knowledge__kav(Id, Title, urlName WHERE PublishStatus=\'online\' LIMIT 5 )' ;
        System.debug('##final query: ' + q);
        List<List<SObject>> searchList = Search.query(q); //String.escapeSingleQuotes(q)
        List<Knowledge__kav> sobjList = (List<Knowledge__kav>)searchList[0];
        if(!sobjList.isEmpty()) sobjList.remove(0);
        for(Knowledge__kav art : sobjList){
            art.UrlName = Url.getSalesforceBaseUrl().getHost()+ '/'+ art.UrlName;
        }
        knowledgeArticlesList.addAll(sobjList);

        return knowledgeArticlesList;
    }



    global static String buildOrQuery(String keywords) {
        if (String.isBlank(keywords)) return null;
    
    system.debug('\n\n[DEBUG-PKB CONTROLLER] buildOrQuery  \n=========\n'+keywords);
    
        String temp;
         //keywords = keywords.replaceAll('"' ,'\\"');
        List<String> tokens = String.escapeSingleQuotes(keywords).replaceAll('[!.,?<>;:{}@#$%^&*()]', '').split(' ');
        List<String> newTokens = new List<String>();
    
        for (String s : tokens) {
          temp = s.trim();
            newTokens.add(temp + '*');
        }
        tokens = newTokens;
    
        if (tokens.isEmpty()) { 
            system.debug('\n\n[DEBUG-PKB CONTROLLER] buildOrQuery: RESULT:  \n=========\n');
            return null;
        } else if (tokens.size() == 1) {
            system.debug('\n\n[DEBUG-PKB CONTROLLER] buildOrQuery: RESULT:  \n=========\n' + tokens[0]);
            return tokens[0];
        } else {
          system.debug('\n\n[DEBUG-PKB CONTROLLER] buildOrQuery: RESULT:  \n=========\n' + join(tokens, ' OR '));
    
          return join(tokens, ' OR ');
        }
      }
    

      public static String join(List<String> strings, String c) {
        if (strings == null || strings.isEmpty()) return null;
        
        String sep = (String.isBlank(c) ? ',' : c);
        Integer i, size;
        String s = strings[0];
     
        size = strings.size();
        for (i = 1; i < size; i++) {
          s += (sep + strings[i]);      
        }
        return s;    
      }


    
      // version of join method that takes a set of strings
      global static String join(Set<String> strings, String c) {
        return join(new List<String>(strings), c);
      }

}
