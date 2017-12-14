// See: http://bobbuzzard.blogspot.hu/2016/12/javascript-promises-in-lightning_30.html
var $LCH = $LCH || {};

$LCH = (function(){
	var showSpinner = function(component) {
	    $A.util.removeClass(component.find('spinner'), 'slds-hide');
	};

	var hideSpinner = function(component) {
	    $A.util.addClass(component.find('spinner'), 'slds-hide');
	};

	var ServerApexPromise = function(component, serverMethodName, serverMethodParams) {
		var action = component.get('c.' + serverMethodName);
		action.setParams(serverMethodParams);

		return new Promise(function(resolve, reject) {
			showSpinner(component);
			action.setCallback(this, function(response) {
				hideSpinner(component);
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

	var WaitPromise = function(milliseconds) {
		return new Promise(function(resolve) {
			setTimeout(resolve, milliseconds);
		});
	};
	
	return {
		ServerApexPromise: ServerApexPromise,
		WaitPromise: WaitPromise
	}
}());

