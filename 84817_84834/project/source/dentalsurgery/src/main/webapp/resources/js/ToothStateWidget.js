

/**
 * Tworzy i zarządza listą możliwych stanów zęba. Reaguje na zmianę.
 */
ToothStateWidget = function(componentManager) {
	var self = this;
	
	/** rejestracja menedżera komponentów */
	this.componentManager = componentManager;
	
	/** pomocnicza tablica stanów */
	this.statesMap = new Array();
	
	/**
	 * Tworzy listę opcji
	 * @param toothStates lista obiektów stanów zęba
	 */
	this.createToothStateUi = function(toothStates) {
		var $wholeOptGroup = 
			$('<optgroup id="whole-tooth-states"'+
					'label="Zasięg: cały ząb"></optgroup>');
		$('#selected-tooth-state').append($wholeOptGroup);
		$restOptGroup = 
			$('<optgroup id="rest-tooth-states"'+
					'label="Zasięg: dowolna powierzchnia/cały ząb"></optgroup>');
		$('#selected-tooth-state').append($restOptGroup);
		
		$.each(toothStates, function(_,state){
			
			self.statesMap[state.toothStateId] = state;
			var $newOption = $('<option value="'+state.toothStateId+
					'">'+state.description+'</option>');
			// tworzymy grupę stanów dla całego zęba
			if (state.allTooth == null 
					|| state.allTooth == false || state.allTooth == 0) {
				$("#rest-tooth-states").append($newOption);	
			} else {
				$("#whole-tooth-states").append($newOption);
			}
			
		});
		$('#selected-tooth-state').selectmenu({
			style: 'popup',
			menuWidth: '340',
			width: '320',
			select: function(){
				var value = $('#selected-tooth-state').selectmenu("value");
				if (value == 'null') {
					self.componentManager.changeState(null);
				} else {
					self.componentManager.changeState(self.statesMap[value]);
				}
				
			}
		});
	};
	
	/** wybiera stan w liście rozwijanej */
	this.selectState = function(newState) {
		var stateId = newState == null? 'null': newState.toothStateId; 
		
		$('#selected-tooth-state').selectmenu("value", stateId);
	};
	
	/** wyłącza możliwość wybrania stanu dot. całego zęba */
	this.disableWholeToothStates = function() {
		$('#selected-tooth-state').selectmenu("disable",0,"optgroup");
	};
	
	/** włącza możliwość wybrania stanu dot. całego zęba */
	this.enableWholeToothStates = function() {
		$('#selected-tooth-state').selectmenu("enable",0,"optgroup");
	};
	
	/**
	 * Rejestracja obsługa zdarzeń
	 */
	this.registerEventHandlers = function() {
		
	};
	
	
};
