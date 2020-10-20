public with sharing class InventoryController {
    @AuraEnabled(cacheable=true)
    public static Object getVehicles() {
        Vehicle__c[] vehicles;
        try {
            vehicles = [
                SELECT
                    Id,
                    Exterior_Color__c,
                    Interior_Color__c,
                    Model__c,
                    Status__c,
                    Year__c,
                    Package__c,
                    VIN__C
                FROM Vehicle__c
                WITH SECURITY_ENFORCED
                LIMIT 20
            ];
        } catch (QueryException qe) {
            AuraHandledException ahe = new AuraHandledException(
                qe.getMessage()
            );
            ahe.setMessage(qe.getMessage());
            throw ahe;
        }
        return vehicles;
    }
}
