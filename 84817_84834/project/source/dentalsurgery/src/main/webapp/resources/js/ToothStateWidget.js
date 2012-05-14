

/**
 * Tworzy i zarządza listą możliwych stanów zęba. Reaguje na zmianę.
 */
ToothStateWidget = function(componentManager) {
	var self = this;
	
	/** rejestracja menedżera komponentów */
	this.componentManager = componentManager;
	
	/**
	 * Tworzy listę opcji
	 * @param toothStates lista obiektów stanów zęba
	 */
	this.createToothStateUi = function(toothStates) {
		$.each(toothStates, function(_,state){
			var $newOption = $('<option value="'+state.toothStateId+
					'">'+state.description+'</option>');
			$('#selected-tooth-state').append($newOption);
		});
		
	};
	
	/**
	 * Rejestracja obsługa zdarzeń
	 */
	this.registerEventHandlers = function() {
		
	};
	
	
};
