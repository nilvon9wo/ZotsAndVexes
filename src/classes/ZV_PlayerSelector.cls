public class ZV_PlayerSelector extends fflib_SObjectSelector {
	ZV_SetHelper setHelper;
	
	public ZV_PlayerSelector(ZV_SetHelper setHelper){
		this.setHelper = setHelper;
	}

	public ZV_PlayerSelector(){
		this(new ZV_SetHelper());
	}
	 
	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
			ZV_Player__c.Id, 
			ZV_Player__c.IconName__c,
			ZV_Player__c.IconVariant__c,
			ZV_Player__c.Nickname__c,
			ZV_Player__c.RecordTypeId,
			ZV_Player__c.StrategyClassName__c,
			ZV_Player__c.User__c 
		};
	}

	public Schema.SObjectType getSObjectType() {
		return ZV_Player__c.sObjectType;
	} 

	public List<ZV_Player__c> selectById(Set<Id> idSet) {
		return (List<ZV_Player__c>) selectSObjectsById(idSet);
	}

	public List<ZV_Player__c> selectByUserIdOrStrategyName(Set<Id> humanPlayerUserIdSet, Set<String> robotStrategySet) {
		return (List<ZV_Player__c>) Database.query(
			newQueryFactory()
				.setCondition('User__c IN :humanPlayerUserIdSet OR StrategyClassName__c IN :robotStrategySet')
				.toSOQL()		
		);
	}
	
	public List<ZV_Player__c> selectFor(List<ZV_GamePlayer__c> gamePlayerList) {
		return this.selectById(
			this.setHelper.createIdSet(gamePlayerList, ZV_GamePlayer__c.Player__c)
		);
	}
}