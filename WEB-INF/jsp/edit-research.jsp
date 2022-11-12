<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
 <link href="css/data_research.css" rel="stylesheet" type="text/css">
 
<title>Editar Pesquisa</title>

<script src="js/w3.js"></script>

</head>
<body>

<div id="principal"> 

    <div id="topo">
		Editar Dados da Pesquisa
    </div>
    
    <div id="menu">
		<div w3-include-html="page/menu.jsp"></div> 

		<script>
			w3.includeHTML();
		</script>
	</div>

	<div id="meio">
	
		<form id="editForm" action="mvc?logic=EditResearchLogic" method="post"> 
		 
			<div id="d">
	         	<span id="p">Pesquisa</span>
	        	<input id="research" type="text" name="research" value="${rs.research}"  required="required">
		    </div>
			
			
			<div id="d">
	         	<span id="o">Objetivo</span>
	        	<input id="objective" type="text" name="objective" value="${rs.objetive}" required="required">
		    </div>					
						
			<fmt:formatDate var="date" value="${rs.date.time}" pattern="dd/MM/yyyy" />
			
			<div id="d">
	         	<span id="d">Data</span> 
	         	<input type="text" id="date" name="date" value="${date}" disabled="disabled">
		    </div>
			
			<div id="d">
	         	<span id="a">Amostras</span>
	         	<input id="sample" type="text" name="sample" value="${rs.sample}" disabled="disabled">
		    </div>
			
			<div id="d">
	         	<span id="ap">Apuração</span>
	         	<input id="calculation" type="text" name="calculation" value="${rs.calculation}" disabled="disabled">
		    </div>
		    
		    <div id="quadro"><strong>Quadro de Questões</strong></div>
		    
			<c:forEach var="q" items="${questions}">			
				<div id="q">			
					Questão : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="question" name="${q.id}" value="${q.question }" required="required" ><br><br>
				
					<c:forEach var="c" items="${q.choice}">
						<input type="hidden" value="${c.id}">	          
						Alternativa : <input type="text" id="a${c.id}" value="${c.choice}" required="required"><br><br>
					</c:forEach>
				</div>				
			</c:forEach>			
			
			<div id="s">
	         	<input type="submit" id="home_bs" value="Salvar" class="a">
	         	<input type="hidden" name="id_research" value="${rs.id}">
	         </div>
		        
		</form>
    </div>
    
</div>


<script>
$("#editForm").submit(function( event ) {
	  event.preventDefault();
	  	  
	  var $form = $( this ),
	    fIdR = $form.find( "input[name='id_research']" ).val(),
	    fObjective = $form.find( "input[name='objective']" ).val(),
	    fResearch = $form.find( "input[name='research']" ).val(),
	    url = $form.attr( "action" );
	  
	  	var fIdsChoice = [];
	    var fChoices = [];

	  	var fIdsQuestion = [];
	    var fQuestions = "";
	    
	  	$('#editForm input:text').each(function() {
	    	if(this.id == "question") {
	    		fIdsQuestion.push(this.name);
	    		fQuestions+=this.value + "@//";
	    		//alert(this.name + " - " + this.value);
	    	}
	    });
	  	
	  	
	  	$('#editForm input:hidden').each(function() {
	    	if(this.name !== "id_research") {
	    		fIdsChoice.push(this.value);
	    		fChoices+=$("#a"+this.value).val() + "@//";
	    		//alert($("#a"+this.value).val() + " - " + this.value);
	    	}    	
	    });
	  	
	  	$.post(url,{id_research: fIdR, ids_choices: fIdsChoice.toString(),
				choices: fChoices, questions: fQuestions,
				ids_questions: fIdsQuestion.toString(), research: fResearch,
				objective: fObjective},function(data){
	  	
			if(data == "ok" || data == "ok-up") {
				$.toast("Dados da pesquisa atualizados",{'type': 'success'});
			}
			if(data == "error") {
				$.toast("Valores de amostras incorretos",{'type': 'danger'});
			}
			
		});
});

</script>

</body>
</html>