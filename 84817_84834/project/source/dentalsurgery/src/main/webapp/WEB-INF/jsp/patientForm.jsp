<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dental Surgery | Dodaj pacjenta</title>
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
	$(document).ready(
			function() {
				$('.datepicker').datepicker({
					dateFormat : "dd-mm-yy"
				});
				$('button').button();
				//Tylko wartosci numeryczne - dodatek do jquery
				$('#phone-input').numeric();
				//Blokowanie przycisku gdy pusty numer tel
				$('#phone-add').attr('disabled', 'disabled');
				$('#phone-input').keyup(function() {
					if ($(this).val().length) {
						$('#phone-add').removeAttr('disabled');
					} else {
						$('#phone-add').attr('disabled', 'disabled');
					}
				});

				//Blokowanie przycisku usuwania jesli lista pusta
				if ($("#phones-list option").length == 0) {
					$('#phone-remove').attr('disabled', 'disabled');
				}

				//Dodawnie numeru do listy
				$('#phone-add').click(
						function() {
							$('#phones-list').append(
									"<option value='" + $('#phone-input').val()
											+ "'>" + $('#phone-input').val()
											+ "</option>");
							$('#phone-input').val('');
							$('#phone-add').attr('disabled', 'disabled');
							$('#phone-remove').removeAttr('disabled');
						});

				//Usuwanie elementow
				$('#phone-remove').click(function() {
					$('#phones-list option:selected').each(function() {
						$(this).remove();
					});
					if ($("#phones-list option").length == 0) {
						$('#phone-remove').attr('disabled', 'disabled');
					}
				});
			});
</script>

</head>
<body>

	<div id="body-top" class="ui-corner-top">
		<h1>Dental Surgery</h1>
	</div>

	<div id="body-container">

		<div id="body-nav">
			<a href="<c:url value="/patients/new" />">Nowy pacjent</a> <br /> <a
				href="<c:url value="/patients" />">Kartoteka</a> <br />
		</div>

		<div id="body-content">

			<h2>Dodawanie nowego pacjenta</h2>


			<form:form commandName="patient" method="post">

				<table border="0px">
					<tr>
						<td>Imię:</td>
						<td><form:input path="name" /></td>
						<td><form:errors path="name" cssClass="error" /></td>
					</tr>
					<tr>
						<td>Nazwisko:</td>
						<td><form:input path="surname" /></td>
						<td><form:errors path="surname" cssClass="error" /></td>

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
							<td><input type="button" id="phone-add" value="Dodaj" /></td>
						</tr>
						<tr>
							<td></td>

							<td><select  name="phones" id="phones-list"
									style="width: 170px" multiple size="5"></select></td>
							<td><input type="button" id="phone-remove" value="Usuń" /></td>

						</tr>
					<tr>
						<td colspan="2"><form:button id="create-btn">Utwórz</form:button>
						</td>
				</table>


			</form:form>

			<div class="ui-widget" style="display: none">
				<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
					<p>
						<span class="ui-icon ui-icon-alert"
							style="float: left; margin-right: .3em;"></span> Sample
						ui-state-error style.

					</p>
				</div>
			</div>

		</div>

	</div>
	<div id="body-footer" class="ui-corner-bottom">(C) 2012 by
		Kamiński &amp; Kuć</div>
</body>
</html>

