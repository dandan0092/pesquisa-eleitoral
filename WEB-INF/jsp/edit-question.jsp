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
 <link href="css/add_questao.css" rel="stylesheet" type="text/css">

<title>Questão</title>

<script src="js/w3.js"></script>

</head>

<body>

<div id="principal">

	<div id="topo">
		Cadastrar Questão
    </div>
    
    <div id="menu">
		<div w3-include-html="page/menu.jsp"></div> 

		<script>
			w3.includeHTML();
		</script>
	</div>
	
	<div id="meio">	  		
		
		<form id="question_form" action="mvc?logic=EditQuestionLogic" method="post">
		
			<div id="d">
			    Questão: &nbsp;&nbsp;&nbsp;&nbsp;
			    <input type="text" id="question" name="question" autofocus="autofocus" required="required" value="${q.question}" class="a">			    
			</div>
			  
			<c:forEach var="c" items="${choices}">
			  <div id="d">
			    Alternativa:
			    <input type="text" id="alter${c.id}" name="alter${c.id}" required="required" value="${c.choice}" class="a">
			  </div>
			</c:forEach>	
			
			<fieldset id="inputs_adicionais"></fieldset>
			   
			<input type="hidden" name="id" id="id" value="${q.id}">
			
			<c:if test="${q.id eq '0'}">
				<input type="button" name="add" value="Add Alternativa" class="a"/>&nbsp;&nbsp;&nbsp;
				<input type="button" onClick="clearForm()" value="Limpar" class="a">&nbsp;&nbsp;&nbsp;
			</c:if>
			
			<input type="submit" id="home_bs" value="Salvar" class="a">
		                    
	  </form>
	  <input type="hidden" id="id_choice" value="${id_choice}">
		
	</div>
  
  
<script>
function clearForm() {
	document.getElementById("question_form").reset();
}


$(document).ready(function(){  
	var cont = 2;
    $("input[name='add']").click(function( e ){
    	var input = '<div id="d1">Alternativa: <input type="text" id="alter' + cont + '" name="alter' + cont + '" required="required"/> <a href=# class="a" id="remove">remover</a></div>';
    	$('#inputs_adicionais').append( input );
    	cont++;
    });  
 
    $('#inputs_adicionais').delegate('a','click',function( e ){
    	cont--;
        e.preventDefault();  
        $(this).parent().remove();  
    });  
 
});


$("#question_form").submit(function( event ) {
	event.preventDefault();

	///Pegar valores dos checkboxs

  var $form = $( this ),
  	fId = $('#id').val();
    fQuestion = $form.find( "input[name='question']" ).val(),
    url = $form.attr( "action" );
    
    var fAlters = '';
    var fIds_alter = [];
    var id_choice = $("#id_choice").val();

    while(true) {
    	if($("#alter"+ id_choice).val() == null) {
    		break;
    	}
    	fIds_alter.push(id_choice);
    	fAlters+=$("#alter"+ id_choice).val() + "@//";
    	id_choice++;
    }
    
  	$.post(url,{id: fId, question: fQuestion, alters: fAlters, ids_alter: fIds_alter.toString()},function(data){
 	//alert(data);
 			if(data == "empty") {
 				$.toast("Preencha todos os campos",{'type': 'danger'});
			}
						
			if(data == "ok") {
				$.toast("Dados salvos",{'type': 'success'});
				$form.trigger('reset');
				$('#inputs_adicionais').html("");
				$("#question").focus();
			}
			
			if(data == "ok-up") {
				$("#question").focus();
				$('#inputs_adicionais').html("");
				$.toast("Dados salvos",{'type': 'success'});
			}
 	}); 
 });

</script> 
    
</div>

</body>
</html>