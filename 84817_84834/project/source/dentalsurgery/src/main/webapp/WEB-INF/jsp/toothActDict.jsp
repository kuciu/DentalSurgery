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
		$('#price').val('');
		$('#vat').val('');

		$('#submitBtn').text('Dodaj');
	}

	function newActivity(url) {
		$('#activityForm').get(0).setAttribute('action', url);
		clearForm();
	}

	function showDetails(getUrl, editUrl) {
		
		$.getJSON(getUrl, function(data) {
			$('#description').val(data['description']);
			$('#vat').val(data['vat']);
			$('#price').val(data['price']);
			$("#allTooth").attr('checked', data['allTooth']);
			
			$('#submitBtn').text('Zapisz');
			
			$('#activityForm').get(0).setAttribute('action', editUrl);

		});
	}

	function deleteSelected(url) {
		$("#dialog-confirm-question").html(
				"Czy na pewno chcesz usunąć wskazaną pozycje?");
		$("#dialog-confirm")
				.dialog(
						{
							title : "Usunąć czynność?",
							resizable : false,
							width : 500,
							modal : true,
							buttons : {
								"Usuń mimo to" : function() {
									$(this).dialog("close");
									$('#activitiesList option:selected')
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
																					"Udało się z powodzeniem usunąć czynność.",
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
#body-content { /*border: solid;*/
	border-width: 1px;
	border-color: #80C2FF;
}

.icon-operation {
	float: right;
	margin: 0px;
}

.label {
	width: 50px;
	display: block;
	float: left;
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
			<c:url value="/dict/teethActivities/new" var="newUrl" />
			<div id="activityList">
				<h2>Lista czynności zęba</h2>
				<select size="5" style="width: 200px" id='activitiesList'>
					<c:forEach items="${toothActDict }" var="activity">
						<c:url
							value="/dict/teethActivities/${activity.activityId }/update"
							var="editUrl" />
						<c:url
							value="/dict/teethActivities/${activity.activityId }"
							var="getUrl" />
						<option value="${activity.activityId }"
							onclick="showDetails('${getUrl}', '${editUrl }')">
							<c:out value="${activity.description}" />
						</option>
					</c:forEach>
				</select>
				<c:url value="/dict/teethActivities/" var="deleteUrl" />

				<button onclick="deleteSelected('${deleteUrl}')">Usuń</button>
			</div>
			<div id="newEditForm">
				<form:form id="activityForm" method="post" commandName="newActivity"
					action="${newUrl }">
					<form:label path="description" cssClass="label">Opis</form:label>
					<form:input path="description" id="description" />
					<form:errors path="description" />
					<br />
					<form:label path="price" cssClass="label">Cena</form:label>
					<form:input path="price" id="price" />
					<form:errors path="price" />
					<br />
					<form:label path="vat" cssClass="label">VAT</form:label>
					<form:input path="vat" id="vat" />
					<form:errors path="vat" />
					<br />
					<form:label path="allTooth" cssClass="label">Cały ząb</form:label>
					<form:checkbox path="allTooth" id="allTooth"/>
					<br/>
					<form:button id="submitBtn">Dodaj</form:button>
				</form:form>
				<button onclick="newActivity('${newUrl}')">Nowa</button>

			</div>
		</div>
	</div>

	<script>
		
	</script>

	<%@ include file="/WEB-INF/include/body-footer.jsp"%>


</body>
</html>

