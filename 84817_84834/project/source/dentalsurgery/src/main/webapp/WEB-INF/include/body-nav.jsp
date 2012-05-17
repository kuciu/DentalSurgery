<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<style type="text/css">
	#body-nav hr {
		text-align:left;
		margin-left: 0px;
		
		border: 0px;
		width: 55%;
		
		color: #B39359;
		background-color:#80C2FF;
		
		height: 1px;
	}
</style>
	
		<div id="body-nav">
			<a href="<c:url value="/patients/new" />">Nowy pacjent</a> <br /> 
			<a href="<c:url value="/patients" />">Kartoteka</a> <br />
			<hr />
			<h4>Słowniki</h4>
			<a href="<c:url value="/dict/visitActivities"/>">Czynności wizyt</a> <br />
			<hr />
			<a href="<c:url value="/about" />">O aplikacji</a> <br />
			<a href="<c:url value="/help" />">Pomoc</a> <br />
		</div>
