<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
 <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
 <link rel="icon" type="image/ico" href="img/hand.ico" />
 <script src="js/jquery-3.2.1.min.js"></script>
 <script src="js/jquery.m.toast.js"></script>
 <link href="css/jquery.m.toast.css" rel="stylesheet" type="text/css">
 <link href="css/index.css" rel="stylesheet" type="text/css">
 <link href="css/menu.css" rel="stylesheet" type="text/css">
 <link href="css/input.css" rel="stylesheet" type="text/css">
 <link href="css/animation.css" rel="stylesheet" type="text/css">
 <link href="css/buscar_questoes.css" rel="stylesheet" type="text/css">

<title>Buscar Questões</title>

<script src="js/w3.js"></script>
<script>
	function getQuestions(sh, st) {
		var url = "mvc?logic=SeachQuestionLogic";
		$.post(url,{search: sh, status: st},function(data){
			if(data.indexOf("tr_") !== -1 ) {
				$("#questions").html(data);
			} else {
				$("#questions").html("Nenhum questão aqui...");
			}
		});
	};
	
	window.onload = getQuestions("","1");
</script>

</head>
<body>

	<div id="principal">

		<div id="topo">
			Buscar Questões
		</div>
		
		<div id="menu">
			<div w3-include-html="page/menu.jsp"></div> 
	
			<script>
				w3.includeHTML();
			</script>
		</div>
		
		<div id="busca">
			<form id="form_seach" action="mvc?logic=SeachQuestionLogic" method="post">	             
				<input type="text" name="search" placeholder="Busque aqui..." autofocus="autofocus" autocomplete="off" id="home_cs">
				<input type="checkbox" name="status" id="status" class="a,checkbox" value="0" id="status"><label for="status" title="Incluir Desativadas"></label>
				<input type="submit" value="Pesquisar" id="home_bs" class="a">
				<input type="button" value="+" id="home_add" class="a" onClick="location.href='mvc?logic=ViewEditQuestionLogic'">	            
			</form>
		</div>
		
		<div id="meio">	  		
			<div id="questions">
				<!-- SHOW QUESTIONS HERE  -->
			</div>
		</div>        
    
</div>
    
<script>
$("#form_seach").submit(function( event ) {
  event.preventDefault();
  var $form = $( this ),
    fSearch = $form.find( "input[name='search']" ).val(),
    fStatus= "1",
    url = $form.attr( "action" );
  
  if($("#status").is(':checked')) {
		fStatus = "0";
	}
	getQuestions(fSearch,fStatus);
});
</script>

</body>
</html>