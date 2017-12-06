public class ZV_PlayerCollections {
    public List<ZV_Player__c> fullPlayerList {get; private set;}
    public List<ZV_Player__c> newPlayerList {get; private set;}
    
    public ZV_PlayerCollections(List<ZV_Player__c> fullPlayerList, List<ZV_Player__c> newPlayerList) {
    	this.fullPlayerList = fullPlayerList;
    	this.newPlayerList = newPlayerList;
    }
}