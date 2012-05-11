<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include.jsp"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Dental Surgery | Nowa wizyta - <c:out
				value="${patient.surname}" /> <c:out value="${patient.name}" /></title>

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
	src="<c:url value="/resources/jquery/js/jquery-ui-1.8.20.custom.min.js" />"></script>
	
<script type="text/javascript">
			
	/**
	 * Powiadomienie o sukcesie i wykonanie akcji
	 */
	function successMessage(title, text, callback) {
		$("#success-message-text").html(text);
		$("#success-message").dialog({
			title: title,
			resizable: false,
			width:500,
			modal: true,
			buttons: {
				Ok: function() { 
					$( this ).dialog( "close" );
					if (callback != null) {callback();}
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
			title: title,
			resizable: false,
			width:500,
			modal: true,
			buttons: {
				Ok: function() { 
					$( this ).dialog( "close" );
				}
			}
		});
	}
		
</script>

<style type="text/css">
	
	#body-content{
		border: solid;
		border-width: 1px;
		border-color: #80C2FF;
	}
	
	#teeth-maps-div {
		float: left;
		padding: 10px;
		width: 350px;
		height: 300px;
	
	
		border: solid;
		border-width: 1px;
		border-color: #80C2FF;
	}
	
	#permanent-teeth-map {
		width: 355px;
		height: 105px;
		
	}
	#milk-teeth-map {
		margin-left: 65px;
		width: 225px;
		height: 105px;
		
	}
	
	#selected-tooth-div {
		float: right;
		padding: 10px;
		width: 400px;
		height: 300px;
	
	
		border: solid;
		border-width: 1px;
		border-color: #80C2FF;
	}
	
	#selected-tooth-map {
		width: 140px;
		height: 100px;
		border: solid;
		border-width: 1px;
		border-color: #80C2FF;
		margin:auto;
	}
	
	#modify-form-div {
		
		float: left;
		padding: 10px;
		border: solid;
		border-width: 1px;
		border-color: #80C2FF;
		width: 350px;
	}
	
	#list-activities {
		float: right;
		padding: 10px;
		border: solid;
		border-width: 1px;
		border-color: #80C2FF;
		width: 400px;
	}
	
	/* ************************** mapa zębów ********************************************* */
	
	/* obrazki zębów górnych */
	.tooth-top-white {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-top-white.png');
	}
	
	.tooth-top-white:hover {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-top-light.png');
	}
	
	/* obrazki zębów dolnych (odwrócone) */
	.tooth-bottom-white {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-bottom-white.png');
	}
	
	.tooth-bottom-white:hover {
		background-image: url('/dentalsurgery/resources/img/teeth/tooth-bottom-light.png');
	}
	
	/* zęby górne */
	.tooth-top {
		margin-left: 1px;		/* lekkie rozsunięcie zębów */
		width: 20px;
		height: 50px;
		float: left;
		cursor: pointer;
		background-repeat: no-repeat;
		background-position: top;
	}
	

	
	/* pozycjonowanie numeru */
	.tooth-top .tooth-number {
		position: relative;
		top: 33px;
		left: 3px;
	}
	
	/* zęby dolne */
	.tooth-bottom {
		margin-left: 1px;		/* lekkie rozsunięcie zębów */
		width: 20px;
		height: 50px;
		float: left;
		cursor: pointer;
		background-repeat: no-repeat;
		background-position: bottom;
	}
	
	/* pozycjonowanie numeru */
	.tooth-bottom .tooth-number {
		position: relative;
		top: 3px;
		left: 3px;
	}
	
	/* odsunięcie prawej górnej i lewej dolnej części */
	#permanent-teeth-map .tooth-top:nth-child(9),
	#permanent-teeth-map .tooth-bottom:nth-child(25),
	#milk-teeth-map .tooth-top:nth-child(6),
	#milk-teeth-map .tooth-bottom:nth-child(16)  {
		margin-left: 10px;
	}
	
	
</style> 

<script type="text/javascript">


</script>


</head>
<body>

	<!-- Okno dialogowe z pytaniem o potwierdzenie wykonania operacji -->
	<div id="dialog-confirm" style="display: none">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>
			<span id="dialog-confirm-question"></span>
		</p>
	</div>
	
	<!-- Okno dialogowe w przypadku sukcesu -->
	<div id="success-message" style="display: none">
		<p>
			<span class="ui-icon ui-icon-circle-check" style="float: left; margin: 0 7px 20px 0;"></span>
			<span id="success-message-text"></span>
		</p>
	</div>
	
	<!-- Okno dialogowe w przypadku błędu -->
	<div id="error-message" style="display: none">
		<p>
			<span class="ui-icon ui-icon-circle-close" style="float: left; margin: 0 7px 20px 0;"></span>
			<span id="error-message-text"></span>
		</p>
	</div>

	<!-- Właściwa treść -->


	<%@ include file="/WEB-INF/include/body-top.jsp"%>
	<div id="body-container">
	
		<%@ include file="/WEB-INF/include/body-nav.jsp"%>
		<div id="body-content">
			
			<h1>Nowa wizyta: <c:out	value="${patient.surname}" /> <c:out value="${patient.name}" /></title></h1>		
			
			<div id="teeth-maps-div">
				<h3>Zęby stałe</h3>
			
			
				<div id="permanent-teeth-map">
				
					<!-- prawa (sic! ma być prawa, nie lewa) górna -->
					<div class="tooth-top tooth-top-white" id="tooth18"><span class="tooth-number">18</span></div>
					<div class="tooth-top tooth-top-white" id="tooth17"><span class="tooth-number">17</span></div>
					<div class="tooth-top tooth-top-white" id="tooth16"><span class="tooth-number">16</span></div>
					<div class="tooth-top tooth-top-white" id="tooth15"><span class="tooth-number">15</span></div>
					<div class="tooth-top tooth-top-white" id="tooth14"><span class="tooth-number">14</span></div>
					<div class="tooth-top tooth-top-white" id="tooth13"><span class="tooth-number">13</span></div>
					<div class="tooth-top tooth-top-white" id="tooth12"><span class="tooth-number">12</span></div>
					<div class="tooth-top tooth-top-white" id="tooth11"><span class="tooth-number">11</span></div>
					
					<!-- lewa górna -->
					<div class="tooth-top tooth-top-white" id="tooth21"><span class="tooth-number">21</span></div>
					<div class="tooth-top tooth-top-white" id="tooyh22"><span class="tooth-number">22</span></div>
					<div class="tooth-top tooth-top-white" id="tooth23"><span class="tooth-number">23</span></div>
					<div class="tooth-top tooth-top-white" id="tooth24"><span class="tooth-number">24</span></div>
					<div class="tooth-top tooth-top-white" id="tooth25"><span class="tooth-number">25</span></div>
					<div class="tooth-top tooth-top-white" id="tooth26"><span class="tooth-number">26</span></div>
					<div class="tooth-top tooth-top-white" id="tooth27"><span class="tooth-number">27</span></div>
					<div class="tooth-top tooth-top-white" id="tooth28"><span class="tooth-number">28</span></div>
					
					<!-- prawa dolna -->
					<div class="tooth-bottom tooth-bottom-white" id="tooth48"><span class="tooth-number">48</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="tooth47"><span class="tooth-number">47</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="tooth46"><span class="tooth-number">46</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="tooth45"><span class="tooth-number">45</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="tooth44"><span class="tooth-number">44</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="tooth43"><span class="tooth-number">43</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="tooth42"><span class="tooth-number">42</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="tooth41"><span class="tooth-number">41</span></div>
					
					<!-- lewa dolna -->
					<div class="tooth-bottom tooth-bottom-white" id="teeth31"><span class="tooth-number">31</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="teeth32"><span class="tooth-number">32</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="teeth33"><span class="tooth-number">33</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="teeth34"><span class="tooth-number">34</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="teeth35"><span class="tooth-number">35</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="teeth36"><span class="tooth-number">36</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="teeth37"><span class="tooth-number">37</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="teeth38"><span class="tooth-number">38</span></div>			
					
				</div>
				
				<h3>Zęby mleczne</h3>
			
				<div id="milk-teeth-map">
				
					<!-- prawa (sic! ma być prawa, nie lewa) górna -->
					<div class="tooth-top tooth-top-white" id="tooth55"><span class="tooth-number">55</span></div>
					<div class="tooth-top tooth-top-white" id="tooth54"><span class="tooth-number">54</span></div>
					<div class="tooth-top tooth-top-white" id="tooth53"><span class="tooth-number">53</span></div>
					<div class="tooth-top tooth-top-white" id="tooth52"><span class="tooth-number">52</span></div>
					<div class="tooth-top tooth-top-white" id="tooth51"><span class="tooth-number">51</span></div>
					
					<!-- lewa górna -->
					<div class="tooth-top tooth-top-white" id="tooth61"><span class="tooth-number">61</span></div>
					<div class="tooth-top tooth-top-white" id="tooyh62"><span class="tooth-number">62</span></div>
					<div class="tooth-top tooth-top-white" id="tooth63"><span class="tooth-number">63</span></div>
					<div class="tooth-top tooth-top-white" id="tooth64"><span class="tooth-number">64</span></div>
					<div class="tooth-top tooth-top-white" id="tooth65"><span class="tooth-number">65</span></div>
					
					<!-- prawa dolna -->
					<div class="tooth-bottom tooth-bottom-white" id="tooth85"><span class="tooth-number">85</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="tooth84"><span class="tooth-number">84</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="tooth83"><span class="tooth-number">83</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="tooth82"><span class="tooth-number">82</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="tooth81"><span class="tooth-number">81</span></div>
					
					<!-- lewa dolna -->
					<div class="tooth-bottom tooth-bottom-white" id="teeth71"><span class="tooth-number">71</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="teeth72"><span class="tooth-number">72</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="teeth73"><span class="tooth-number">73</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="teeth74"><span class="tooth-number">74</span></div>
					<div class="tooth-bottom tooth-bottom-white" id="teeth75"><span class="tooth-number">75</span></div>			
				
				</div>
			
			</div>
			
			<div id="selected-tooth-div">
				
				<h3>Wybierz ząb lub jego powierzchnię</h3>
				
				Połącz powierzchnie:
					<input type="checkbox" id="is-whole-tooth-selected"/>
				<div id="selected-tooth-map">
					
				</div>
				
				<h3>Wybrany ząb:
					<span id="selected-tooth-number">12</span>,
					powierzchnia:
					<span id="selected-tooth-surface">wszystkie</span>
				</h3>
				
				Obecny stan:
				<select>
					<option>stan1</option>
					<option>stan2</option>
					<option>stan3</option>
					<option>stan4</option>
				</select>
				
			</div>
			
			<div id="modify-form-div">
				<h3>Dodaj czynność związaną z wybranym zębem</h3>
				<select>
					<option>Czynność 1, cena: 500 zł</option>
					<option>Czynność 2, cena: 500 zł</option>
					<option>Czynność 3, cena: 500 zł</option>
					<option>Czynność 4, cena: 500 zł</option>
					<option>Czynność 5, cena: 500 zł</option>
				</select>
				<button value="Dodaj" title="Dodaj">Dodaj czynność</button>
			</div>
			
			<div id="list-activities">
				<h3>Lista dodanych czynności</h3>
				<ul>
					<li> Ząb: 23, powierzchnia: żująca, czynność: plomba</li>
					<li> Ząb: 33, powierzchnia: żująca, czynność: plomba</li>
					<li> Ząb: 24, powierzchnia: żująca, czynność: plomba</li>
					<li> Ząb: 53, powierzchnia: żująca, czynność: plomba</li>
				</ul>
			</div>
			
		</div>
	</div>
	<%@ include file="/WEB-INF/include/body-footer.jsp"%>


</body>
</html>

