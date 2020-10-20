public inherited sharing class CarOptionsController {
    @AuraEnabled(cacheable=true)
    public static Car_Options__c getCarOptions(Id recordId) {
        Car_Options__c options;
        try {
            options = [
                SELECT
                    toLabel(Range__c),
                    toLabel(Exterior_Color__c),
                    toLabel(Interior_Color__c)
                FROM Car_Options__c
                WHERE Car_Configuration__c = :recordId
                WITH SECURITY_ENFORCED
                LIMIT 1
            ];
        } catch (QueryException qe) {
            AuraHandledException ahe = new AuraHandledException(
                qe.getMessage()
            );
            ahe.setMessage(qe.getMessage());
            throw ahe;
        }
        return options;
    }

    @AuraEnabled(cacheable=true)
    public static Car_Options__c getOrderCarOptions(Id recordId) {
        Id configurationId;
        try {
            configurationId = [
                SELECT Id, Configuration__c
                FROM Vehicle_Order__c
                WHERE Id = :recordId
                WITH SECURITY_ENFORCED
                LIMIT 1
            ]
            ?.Configuration__c;
        } catch (QueryException qe) {
            AuraHandledException ahe = new AuraHandledException(
                qe.getMessage()
            );
            ahe.setMessage(qe.getMessage());
            throw ahe;
        }

        return getCarOptions(configurationId);
    }
}
