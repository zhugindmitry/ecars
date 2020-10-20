@isTest
public class CarOptionsController_Tests {
    @testSetup
    static void setup() {
        Car__c car = new Car__c();
        insert car;

        Car_Configuration__c configuration = new Car_Configuration__c(
            Car__c = car.Id
        );
        insert configuration;

        Car_Options__c options = new Car_Options__c(
            Car_Configuration__c = configuration.Id,
            Range__c = 'Long_Range',
            Exterior_Color__c = 'VIP_Black',
            Interior_Color__c = 'Vegan_Tan'
        );

        insert options;

        Vehicle_Order__c order = new Vehicle_Order__c(
            Configuration__c = configuration.Id
        );
        insert order;
    }

    @isTest
    static void testGetCarOptionsPositive() {
        Car_Configuration__c testCarConfiguration = [
            SELECT Id
            FROM Car_Configuration__c
        ];

        Test.startTest();
        Car_Options__c options = CarOptionsController.getCarOptions(
            testCarConfiguration.Id
        );
        Test.stopTest();

        System.assertEquals(
            options.Range__c,
            'Long Range',
            'Expected Range to equal Long Range'
        );
        System.assertEquals(
            options.Exterior_Color__c,
            'VIP Black',
            'Expected Exterior Color to be VIP Black'
        );
        System.assertEquals(
            options.Interior_Color__c,
            'Vegan Tan',
            'Expected Interior Color to be Vegan Tan'
        );
    }

    @isTest
    static void testGetCarOptionsNegativeNoPermissionToObj() {
        Car_Configuration__c testCarConfiguration = [
            SELECT Id
            FROM Car_Configuration__c
            LIMIT 1
        ];
        User minAccess = TestFactory.createMinAccessUser(true);
        Boolean didCatchProperException = false;
        Test.startTest();
        System.runAs(minAccess) {
            try {
                Car_Options__c options = CarOptionsController.getCarOptions(
                    testCarConfiguration.Id
                );
            } catch (AuraHandledException ahe) {
                if (
                    ahe.getMessage()
                        .containsIgnoreCase(
                            'insufficient permissions: secure query included'
                        )
                ) {
                    didCatchProperException = true;
                }
            }
        }

        Test.stopTest();
        System.assert(
            didCatchProperException,
            'Expected to have caught a query exception detailing insufficient permissions'
        );
    }

    @isTest
    static void testGetOrderCarOptionsPositive() {
        Vehicle_Order__c order = [SELECT Id FROM Vehicle_Order__c LIMIT 1];
        Test.startTest();
        Car_Options__c options = CarOptionsController.getOrderCarOptions(
            order.Id
        );
        Test.stopTest();

        System.assertEquals(
            options.Range__c,
            'Long Range',
            'Expected Range to equal Long Range'
        );
        System.assertEquals(
            options.Exterior_Color__c,
            'VIP Black',
            'Expected Exterior Color to be VIP Black'
        );
        System.assertEquals(
            options.Interior_Color__c,
            'Vegan Tan',
            'Expected Interior Color to be Vegan Tan'
        );
    }

    @isTest
    static void testGetOrderCarOptionsNegativeNoPermissionToObj() {
        Vehicle_Order__c order = [SELECT Id FROM Vehicle_Order__c LIMIT 1];
        User minAccess = TestFactory.createMinAccessUser(true);
        Boolean didCatchProperException = false;
        Test.startTest();
        System.runAs(minAccess) {
            try {
                Car_Options__c options = CarOptionsController.getOrderCarOptions(
                    order.Id
                );
            } catch (AuraHandledException ahe) {
                if (
                    ahe.getMessage()
                        .containsIgnoreCase(
                            'insufficient permissions: secure query included'
                        )
                ) {
                    didCatchProperException = true;
                }
            }
        }

        Test.stopTest();
        System.assert(
            didCatchProperException,
            'Expected to have caught a query exception detailing insufficient permissions'
        );
    }
}
