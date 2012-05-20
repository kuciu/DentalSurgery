<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Dental Surgery | Słownik - Czynności zęba</title>

<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet"
	type="text/css" />
<link
	href="<c:url value="/resources/jquery/css/cupertino/jquery-ui-1.8.20.custom.css" />"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-1.7.2.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-ui-1.8.20.custom.min.js" />"></script>
<script type="text/javascript">
	/**
	 * Powiadomienie o sukcesie i wykonanie akcji
	 */
	function successMessage(title, text, callback) {
		$("#success-message-text").html(text);
		$("#success-message").dialog({
			title : title,
			resizable : false,
			width : 500,
			modal : true,
			buttons : {
				Ok : function() {
					$(this).dialog("close");
					if (callback != null) {
						callback();
					}
				}
			}
		});
	}

	/**
	 * Powiadomienie o błędzie
	 */
	function errorMessage(title, text) {
		$("#error-message-text").html(text);
		$("#error-message").dialog({
			title : title,
			resizable : false,
			width : 500,
			modal : true,
			buttons : {
				Ok : function() {
					$(this).dialog("close");
				}
			}
		});

	}

	function clearForm() {
		$('#description').val('');
		$("#allTooth").attr('checked', false);

		$('#submitBtn').text('Dodaj');
	}

	function newState(url) {
		$('#stateForm').get(0).setAttribute('action', url);
		clearForm();
	}

	function showDetails(getUrl, editUrl) {

		$.getJSON(getUrl, function(data) {
			$('#description').val(data['description']);
			$("#allTooth").attr('checked', data['allTooth']);

			$('#submitBtn').text('Zapisz');

			$('#stateForm').get(0).setAttribute('action', editUrl);

		});
	}

	function deleteSelected(url) {
		$("#dialog-confirm-question").html(
				"Czy na pewno chcesz usunąć wskazaną pozycje?");
		$("#dialog-confirm")
				.dialog(
						{
							title : "Usunąć stan?",
							resizable : false,
							width : 500,
							modal : true,
							buttons : {
								"Usuń mimo to" : function() {
									$(this).dialog("close");
									$('#statesList option:selected')
											.each(
													function() {
														var deleteUrl = url
																+ $(this).val()
																+ "/delete";
														var element = $(this);
														$
																.post(deleteUrl)
																.success(
																		function() {
																			successMessage(
																					"Czynność usunięta",
																					"Udało się z powodzeniem usunąć stan zęba.",
																					function() {
																						window.location
																								.reload();
																					});
																			$(
																					element)
																					.remove();
																		})
																.error(
																		function() {
																			errorMessage(
																					"Błąd podczas usuwania",
																					"<strong>Czynność nie została usunięta!</strong> Proszę spróbować później.");
																		});
													});
								},
								"Anuluj" : function() {
									$(this).dialog("close");
								}
							}
						});

	}
</script>

<style type="text/css">

#activityList {
	float: left;
	width: 300px;
}

#newEditForm {
	float: left;
	width: 300px;
	margin-top: 50px;
}
</style>

</head>
<body>

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
			<c:url value="/dict/teethStates/new" var="newUrl" />
			<div id="activityList">
				<h2>Lista stanów zęba</h2>
				<select size="5" style="width: 200px" id='statesList'>
					<c:forEach items="${toothStateDict }" var="state">
						<c:url value="/dict/teethStates/${state.toothStateId }/update"
							var="editUrl" />
						<c:url value="/dict/teethStates/${state.toothStateId }"
							var="getUrl" />
						<option value="${state.toothStateId }"
							onclick="showDetails('${getUrl}', '${editUrl }')">
							<c:out value="${state.description}" />
						</option>
					</c:forEach>
				</select> <br />
				<c:url value="/dict/teethStates/" var="deleteUrl" />

				<button onclick="deleteSelected('${deleteUrl}')" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">Usuń</button>
			</div>
			<div id="newEditForm">
				<form:form id="stateForm" method="post" commandName="newState"
					action="${newUrl }">
					<form:label path="description" cssClass="label">Opis</form:label>
					<form:input path="description" id="description" />
					<form:errors path="description" />
					<br />
					<form:label path="allTooth" cssClass="label">Cały ząb</form:label>
					<form:checkbox path="allTooth" id="allTooth" />
					<br />
					<form:button id="submitBtn"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">Dodaj</form:button>
				</form:form>
				<button onclick="newState('${newUrl}')"
					class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">Nowa</button>

			</div>
		</div>
	</div>

	<script>
		
	</script>

	<%@ include file="/WEB-INF/include/body-footer.jsp"%>


</body>
</html>

