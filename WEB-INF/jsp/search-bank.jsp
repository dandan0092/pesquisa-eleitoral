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
 <link href="css/buscar_questoes.css" rel="stylesheet" type="text/css">

<script>
function getResearch() {
	var url = "mvc?logic=SearchResearchLogic";
	$.post(url,{search: "", status: "1"},function(data){
		if(data.indexOf("div_research_") !== -1 ) {
			$("#research").html(data);
		} else {		
			$("#research").html("Nenhum pesquisa aqui...");
		}
	});
};

window.onload = getResearch();

</script>
</head>

<body>
<div id="principal">
	
	<h1 style="margin-bottom:0;">. : Banco de Pesquisas : .</h1> <h3>- Busque por uma Pesquisa -</h3> <br />

	<form id="form_search" action="mvc?logic=SearchResearchLogic" method="post">  
		<table width="100%" border="0" cellspacing="3" cellpadding="5">
			<tr>
				<td><input type="text" name="search" class="entrada zerar animation250"></td>
				<td><input type="checkbox" name="status" value="0" class="checkbox" id="status"><label for="status" title="Incluir Todas"></label></td>
				<td><input type="submit" value="Pesquisar" class="botao_p zerar animation250"></td>
				<td><input type="button" value="+" class="botao_p botao_m animation250" onClick="location.href='mvc?logic=ViewQuestionBaseLogic'"></td>
				<td>&nbsp;</td>
			</tr>
		</table><br />
	</form>
	
	<form id="resultForm" action="" method="post"> 

    	<div id="research">
    		<!-- SHOW RESULTS HERE  -->
        </div>	
	        
	</form>
</div>


<script>
$("#form_search").submit(function( event ) {
  event.preventDefault();
  var $form = $( this ),
    fSearch = $form.find( "input[name='search']" ).val(),
    fStatus= "1",
    url = $form.attr( "action" );
  
	if($("#status").is(':checked')) {
		fStatus = "0";
	}
	
	$.post(url,{search: fSearch, status: fStatus},function(data){
 	//alert(data);
 	//	$form[0].reset();
		//$.toast('Empresa adicionada!');
		//$("#search").focus();
		$("#research").html(data);
		
 });
});
</script>

</body>
</html>