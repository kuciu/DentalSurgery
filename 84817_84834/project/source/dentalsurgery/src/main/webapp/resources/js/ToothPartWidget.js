/**
 * Widget odpowiedzialny za możliwość wyboru konkretnej części zęba
 */
ToothPartWidget = function(componentManager) {
	var self = this;

	/** rejestracja menedżera komponentów */
	this.componentManager = componentManager;

	/** prefiks identyfikatorów powierzchni zęba na liście */
	this.prefix = "tooth-part";

	/** tworzy listę części zęba w UI */
	this.createListOfPartsUi = function() {
		$.each(ToothParts, function(_, part) {
			$newElem = $('<li class="ui-tooth-part white" id="' + self.prefix
					+ part.value + '">' + part.description + '</li>');
			$('#selected-part-list').append($newElem);
		});
	};

	/**
	 * Zmienia kolor pozycji na liście części zębów Przykład wywołania:
	 * .changeColor(ToothParts.WHOLE_TEETH, Colors.WHITE)
	 */
	this.changeColor = function(toothPart, newColor) {
		$.each(Colors, function(_, color) {
			$('#' + self.prefix + toothPart.value).removeClass(color.cssClass);
		});
		$('#' + self.prefix + toothPart.value).addClass(newColor.cssClass);
	};

	/**
	 * Zaznacza/odznacza powierzchnię zęba (graficzne podświetlenie) Przykład:
	 * .toggleSelected(ToothParts.AREA_0)
	 */
	this.toggleSelected = function(toothPart) {
		var toothPartId = '#' + self.prefix + toothPart.value;
		$(toothPartId).toggleClass('selected');
	};

	/**
	 * Obsługa zdarzeń związanych z interfejsem użytkownika
	 */
	this.registerEventHandlers = function() {
		// kliknięcie na powierzchnię zęba
		$('.ui-tooth-part').click(
				function() {
					var toothPartValue = this.id.substring(self.prefix.length,
							self.prefix.length + 2);
					self.componentManager.selectToothPart(ToothParts['AREA_'
							+ toothPartValue]);
				});
	};
};
