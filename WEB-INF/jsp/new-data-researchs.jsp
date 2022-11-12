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
 <link href="css/data_researchs.css" rel="stylesheet" type="text/css">

<title>Lançar Dados</title>

<script src="js/w3.js"></script>

</head>

<body>


<div id="principal"> 

    <div id="topo">
		Lançar Dados da Pesquisa
    </div>
    
    <div id="menu">
		<div w3-include-html="page/menu.jsp"></div> 

		<script>
			w3.includeHTML();
		</script>
	</div>
	
	<div id="meio">

	    <form id="editForm" action="mvc?logic=UpdateResearchLogic" method="post">  
			
			<div id="d">
				<span id="p">Pesquisa</span>
				<input id="research" type="text" name="research" value="${rs.research}" disabled="disabled">	    
			</div>
			
			<div id="d">
				<span id="o">Objetivo</span> 
				<input id="objetive" type="text" name="objetive" value="${rs.objetive}" disabled="disabled">
			</div>
			
			<fmt:formatDate var="date" value="${rs.date.time}" pattern="dd/MM/yyyy" />	            
			
			<div id="d">
				<span id="d">Data</span>
				<input id="date" type="text" name="date" value="${date}" disabled="disabled">	      
			</div>
			
			<div id="d">
				<span id="a">Amostras</span>
				<input id="sample" type="text" name="sample" value="${rs.sample}" disabled="disabled">		
			</div>
			
			<div id="d">
				<span id="ap">Apuração</span>
				<input id="calculation" type="text" name="calculation" value="${rs.calculation}" disabled="disabled">
			</div>
			
			<input type="hidden" name="amount" value="${amount}"> 			
			<input type="hidden" name="id_research" value="${rs.id}" >
			
			<div id="d">
				<span id="na">Novas Amostras</span>
				<input id="samples" type="text" name="samples" placeholder="Número de Amostras" required="required" autocomplete="off">
			</div>
			
			<div id="quadro"><strong>Quadro de Questões</strong></div>
			
			<c:forEach var="q" items="${questions}">
							
				<div id="q">
					Questão: &nbsp;&nbsp;<strong>${q.question}</strong><br><br>	
					<input type="hidden" id="q${q.id}" value="${q.question}"> 			
				
					<c:forEach var="c" items="${q.choice}">		
						<input type="hidden" name="${q.id}-${c.id}" value="${q.id}-${c.id}">
						<input type="number" min="0" step="1" id="al${q.id}-${c.id}" placeholder="0" required="required" autocomplete="off">&nbsp;&nbsp; ${c.choice}<br><br>			
					</c:forEach>
				</div>
				
			</c:forEach>
			
			<div id="s">      
				<input type="submit" id="home_bs" value="Salvar" class="a">
	        </div>
	            
	    </form>    
    </div>
    
</div>

<script>

function check() {
  	console.log("Check");

 	var idQuestion = "";
	var count = 0;
	var total = 0
	var checkOk = true
		
  	$('input[type=number]').each(function() {
 		var ids = this.id.split("-")
  		idQuestion = ids[0]
 		
 		total = 0
 		$('input[type=number]').each(function() {
 	 		var ids2 = this.id.split("-")
 			if(idQuestion == ids2[0]) {
 				total = total + parseInt(this.value);
 			}
 		});
 				
 		if(total != parseInt($("#samples").val())) {
			id =  idQuestion.split("al")
			
 	 		$.toast("Valores errados para a questão " + $("#q"+id[1]).val());
			checkOk = false
 		}
 		

    });
	return checkOk;
  	
}

$("#editForm").submit(function( event ) {
	  event.preventDefault();
	  
	  var $form = $( this ),
	    fIdR = $form.find( "input[name='id_research']" ).val(),
	    fAmount = $form.find( "input[name='amount']" ).val(),
	    fSamples = $form.find( "input[name='samples']" ).val(),
	    url = $form.attr( "action" );
	  
	  	var fIds = [];
	    var fValues = [];
	    
	  	$('#editForm input:hidden').each(function() {
	    	if(this.value.indexOf("-") !== -1) {
	    		fIds.push(this.value);
	    		fValues.push($("#al"+this.name).val());
	    	}    	
	    });
	  	
	  	console.log("Submit");
		
		  	
 	  	 if(check()) {
	  	  	$.post(url,{id_research: fIdR, ids: fIds.toString(), amount: fAmount,
		  		values: fValues.toString(), samples: fSamples},function(data){
		  	
				if(data == "ok" || data == "ok-up") {
					$.toast("Dados da pesquisa atualizados",{'type': 'success'});
					$form.trigger('reset');
					$("#samples").focus();
				}
				if(data == "error") {
					$.toast("Valores de amostras incorretos",{'type': 'danger'});
				}
				
				if(data == "zero") {
					$.toast("O número de amostra não pode ser Zero",{'type': 'danger'});
				}
				
			});
	  	} 
});

</script>

</body>
</html>