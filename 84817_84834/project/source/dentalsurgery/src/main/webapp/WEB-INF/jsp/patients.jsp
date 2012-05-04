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
<script type="text/javascript">

	// jquery code here

</script>

</head>
<body>


	<div id="body-top" class="ui-corner-top">
		<h1>Dental Surgery</h1>
	</div>

	<div id="body-container">
		<div id="body-nav">
			<a href="<c:url value="/patients/new" />">Nowy pacjent</a> <br /> 
			<a href="<c:url value="/patients" />">Kartoteka</a> <br />
		</div>

		<div id="body-content">
			<h1>Kartoteka pacjentów</h1>

			<c:forEach items="${patientList}" var="patient">
				<c:out value="${patient.patientId}" />: <c:out
					value="${patient.name}" />
				<c:out value="${patient.surname}" />
				<c:out value="${patient.street}" />
				<c:out value="${patient.city}" />
				<c:forEach items="${patient.phoneNumbers}" var="phoneNumber">
					<c:out value="${phoneNumber.number }" />
				</c:forEach>
				<br/>
			</c:forEach>


		</div>
	</div>
	<div id="body-footer" class="ui-corner-bottom">(C) 2012 by
		Kamiński &amp; Kuć</div>

</body>
</html>

