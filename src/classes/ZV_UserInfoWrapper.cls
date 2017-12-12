public class ZV_UserInfoWrapper {
    @testVisible public Id userId {get; private set;}  
    @testVisible public String userName {get; private set;} 
    
    public ZV_UserInfoWrapper() {
    	this.userId = UserInfo.getUserId();
    	this.userName = UserInfo.getUserName();
    } 
}