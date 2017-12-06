trigger ZV_GameTrigger on ZV_Game__c (after insert) {
    fflib_SObjectDomain.triggerHandler(ZV_GameTriggerHandler.class);
}