<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
 <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
 <link rel="icon" type="image/ico" href="img/hand.ico" />
 <script src="js/jquery-3.2.1.min.js"></script>
 <link href="css/index.css" rel="stylesheet" type="text/css">
 <script src="js/jquery.m.toast.js"></script>
 <link href="css/jquery.m.toast.css" rel="stylesheet" type="text/css">
 <link href="css/menu.css" rel="stylesheet" type="text/css">
 <link href="css/input.css" rel="stylesheet" type="text/css">
 <link href="css/animation.css" rel="stylesheet" type="text/css">
 
 <title>Banco de Pesquisas</title>
 
<script src="js/w3.js"></script>
<script>
	function getResearch(sh, st) {
		var url = "mvc?logic=SearchResearchLogic";
		$.post(url,{search: sh, status: st},function(data){
			if(data.indexOf("del") !== -1 ) {
				$("#research").html(data);
			} else {
				$("#research").html("Nenhum pesquisa aqui...");
			}
		});
	};
	
	window.onload = getResearch("", "1");
</script>

</head>
<body>
		
	<div id="principal">
	
		<div id="topo">
			Banco de Pesquisas
		</div>
		
		<div id="menu">
			<div w3-include-html="page/menu.jsp"></div> 
	
			<script>
				w3.includeHTML();
			</script>
		</div>
		
		<div id="busca">		
			<form id="form_search" action="mvc?logic=SearchResearchLogic" method="post">  
				<input type="text" name="search" autofocus="autofocus" autocomplete="off" placeholder="Busque aqui..." id="home_cs">
				<input type="checkbox" name="status" value="0" class="a" id="status"><label for="status" title="Incluir Desativadas"></label>
				<input type="submit" value="Pesquisar" id="home_bs" class="a">
				<input type="button" value="+" id="home_add" class="a" onClick="location.href='mvc?logic=ViewQuestionBaseLogic'">						
			</form>		
		</div>
		
		<div id="meio">			
			<form id="resultForm" action="" method="post"> 
		
		    	<div id="research">
		    		<!-- SHOW RESULTS HERE  -->
		        </div>	
			        
			</form>
		</div>
	</div>


	<script>
		$("#form_search").submit(function( event ) {
		  event.preventDefault();
		 
		  var $form = $( this ),
		    fSearch = $form.find( "input[name='search']" ).val(),
		    fStatus= "1";
		    
			if($("#status").is(':checked')) {
				fStatus = "0";
			}
			getResearch(fSearch, fStatus);
		 	//	$form[0].reset();
		});	
	</script>

</body>
</html>