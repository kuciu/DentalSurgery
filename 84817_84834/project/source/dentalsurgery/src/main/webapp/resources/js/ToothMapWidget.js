
/**
 * Widget z mapą uzębienia
 */
ToothMapWidget = function(componentManager) {
	var self = this;

	/** rejestracja menedżera komponentów */
	this.componentManager = componentManager;

	/** prefiks identyfikatorów zębów na mapie */
	this.prefix = "tooth";

	/**
	 * Tworzy mapę uzębienia w postaci graficznej
	 */
	this.createTeethMapUi = function() {
		$.each(TeethNumbers.PERMANENT.TOP, function(_, num) {
			var $toothUi = $('<div class="ui-tooth white" id="' + self.prefix
					+ num + '"><span class="number">' + num + '</span></div>');
			$(".ui-teeth-map .permanent .top").append($toothUi);
		});
		$.each(TeethNumbers.PERMANENT.BOTTOM, function(_, num) {
			var $toothUi = $('<div class="ui-tooth white" id="' + self.prefix
					+ num + '"><span class="number">' + num + '</span></div>');
			$(".ui-teeth-map .permanent .bottom").append($toothUi);
		});
		$.each(TeethNumbers.DECIDUOUS.TOP, function(_, num) {
			var $toothUi = $('<div class="ui-tooth white" id="' + self.prefix
					+ num + '"><span class="number">' + num + '</span></div>');
			$(".ui-teeth-map .deciduous .top").append($toothUi);
		});
		$.each(TeethNumbers.DECIDUOUS.BOTTOM, function(_, num) {
			var $toothUi = $('<div class="ui-tooth white" id="' + self.prefix
					+ num + '"><span class="number">' + num + '</span></div>');
			$(".ui-teeth-map .deciduous .bottom").append($toothUi);
		});
	};

	/**
	 * Zmienia kolor zęba Przykład: .changeColor(28, Colors.WHITE)
	 */
	this.changeColor = function(toothNumber, newColor) {
		$.each(Colors, function(_, color) {
			$('#tooth' + toothNumber).removeClass(color.cssClass);
		});
		$('#tooth' + toothNumber).addClass(newColor.cssClass);
	};

	/**
	 * Zaznacza/odznacza ząb (graficzne podświetlenie) Przykład:
	 * .toggleSelected(28)
	 */
	this.toggleSelected = function(toothNumber) {
		$('#tooth' + toothNumber).toggleClass('selected');
	};

	/**
	 * Obsługa zdarzeń związanych z interfejsem użytkownika
	 */
	this.registerEventHandlers = function() {
		// kliknięcie na ząb
		$('.ui-tooth').click(
				function() {
					var toothNumber = this.id.substring(self.prefix.length,
							self.prefix.length + 2);
					self.componentManager.selectTooth(toothNumber);
				});
	};

};
