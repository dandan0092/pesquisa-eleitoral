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
 <link href="css/dados_empresa.css" rel="stylesheet" type="text/css">
 
<title>Dados da Empresa</title>

<script src="js/w3.js"></script>

</head>

<body>

<div id="principal">

	<div id="topo">
		Dados da Empresa
    </div>
    
    <div id="menu">
		<div w3-include-html="page/menu.jsp"></div> 

		<script>
			w3.includeHTML();
		</script>
	</div>
	
	<div id="meio">	 
	
		<form id="enterprise_form" action="mvc?logic=EditEnterpriseLogic" method="post">
	
			<iframe src="mvc?logic=ViewUploadImageEnterprise"></iframe>
			<div id="d">
				<span id="n">Nome da Empresa</span>
				<input type="text" id="name" name="name" autofocus="autofocus" value="${e.name}" >
			</div> 
			
			<div id="d">     	
           		<span id="e">Endereço Completo</span>
           		<input type="text" id="address" name="address" value="${e.address}" >
			</div>
			
			<div id="d">
				<span id="t">Telefones</span>
				<input type="tel" id="phone" name="phone" value="${e.phone}" maxlength="15" title="Formato: (99) 9999-9999">
			</div>
			
			<div id="d">      
				<span id="em">E-mail</span>
			    <input type="email" id="email" name="email" value="${e.email}" >
			</div>
			
			<div id="d">
				<input id="salvar_empresa" type="submit" value="Salvar" class="a">
			</div>
			
		  </form>
	      
      </div>
      
      <div id="rodape"></div>
      
</div>

<script>
$("#enterprise_form").submit(function( event ) {
	event.preventDefault();

	///Pegar valores dos checkboxs
  var $form = $( this ),
    fName = $form.find( "input[name='name']" ).val(),
    fAddress = $form.find( "input[name='address']" ).val(),
    fPhone = $form.find( "input[name='phone']" ).val(),
    fEmail = $form.find( "input[name='email']" ).val(),
    
    url = $form.attr( "action" );
    
    $.post(url,{name: fName, address: fAddress, phone: fPhone, email: fEmail},function(data){
 	//alert(data);
 			if(data == "empty") {
 				$.toast("Preencha todos os campos",{'type': 'danger'});
			}
						
			if(data == "ok") {
				$.toast("Dados salvos",{'type': 'success'});
			}
			
			if(data == "ok-up") {
				$.toast("Dados salvos",{'type': 'success'});
			}
 	}); 
 });
</script>

</body>
</html>