public with sharing class DietCalculatorController {
    
    @AuraEnabled
    public static Decimal calculateCaloricRequirement(Integer weightCalc, Integer heightCalc, Integer ageCalc,
     String genderCalc, String achieveCalc, String activityCalc) {

        Decimal result =0.0;

        Decimal activityLevel = getActivityLevel().get(activityCalc);
        if (genderCalc == 'Man') {

                Decimal ppm = (10 * weightCalc) + (6.25 * heightCalc) - (5 * ageCalc) + 5;

                Decimal ppmWithActivity = ppm * activityLevel;
                result = ppmWithActivity * getAchieveGoal().get(achieveCalc);

        } else if (genderCalc =='Woman') {

                Decimal ppm = (10 * weightCalc) + (6.25 * heightCalc) - (5 * ageCalc) - 161;
                Decimal ppmWithActivity = ppm * activityLevel;
                result = ppmWithActivity * getAchieveGoal().get(achieveCalc);
        } 

        return result.round();       
}

    @AuraEnabled
    public static List<Decimal> calculateMakroRequirement(Decimal calculateCaloricRequirement, Decimal weight) {

        List<Decimal> calculeteMakro = new List<Decimal>();

        Decimal proteinsKCAL = (weight * 2) * 4;
        Decimal fatsKCAL = 0.3 * calculateCaloricRequirement;
        Decimal carbsKCAL = calculateCaloricRequirement - (proteinsKCAL + fatsKCAL);

        Decimal proteinsGR = proteinsKCAL / 4;
        Decimal fatsGR = fatsKCAL / 9;
        Decimal carbsGR = carbsKCAL / 4; 

        calculeteMakro.add(proteinsGR.round());
        calculeteMakro.add(fatsGR.round());
        calculeteMakro.add(carbsGR.round());

        return calculeteMakro;
    }
    
    private static Map<String, Decimal> getActivityLevel() {

        Map<String,Decimal> activityLevelMap = new Map<String,Decimal>();
        
        activityLevelMap.put('Low activity', 1.2);
        activityLevelMap.put('Moderate activity', 1.375);
        activityLevelMap.put('Average activity', 1.55);
        activityLevelMap.put('High activity', 1.715);
        activityLevelMap.put('Very high activity', 1.9);

        return activityLevelMap;
    }

    private static Map<String, Decimal> getAchieveGoal() {
        
        Map<String, Decimal> achieveGoalMap = new Map<String,Decimal>();

        achieveGoalMap.put('Reduce weight', 0.85);
        achieveGoalMap.put('Keep weight', 1);
        achieveGoalMap.put('Gain weight', 1.15);

        return achieveGoalMap;
    }

}


