<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Dental Surgery | Historia wizyt - <c:out
		value="${patient.surname}" /> <c:out value="${patient.name}" />
	(perspektywa szczęki)
</title>

<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet"
	type="text/css" />
<link
	href="<c:url value="/resources/jquery/css/cupertino/jquery-ui-1.8.20.custom.css" />"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-1.7.2.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-ui-1.8.20.custom.min.js" />"></script>




<link href="<c:url value="/resources/css/visit.css" />" rel="stylesheet"
	type="text/css" />
<link href="<c:url value="/resources/css/teeth-map.css" />"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<c:url value="/resources/js/visit-common.js" />"></script>

<script type="text/javascript"
	src="<c:url value="/resources/js/ToothMapWidget.js" />"></script>

<style>
	#teeth-history {
		float:left;
		margin-left: 30px;
		
		/*border: solid;*/
		border-width: 1px;
		border-color: #80C2FF;	
	}
</style>

<script type="text/javascript">
	/**
	 * Menadżer komponentów aplikacji. Wszystkie operacje zbiera do kupy.
	 */
	ComponentManager = function(patientId) {
		var self = this;

		this.patientId = patientId;
		this.currentToothNumber = null;

		/** widżet z mapą uzębienia */
		this.toothMapWidget = new ToothMapWidget(this);

		/** Wybranie nowego zęba */
		this.selectTooth = function(toothNumber) {
			if (self.currentToothNumber != null)
				self.toothMapWidget.toggleSelected(self.currentToothNumber);
			self.currentToothNumber = toothNumber;
			self.toothMapWidget.toggleSelected(self.currentToothNumber);
			//$('#selected-tooth-number').text(self.currentToothNumber);
			
			
			// TUTAJ KOD OBSŁUGUJĄCY ZAZNACZENIE ZĘBA
			
		};
		
		/** inicjalizacja mapy uzębienia */
		this.initialize = function() {
			self.toothMapWidget.createTeethMapUi();
			self.toothMapWidget.registerEventHandlers();
		};
		
	};

	// inicjalizacja
	$(document).ready(function() {
		var patientId = $('#patientId').text();
		manager = new ComponentManager(patientId);
		manager.initialize();
	});
</script>

</head>
<body>
	<span id="patientId" style="display: none"><c:out value="${patientId}"/></span>
	<!-- Okno dialogowe z pytaniem o potwierdzenie wykonania operacji -->
	<div id="dialog-confirm" style="display: none">
		<p>
			<span class="ui-icon ui-icon-alert"
				style="float: left; margin: 0 7px 20px 0;"></span> <span
				id="dialog-confirm-question"></span>
		</p>
	</div>

	<!-- Okno dialogowe w przypadku sukcesu -->
	<div id="success-message" style="display: none">
		<p>
			<span class="ui-icon ui-icon-circle-check"
				style="float: left; margin: 0 7px 20px 0;"></span> <span
				id="success-message-text"></span>
		</p>
	</div>

	<!-- Okno dialogowe w przypadku błędu -->
	<div id="error-message" style="display: none">
		<p>
			<span class="ui-icon ui-icon-circle-close"
				style="float: left; margin: 0 7px 20px 0;"></span> <span
				id="error-message-text"></span>
		</p>
	</div>

	<!-- Właściwa treść -->

	<%@ include file="/WEB-INF/include/body-top.jsp"%>
	<div id="body-container">

		<%@ include file="/WEB-INF/include/body-nav.jsp"%>
		<div id="body-content">
			<c:if test="${message != null }">
				<div class="ui-widget">
					<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
						<p>
							<span class="ui-icon ui-icon-alert"
								style="float: left; margin-right: .3em;"></span>
							<c:out value="${message}" />
						</p>
					</div>
				</div>
			</c:if>
			<h1>
				Historia wizyt (szczęka):
				<c:out value="${patient.surname}" />
				<c:out value="${patient.name}" />
			</h1>
			<div class="ui-teeth-map" id="ui-teeth-map">
				<h3>Zęby stałe</h3>
				<div class="permanent" id="ui-teeth-map-permanent">
					<div class="top"></div>
					<div class="bottom"></div>
				</div>
				<h3>Zęby mleczne</h3>
				<div class="deciduous" id="ui-teeth-map-deciduous">
					<div class="top"></div>
					<div class="bottom"></div>
				</div>
			</div>
			<div id="teeth-history">
				<div class="visit" id="visit-25-03-2012">
					<h3>Wizyta z dnia 21-05-2012</h3>
					Tu będzie historia
				</div>
				
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/include/body-footer.jsp"%>


</body>
</html>

