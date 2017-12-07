var $LCH = $LCH || {};

$LCH.ServerApexPromise = function(component, serverMethodName, serverMethodParams) {
	var action = component.get('c.' + serverMethodName);
	action.setParams(serverMethodParams);

	return new Promise(function(resolve, reject) {
		action.setCallback(this, function(response) {
			if (response.getState() === 'SUCCESS') {
				resolve(response.getReturnValue())
			}
			else {
				var errors = response.getError();
				var errorMessage = (errors && errors[0] && errors[0].message)
					? 'Error message: ' + errors[0].message
					: 'Unknown error';
				reject (errorMessage);
			}
		}); 
		$A.enqueueAction(action);
	}); 
};