<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="pt-br">

<body>

<script>

function statusOn(s, id){
	var r = confirm("Realmente deseja mudar o estado dessa pesquisa?");
	var elementStatus = document.getElementById('status').value;
	if(r == true && s == 1) {
		$.post('mvc?logic=ChangeStatusResearchLogic',{'id':id, 'status':0},function(rsp){
		
		});
		$("#status"+id).val("ativar");
		document.getElementById("status"+id).onclick = function() {statusOn(0,id)};
		$.toast("Pesquisa desativa",{'type': 'success'});
		return false;
	}
	if(r == true && s == 0) {
		$.post('mvc?logic=ChangeStatusResearchLogic',{'id':id, 'status':1},function(rsp){
			
		});
		$("#status"+id).val("desativar");
		document.getElementById("status"+id).onclick = function() {statusOn(1,id)};
		$.toast("Pesquisa ativada",{'type': 'success'});
		return false;
	}
};
function del(id){
	var r = confirm("Realmente deseja excluir essa pesquisa?");
	if(r == true) {
		$.post('mvc?logic=DeleteResearchLogic',{'id':id},function(rsp){
		});
		$("#div_research_" + id).remove();
		$("#tr_research_" + id).remove();
		$.toast("Pesquisa excluida",{'type': 'success'});
		return false;
	}
};

function done(id){
		$.post('mvc?logic=UpdateResearchCalculationLogic',{'id':id},function(data){
			if(data == "empty") {
				$.toast("Pesquisa sem dados não pode ser finalizada",{'type': 'info'});	
			} else {
				var r = confirm("Realmente deseja finalizar essa pesquisa?");
				if(r == true) {
					$.post('mvc?logic=UpdateResearchCalculationLogic',{'id':id},function(data){
						if(data == "ok") {
							$("#final").remove();
							$.toast("Pesquisa Finalizada",{'type': 'success'});	
						}
					});
				}		
			}
		});
		return false;
};

function datas(rsId, rsAmount){
	$.post('mvc?logic=ViewAddDataResearchLogic',{id_research: rsId, amount: rsAmount},function(data){
		if(data == "error") {
			$.toast("Essa pesquisa já foi finalizada",{'type': 'success'});
		} else {
			window.location.href = "mvc?logic=ViewAddDataResearchLogic&id_research=" + rsId + "&amount=" + rsAmount;	
		}
	});
	return false;
};

function report(rsId){
	$.post('mvc?logic=GenerateReportLogic',{id_research : rsId},function(data){
		if(data == "error") {
			$.toast("Ainda não foram lançados dados para essa pesquisa",{'type': 'success'});
		} else {
			window.open("mvc?logic=GenerateReportLogic&id_research=" + rsId, '_blanck');	
		}
	});
	return false;
};

function edit(rsId){
	location.href = 'mvc?logic=EditResearchLogic&id_research=' + rsId;
};

</script>
       
	<c:forEach var="rs" items="${researchs}" varStatus="status">
			
		<div id="div_research_${rs.id}">
			
			<input type="text" id="p" name="research" value="${rs.research}" readonly class="a">
			<input type="button" value="Lançar Dados" onClick="datas(${rs.id},0)" class="a"/>
			<input type="button" value="Lançar Um" onClick="datas(${rs.id},1)" class="a"/>
			<input type="button" value="Editar" onclick="edit(${rs.id})" class="a"/>
			<input type="button" value="Relatório" onclick="report(${rs.id})" class="a">
			
			<c:if test="${rs.calculation ne 'Consolidado'}">
				<input type="button" value="Finalizar" onclick="done(${rs.id})" class="a">
			</c:if>
	
			<c:if test="${rs.status == 0}">
				<input type="button" id="status${rs.id}" value="Ativar" onclick="statusOn(${rs.status},${rs.id})" class="a">
			</c:if>
			
			<c:if test="${rs.status == 1}">
				<input type="button" id="status${rs.id}" value="Desativar" onclick="statusOn(${rs.status},${rs.id})" class="a">
			</c:if>
	
			<input type="button" value="Excluir" onclick="del(${rs.id})" class="a">
			
		</div>
		
	</c:forEach>

</body>
</html>