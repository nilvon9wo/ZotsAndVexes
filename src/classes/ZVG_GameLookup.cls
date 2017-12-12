public class ZVG_GameLookup {
	ZVG_GamesEnumHelper gamesEnumHelper;
	
	public ZVG_GameLookup(ZVG_GamesEnumHelper gamesEnumHelper) {
		this.gamesEnumHelper = gamesEnumHelper;
	} 

	public ZVG_GameLookup() {
		this(new ZVG_GamesEnumHelper());
	} 
	
	public static Map<ZVG_GamesEnum, Type> GAME_CLASS_BY_NAME_MAP = new Map<ZVG_GamesEnum, Type>{
		ZVG_GamesEnum.TRADITIONAL_TIC_TAC_TOE_AGAINST_COMPUTER => ZVG_TraditionalTicTacToeGameVsComputer.class
	};       
	
	public static Map<ZVG_GamesEnum, ZVG_GameIntf> GAME_INSTANCE_BY_NAME_MAP = new Map<ZVG_GamesEnum, ZVG_GameIntf>();
	 
	public ZVG_GameIntf getFor(ZV_Game__c game) {
		return this.getFor(this.gamesEnumHelper.convertToEnumFor(game)); 
	}
	 
	public ZVG_GameIntf getFor(ZVG_GamesEnum gameEnum) {
		Type gameType = GAME_CLASS_BY_NAME_MAP.get(gameEnum);
		if (gameType == null) {
			throw new ZVG_GameLookupException('Game type ' + gameEnum + ' is not supported.');
		}
		
		if (GAME_INSTANCE_BY_NAME_MAP.get(gameEnum) == null) {
			GAME_INSTANCE_BY_NAME_MAP.put(gameEnum, (ZVG_GameIntf) gameType.newInstance());
		}
		return GAME_INSTANCE_BY_NAME_MAP.get(gameEnum);
	} 
}