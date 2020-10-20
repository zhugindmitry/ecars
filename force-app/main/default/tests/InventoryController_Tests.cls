@isTest
public class InventoryController_Tests {
    @testSetup
    static void setup() {
        List<Vehicle__c> vehicles = new List<Vehicle__c>();

        for (Integer i = 0; i < 25; i++) {
            vehicles.add(
                new Vehicle__c(
                    Exterior_Color__c = 'Pulsar_Red',
                    Interior_Color__c = 'Vegan_Tan',
                    Model__c = 'Model One',
                    Status__c = 'Available',
                    Year__c = '2020',
                    Package__c = 'Standard',
                    VIN__C = 'ABCD'
                )
            );
        }

        insert vehicles;
    }

    @isTest
    static void testGetVehicles() {
        Test.startTest();
        List<Vehicle__c> vehicles = (List<Vehicle__c>) InventoryController.getVehicles();
        Test.stopTest();

        System.assertEquals(vehicles.size(), 20, 'Query hardcodes a limit of 20, expected to get 20 results');
        Vehicle__c vehicle = vehicles.get(0);

        System.assertEquals(vehicle.Exterior_Color__c, 'Pulsar_Red', 'Expected exterior color to be pulsar red');
        System.assertEquals(vehicle.Interior_Color__c, 'Vegan_Tan', 'Expected interior color to be vegan tan');
        System.assertEquals(vehicle.Model__c, 'Model One', 'Expected model to be Model One');
        System.assertEquals(vehicle.Status__c, 'Available', 'Expected the status to be Available');
        System.assertEquals(vehicle.Year__c, '2020', 'Expected year to be 2020');
        System.assertEquals(vehicle.Package__c, 'Standard', 'Expected the package to be Standard');
        System.assertEquals(vehicle.VIN__c, 'ABCD', 'Expected VIN to be ABCD');
    }
}
