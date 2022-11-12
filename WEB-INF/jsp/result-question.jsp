<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="pt-br">

<body>

<script>
function statusOn(s, id){
	var r = confirm("Realmente deseja mudar o estado dessa questão?");
	if(r == true && s == 1) {
		$.post('mvc?logic=ChangeStatusQuestionLogic',{'id':id, 'status':0},function(rsp){
			
		});
		$("#status"+id).val("ativar");
		document.getElementById("status"+id).onclick = function() {statusOn(0,id)};
		$.toast("Questão desativa",{'type': 'success'});
		return false;
	}
	if(r == true && s == 0) {
		$.post('mvc?logic=ChangeStatusQuestionLogic',{'id':id, 'status':1},function(rsp){
			
		});
		$("#status"+id).val("desativar");
		document.getElementById("status"+id).onclick = function() {statusOn(1,id)};
		$.toast("Questão ativada",{'type': 'success'});
		return false;
	}
};
function del(id){
	var r = confirm("Realmente deseja excluir essa opção?");
	if(r == true) {
		$.post('mvc?logic=DeleteQuestionLogic',{'id':id},function(rsp){
			
		});
		$.toast("Questão excluida",{'type': 'success'});
		$("#div_question_" + id).remove();
		$("#tr_question_" + id).remove();
		return false;
	}
};
</script>

	<form id="resultForm" action="mvc?logic=AddResearchLogic" method="post">
		<c:forEach var="q" items="${questions}" varStatus="status">            
			<div id="div_question_${q.id}">
				
				<span>
					<input type="checkbox" name="id${q.id}" id="id${q.id}" value="${q.id}"><label for="id${q.id}" title="${q.question}"></label>
				</span>
				
				<input type="text" name="question" value="${q.question}" readonly class="a">  
				<input type="button" value="Editar" onClick="location.href='mvc?logic=ViewEditQuestionLogic&id=${q.id}'" class="a"/>
			
			<c:if test="${q.status == 0}">
				<input type="button" id="status${q.id}" value="Ativar" onclick="statusOn(${q.status},${q.id})" class="a">
			</c:if>
			
			<c:if test="${q.status == 1}">
					<input type="button" id="status${q.id}" value="Desativar" onclick="statusOn(${q.status},${q.id})" class="a">
			</c:if>
			
				<input type="button" value="Excluir" onclick="del(${q.id})" class="a">
			</div>
		</c:forEach>  
  
		<c:if test="${not empty questions}">
			<hr style="border: 0.3px solid #999;">
			<h3>Informações da Pesquisa</h3> 
			
			<input type="text" name="search_name" autocomplete="off" placeholder="Nome da pesquisa" required="required" class="a t">
			<input type="text" name="objetive" autocomplete="off" placeholder="Objetivo" required="required" class="a t">
			<input type="submit" id="home_bs" value="Nova pesquisa" class="a">&nbsp;&nbsp;&nbsp;
			
			<input type="button" id="active" value="Ativar" class="a">&nbsp;&nbsp;&nbsp;
			<input type="button" id="inactive" value="Desativar" class="a">&nbsp;&nbsp;&nbsp;
			<input type="button" id="delete" value="Excluir" class="a">
 			
		</c:if>
	</form>	

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

function getChecked() {
 	var ids = [];
    $('#resultForm input:checked').each(function() {
        ids.push(this.value);
    });
	return ids;
}

$('#delete').click(function() { 
	var ids = getChecked();
	if(ids.length > 0){
		var r = confirm("Todos os itens selecionados seram excluidos. Confirmar?");
		if(r == true) {
			ids.forEach(function (element, index, array) {
					$.post('mvc?logic=ChangeStatusQuestionLogic',{'id':element, 'status':0},function(rsp){
		
					});
			});
		}
		$.toast("Questões foram excluidas",{'type': 'success'});
	} else {
		$.toast("Nenhuma questão selecionada",{'type': 'info'});
	}
	getQuestions("", "1");
 });

$('#inactive').click(function() { 
	var ids = getChecked();
	if(ids.length > 0){   
		ids.forEach(function (element, index, array) {
			$.post('mvc?logic=ChangeStatusQuestionLogic',{'id':element, 'status':0},function(rsp){

			});
		});
		$.toast("Questões foram desativadas",{'type': 'success'});
	} else {
		$.toast("Nenhuma questão selecionada",{'type': 'info'});
	}
	getQuestions("", "1");
 });

 $('#active').click(function() { 
	var ids = getChecked();
	if(ids.length > 0){   
		ids.forEach(function (element, index, array) {
			$.post('mvc?logic=ChangeStatusQuestionLogic',{'id':element, 'status':1},function(rsp){

			});
		});
		$.toast("Questões foram ativadas",{'type': 'success'});
	} else {
		$.toast("Nenhuma questão selecionada",{'type': 'info'});
	}
	getQuestions("", "1");
 });

$("#resultForm").submit(function( event ) {
	  event.preventDefault();
	  
	  var $form = $( this ),
	    fSearchName = $form.find( "input[name='search_name']" ).val(),
	    fObjetive = $form.find( "input[name='objetive']" ).val(),
	    url = $form.attr( "action" );
	  	
	  	var fIds = getChecked();
	  	
	  	$.post(url,{search: fSearchName, objetive: fObjetive, ids: fIds.toString()},function(data){
			if(data == "empty") {
				$.toast("Preencha todos os campos",{'type': 'danger'});
			}
			
			if(data == "check-empty") {
				$.toast("Nenhuma questão selecionada",{'type': 'info'});
			}
			
			if(data == "ok") {
				$.toast("Pesquisa salva",{'type': 'success'});
				$("#resultForm")[0].reset();
			}
		});
});
</script>

</body>
</html>