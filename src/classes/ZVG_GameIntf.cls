public interface ZVG_GameIntf {
    List<ZV_GamePlayer__c> attachPlayers (List<ZV_Game__C> gameList);
    Boolean canOccupyCell(ZV_GameContext gameContext);
    List<ZV_Cell__c> occupyCells(ZV_GameContext gameContext);
    Id checkForWinner(ZV_GameContext gameContext); 
}