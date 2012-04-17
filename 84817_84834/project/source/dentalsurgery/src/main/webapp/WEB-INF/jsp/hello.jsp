<%@ include file="/WEB-INF/jsp/include.jsp"%>

<html>
<head>
<title><fmt:message key="title" /></title>
</head>
<body>
	<h1>Witaj w systemie <fmt:message key="title" />!</h1>
	<p>
	Oto napis zapisany w modelu: <c:out value="${someString}"></c:out>
	</p>
</body>
</html>
