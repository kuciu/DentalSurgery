<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dental Surgery | Lista pacjentów</title>
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
	
	// custom js here
	
</script>

<style type="text/css">
	
	/* custom css here */
	#patient-list {
		text-align: right;
		width: 300px;
	}
	
</style>

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
			<h1>Lista pacjentów</h1>

						
				<table id="patient-list" border="0">
					
					<thead>
						<tr> <th>Imię i nazwisko</th><th>Operacje</th></tr>
					</thead>
				
					<c:forEach items="${patientList}" var="patient">
						<tr> 
							<td> <c:out value="${patient.name}" /> <c:out value="${patient.surname}" /> </td>
							<td>
								<a href="<s:url value="/patients/${patient.patientId}/delete" />">Usuń</a>
							</td>
						</tr>
					</c:forEach>
					
					
				
				</table>

		</div>
	</div>
	<div id="body-footer" class="ui-corner-bottom">(C) 2012 by
		Kamiński &amp; Kuć</div>

</body>
</html>

