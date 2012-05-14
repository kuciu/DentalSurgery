
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
	this.sendVisit = function(callback) {
		$.ajax({
			type : "POST",
			url : "/dentalsurgery/patients/" + self.patientId + "/visits/save",
			data : JSON.stringify(self.visitObj),
			contentType : "application/json",
			dataType : "text",
			success : function(text) {
				if (callback != null) {
					callback(text);
				}
			}
		});
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

	/** ustawia wartość komentarza do wizyty */
	this.setComments = function(comments) {
		self.visitObj.comments = new String(comments);
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

};
