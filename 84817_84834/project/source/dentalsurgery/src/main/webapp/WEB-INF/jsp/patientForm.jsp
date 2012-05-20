<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:choose>
	<c:when
		test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'edit')}">
		<c:set var="editMode" value="true" />
	</c:when>
	<c:otherwise>
		<c:set var="editMode" value="false" />
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${editMode == true }">
		<title>Dental Surgery | Edycja pacjenta - <c:out
				value="${patient.surname}" /> <c:out value="${patient.name}" /></title>
	</c:when>
	<c:when test="${editMode == false}">
		<title>Dental Surgery | Dodawanie nowego pacjenta</title>
	</c:when>
</c:choose>
<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet"
	type="text/css" />
<link
	href="<c:url value="/resources/jquery/css/cupertino/jquery-ui-1.8.20.custom.css" />"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-1.7.2.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-ui-1.8.20.custom.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery.numeric.js" />"></script>
<script type="text/javascript">
	function deleteListElements(element) {
		$(element).each(function() {
			if ($(this).val().match("^new")) {
				$(this).remove();
			} else {
				$(this).val(-$(this).val());
				$(this).hide();
				$(this).removeAttr('selected');
			}
		});
	}

	function addElementToList(input, list, button) {
		$(list).append(
				"<option value='new" + $(input).val() + "'>" + $(input).val()
						+ "</option>");
		$(input).val('');
		$(button).attr('disabled', 'disabled');
	}

	$(document).ready(function() {
		$('.datepicker').datepicker({
			dateFormat : "dd-mm-yy"
		});
		$('button').button();
		//Tylko wartosci numeryczne - dodatek do jquery
		$('#phone-input').numeric();
		$('#pesel-input').numeric();
		//Blokowanie przycisku gdy pusty numer tel
		$('#phone-add').attr('disabled', 'disabled');
		$('#phone-input').keyup(function() {
			if ($(this).val().length) {
				$('#phone-add').removeAttr('disabled');
			} else {
				$('#phone-add').attr('disabled', 'disabled');
			}
		});

		//Copy & paste z numerów telefonów - dla chorób
		$('#illness-add').attr('disabled', 'disabled');
		$('#illness-input').keyup(function() {
			if ($(this).val().length) {
				$('#illness-add').removeAttr('disabled');
			} else {
				$('#illness-add').attr('disabled', 'disabled');
			}
		});

		//Copy & paste z numerów telefonów - dla lekow
		$('#medication-add').attr('disabled', 'disabled');
		$('#medication-input').keyup(function() {
			if ($(this).val().length) {
				$('#medication-add').removeAttr('disabled');
			} else {
				$('#medication-add').attr('disabled', 'disabled');
			}
		});

		//Zaznaczanie wszystkich numerów telefonów, chorób itp.
		$('#create-btn').click(function() {
			$('#phones-list option').each(function() {
				$(this).attr('selected', 'selected');
			});
			$('#illness-list option').each(function() {
				$(this).attr('selected', 'selected');
			});
			$('#medications-list option').each(function() {
				$(this).attr('selected', 'selected');
			});
		});

	});

	//Ukrywanie id ujemnych, a dla zera, czyli dodanych ustawienie poprzednich z prefiksem new i wartościa
	function afterLoad() {
		$('#phones-list option').each(function() {
			if ($(this).val() == 0) {
				$(this).val('new' + $(this).text());
			} else if ($(this).val() < 0) {
				$(this).hide();
			}
		});
	}
</script>

</head>
<body>


	<%@ include file="/WEB-INF/include/body-top.jsp"%>
	<div id="body-container">

		<%@ include file="/WEB-INF/include/body-nav.jsp"%>
		<div id="body-content">

			<c:choose>
				<c:when test="${editMode == true }">
					<h2>
						Edycja pacjenta -
						<c:out value="${patient.surname}" />
						<c:out value="${patient.name}" />
					</h2>
				</c:when>
				<c:when test="${editMode == false}">
					<h2>Dodawanie nowego pacjenta</h2>
				</c:when>
			</c:choose>

			<form:form commandName="patient" method="post">

				<table border="0px">
					<tr>
						<td><form:label path="name">Imię:</form:label></td>
						<td><form:input path="name" /></td>
						<td><form:errors path="name" cssClass="error" /></td>
					</tr>
					<tr>
						<td>Nazwisko:</td>
						<td><form:input path="surname" /></td>
						<td><form:errors path="surname" cssClass="error" /></td>
					</tr>

					<tr>
						<td>Płeć:</td>
						<td><form:select path="gender"
								class="ui-selectmenu ui-widget ui-state-default ui-selectmenu-popup"
								style="width: 150px">
								<form:option value="M">Mężczyzna</form:option>
								<form:option value="K">Kobieta</form:option>
							</form:select></td>
						<td></td>
					</tr>

					<tr>
						<td>Pesel:</td>
						<td><form:input path="pesel" id="pesel-input" maxlength="11" /></td>
						<td><form:errors path="pesel" cssClass="error" /></td>
					</tr>

					<tr>
						<td>Ulica:</td>
						<td><form:input path="street" /></td>
						<td><form:errors path="street" cssClass="error" /></td>
					</tr>

					<tr>
						<td>Miasto:</td>
						<td><form:input path="city" /></td>
						<td><form:errors path="city" cssClass="error" /></td>
					</tr>

					<tr>
						<td>Data urodzenia:</td>
						<td><form:input path="bornDate" cssClass="datepicker" /></td>
						<td><form:errors path="bornDate" cssClass="error" /></td>
					</tr>
					<tr>
						<td>Numery kontaktowe:</td>
						<td><input id="phone-input" maxlength="20" /></td>
						<td><input type="button" id="phone-add" value="Dodaj"
							onclick="addElementToList('#phone-input', '#phones-list', '#phone-add')"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" /></td>
					</tr>
					<tr>
						<td></td>
						<td><form:select path="phoneNumbers" name="phones"
								id="phones-list" style="width: 170px" multiple="true" size="5"
								items="${patient.phoneNumbers }" itemValue="phoneId"
								itemLabel="number">
							</form:select></td>
						<td><input type="button" id="phone-remove" value="Usuń"
							onClick="deleteListElements('#phones-list option:selected')"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" /></td>
					</tr>
					<tr>
						<td>Przebyte choroby</td>
						<td><input id="illness-input" maxlength="20" /></td>
						<td><input type="button" id="illness-add" value="Dodaj"
							onclick="addElementToList('#illness-input', '#illness-list', '#illness-add')"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" /></td>
					</tr>
					<tr>
						<td></td>
						<td><form:select path="illnesses" id="illness-list"
								style="width: 170px" multiple="true" size="5"
								items="${patient.illnesses }" itemValue="illnessId"
								itemLabel="name">
							</form:select></td>
						<td><input type="button" id="illness-remove" value="Usuń"
							onClick="deleteListElements('#illness-list option:selected')"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" /></td>
					</tr>
					<tr>
						<td>Przyjmowane leki</td>
						<td><input id="medication-input" maxlength="20" /></td>
						<td><input type="button" id="medication-add" value="Dodaj"
							onclick="addElementToList('#medication-input', '#medications-list', '#medication-add')"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" /></td>
					</tr>
					<tr>
						<td></td>
						<td><form:select path="medications" id="medications-list"
								items="${patient.medications}" itemValue="medicationId"
								itemLabel="name" style="width: 170px" multiple="true" size="5">
							</form:select></td>
						<td><input type="button" id="medication-remove" value="Usuń"
							onClick="deleteListElements('#medications-list option:selected')"
							class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" /></td>
					</tr>
					<tr>
						<td colspan="3"><form:button id="create-btn">
								<c:choose>
									<c:when test="${editMode == true }">Modyfikuj</c:when>
									<c:when test="${editMode == false}">Utwórz</c:when>
								</c:choose>
							</form:button></td>
				</table>
				<input type="hidden" name="editMode" value="${editMode}" />
			</form:form>

		</div>

	</div>
	<script>
		window.onload = afterLoad;
	</script>
	<%@ include file="/WEB-INF/include/body-footer.jsp"%>
</body>
</html>

