public with sharing class ZV_GamePlayerSelector extends fflib_SObjectSelector {
	ZV_GameSelector gameSelector;
	ZV_PlayerSelector playerSelector;
	
	public ZV_GamePlayerSelector(ZV_GameSelector gameSelector, ZV_PlayerSelector playerSelector) {
		this.gameSelector = gameSelector;
		this.playerSelector = playerSelector;
	}
 
	public ZV_GamePlayerSelector() {
		this(new ZV_GameSelector(), new ZV_PlayerSelector());
	}
	
	public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField> {
			ZV_GamePlayer__c.Id,
			ZV_GamePlayer__c.Game__c,
			ZV_GamePlayer__c.Player__c,
			ZV_GamePlayer__c.PlayOrder__c
		};
	}
 
	public Schema.SObjectType getSObjectType() {
		return ZV_GamePlayer__c.sObjectType;
	} 

	public override String getOrderBy() {
		return 'PlayOrder__c ASC';
	}

	public List<ZV_GamePlayer__c> selectById(Set<Id> idSet) {
		return (List<ZV_GamePlayer__c>) selectSObjectsById(idSet);
	}

	// It is tempting to bulkify this to handle Set<Id> gameIdSet.
	// However, presently this is only consumed by BoardAuraCtrl, when we only need to handle one game at a time.
	// Separating the games back out adds unnecessary/undesirable complexity.
	public List<ZV_GamePlayer__c> selectByGameId(Id gameId) {
		fflib_QueryFactory gamePlayerQueryFactory = newQueryFactory();
		this.gameSelector.configureQueryFactoryFields(gamePlayerQueryFactory, 'Game__c');
		this.playerSelector.configureQueryFactoryFields(gamePlayerQueryFactory, 'Player__c');

		return (List<ZV_GamePlayer__c>) Database.query(
			gamePlayerQueryFactory
				.setCondition('Game__c = :gameId')
				.toSOQL()
		);
	}
}