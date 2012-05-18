
/**
 * Wrapper na obiekt wizyty, przysłany JSONem
 */
VisitWrapper = function(patientId) {
	var self = this;

	this.patientId = patientId;

	this.teeth = null;
	this.visitObj = null;

	/** ściąga JSONa z nową wizytą */
	this.prepareNewVisit = function(callback) {
		$.ajax({
			type : "GET",
			url : "/dentalsurgery/patients/" + self.patientId
					+ "/visits/prepareNew",
			dataType : "json",
			success : function(data) {
				self.visitObj = data;
				// przygotowanie tablicy obiektów zębów indeksowanej ich
				// numerami
				self.teeth = new Array();
				for ( var toothKey in self.visitObj.teeth) {
					var tooth = self.visitObj.teeth[toothKey];
					self.teeth[tooth.number] = tooth;
				}
				callback(self.visitObj);
			}
		});
	};

	/** wysyla POSTem JSONa z utworzoną w interfejsie wizytą */
	this.sendVisit = function(callbackSuccess, callbackError) {
		$.ajax({
			type : "POST",
			url : "/dentalsurgery/patients/" + self.patientId + "/visits/save",
			data : JSON.stringify(self.visitObj),
			contentType : "application/json",
			dataType : "text",
			success : function(text) {
				callbackSuccess(text);
			}
		}).error(callbackError);
	};

	/** zwraca obiekt zęba o konkretnym numerze FDI */
	this.getToothByNumber = function(number) {
		for ( var toothKey in self.visitObj.teeth) {
			var tooth = self.visitObj.teeth[toothKey];
			if (tooth.number == number) {
				return tooth;
			}
		}
	};

	/** dodaje czynność do tablicy czynności */
	this.addActivity = function(newActivity, activities) {
		for ( var key in activities) {
			if (activities[key].activityId == newActivity.activityId) {
				return;
			}
		}
		activities.push(newActivity);
	};

	/** usuwa czynność z tablicy czynności */
	this.removeActivity = function(activity, activities) {
		for ( var i = 0; i < activities.length; i++) {
			if (activities[i].activityId == activity.activityId) {
				activities.splice(i, 1);
			}
		}
	};

	/** dodaje czynność do wizyty */
	this.addVisitActivity = function(newActivity) {
		this.addActivity(newActivity, self.visitObj.activities);
	};

	/** usuwa czynność z wizyty */
	this.removeVisitActivity = function(activity) {
		this.removeActivity(activity, self.visitObj.activities);
	};

	/** dodaje czynność do zęba */
	this.addToothActivity = function(number, newActivity) {
		this.addActivity(newActivity, self.teeth[number].activities);
	};

	/** usuwa czynność z zęba */
	this.removeToothActivity = function(number, activity) {
		this.removeActivity(activity, self.teeth[number].activities);
	};

	/** zwraca stan zęba lub jego powierzchni */
	this.getToothState = function(number, areaEnumObject) {
		return self.teeth[number][areaEnumObject.stateField];
	};

	/** ustawia stan zęba lub jego powierzchni */
	this.setToothState = function(number, areaEnumObject, newState) {
		self.teeth[number][areaEnumObject.stateField] = newState;
	};

	/** 
	 * zwraca wartość prawdę/fałsz w zależności od tego,
	 * czy dany ząb ma jakikolwiek ustalony stan
	 */
	this.hasAnyToothState = function(toothNumber) {
		for (var areaKey in ToothParts) {
			var toothArea = ToothParts[areaKey];
			if (self.getToothState(toothNumber, toothArea) != null) {
				return true;
			}
		}
		return false;
	};
	
	/** 
	 * zwraca wartość prawdę/fałsz w zależności od tego,
	 * czy dany ząb ma jakąkolwiek przypisaną czynność
	 */
	this.hasAnyToothActivity = function(toothNumber) {
		return self.teeth[toothNumber].activities != null &&
			self.teeth[toothNumber].activities.length > 0;
	};
	
	/** 
	 * Sprawdza, czy konkretna czynność związana z wizytą już istnieje
	 */
	this.hasVisitActivity = function(visitActivity) {
		for (var visitKey in self.visitObj.activities) {
			if (visitActivity.activityId == 
				self.visitObj.activities[visitKey].activityId) {
				return true;
			}
		}
		return false;
	};
	
	/**
	 * Sprawdza, czy konkretna czynność związana z zębem już istnieje
	 */
	this.hasToothActivity = function(toothNumber, toothActivity) {
		for (var toothKey in self.teeth[toothNumber].activities) {
			if (toothActivity.activityId == 
				self.teeth[toothNumber].activities[toothKey].activityId) {
				return true;
			}
		}
		return false;
	};
	
};
