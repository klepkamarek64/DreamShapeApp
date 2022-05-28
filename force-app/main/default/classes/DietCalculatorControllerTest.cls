@isTest
public with sharing class DietCalculatorControllerTest {

    @isTest
    public static void calculateDietForMan() {
        Decimal result = DietCalculatorController.calculateCaloricRequirement(100, 200, 50, 'Man', 'Reduce weight', 'Low activity');
        System.assertEquals(2045, result);    
        System.assert(2045 == result);
    }

    @isTest
    public static void calculateDietForWoman() {
        Decimal result = DietCalculatorController.calculateCaloricRequirement(50, 150, 30, 'Woman', 'Gain weight', 'Average activity');
        System.assertEquals(2008, result);
    }

    @isTest
    public static void calculateMakroTest(){
        List<Decimal> resultList = DietCalculatorController.calculateMakroRequirement(2008, 50);
        System.assertEquals(resultList.get(0), 100);
        System.assertEquals(resultList.get(1), 67);
        System.assertEquals(resultList.get(2), 251);

    }

}
