({
	loadBoardWithCells : function(component) {
		var serverMethod = {
			name: 'getBoard',
			params: {
				boardId: component.get('v.recordId')
			}
		};
		return this.apexResolve(component, serverMethod);
	},
	
	apexResolve: function(component, serverMethod) {
		var action = component.get('c.' + serverMethod.name);
		action.setParams(serverMethod.params);

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
	},
	
	displayCells : function(component) {
		return function(returnValue) {
			console.log('######### displayCells returnValue', returnValue);
		}
	}
})