<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script src="js/jquery.m.toast.js"></script>
<link href="css/jquery.m.toast.css" rel="stylesheet" type="text/css">
<link href="css/animation.css" rel="stylesheet" type="text/css">
<link href="css/input.css" rel="stylesheet" type="text/css">
<link href="css/dados_empresa.css" rel="stylesheet" type="text/css">

</head>
<body>

	<div id="s">
	
		<img alt="Image" src="data:image/jpeg;base64,${imgBase}" id="target" width="200" height="200">
	
		<form id="enterprise_form" action="mvc?logic=UploadImageEnterprise" method="post" enctype='multipart/form-data' onsubmit="upload();">
			<input type="file" name="photo" id="photo" class="a" accept="Image/*" onchange="showFile();" ><br>		
			<input type="submit" id="home_bs" class="a" value="Mudar Imagem">		
		</form>
	
	</div>

<script>

function upload() {
	alert("Imagem atualizada");
	//$.toast("Imagem atualizada",{'type': 'success'});
};
	
function showFile() {
	var target = document.querySelector("img");
	var file = document.querySelector("input[type=file]").files[0];
	
	var reader = new FileReader();
	
	reader.onloadend = function () {
		target.src = reader.result;
		fileBase64 = reader.result;
	}

	if(file) {
		reader.readAsDataURL(file);
	} else {
		target.scr="";
	}	
}

</script>

</body>
</html>



