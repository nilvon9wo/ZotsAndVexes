trigger ZV_BoardTrigger on ZV_Board__c (after insert) {
    fflib_SObjectDomain.triggerHandler(ZV_BoardTriggerHandler.class);
}