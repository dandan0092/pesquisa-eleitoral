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
	
			<input type="hidden" name="amount" value="${amount}" > 			
			<input type="hidden" name="id_research" value="${rs.id}" >
				        
	        <div id="quadro"><strong>Quadro de Questões</strong></div>
	          
			<c:forEach var="q" items="${questions}">				
				<div id="q">
					Questão: &nbsp;&nbsp;<strong>${q.question}</strong><br><br>
				 
					<c:forEach var="c" items="${q.choice}">
						<input type="radio" name="alter${q.id}" id="${c.id}" value="${q.id}-${c.id}" required class="a"><label for="${c.id}" class="quest">${c.choice}</label><br><br>	          	  
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
function getChecked() {
 	var ids = [];
    $('#editForm input:checked').each(function() {
    	ids.push(this.value);
    });
	return ids;
}


$("#editForm").submit(function( event ) {
	  event.preventDefault();
	  
	  var $form = $( this ),
	    fIdR = $form.find( "input[name='id_research']" ).val(),
	    fAmount = $form.find( "input[name='amount']" ).val(),
	    url = $form.attr( "action" );
	  	
	  	var fIds = getChecked();
	  		  	
	  	$.post(url,{id_research: fIdR, ids: fIds.toString(), amount: fAmount},function(data){
	  		if(data == "ok-up" || data == "ok") {
	  			$.toast("Dados da pesquisa atualizados",{'type': 'success'});
	  			$form.trigger('reset');
			}
			
			if(data == "error") {
				$.toast("É preciso marca uma alternativa para cada questão",{'type': 'danger'});
			}
		});
});

</script>

</body>
</html>