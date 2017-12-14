// @see: http://www.codebycody.com/2012/02/sfdc-randomizer.html
public class ZV_Randomizer {
    public Boolean getRandomBoolean() {
    	Integer randomNumber = this.getRandomNumber(10);
    	return Math.mod(randomNumber, 2) == 0;
    }

    public ZV_Cell__c getRandomMember(Set<ZV_Cell__c> cellSet) {
    	Integer cellSetSize = cellSet.size();
    	
    	return (cellSetSize > 0)
    		? (new List<ZV_Cell__c>(cellSet))[this.getRandomNumber(cellSetSize)]
    		: null;
    }

    public ZV_Player__c getRandomMember(Set<ZV_Player__c> playerSet) {
    	Integer randomNumber = this.getRandomNumber(playerSet.size());
		return (new List<ZV_Player__c>(playerSet))[randomNumber];    	
    }
    
    public Integer getRandomNumber(Integer size) {
    	Double randomDouble = Math.random() * size;
    	return randomDouble.intValue();
    }
}