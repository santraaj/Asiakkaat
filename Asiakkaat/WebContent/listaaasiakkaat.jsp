<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel = "stylesheet" type = "text/css" href = "css/main.css">
<title>Asiakaslistaus</title>
</head>
<body>
<table id = "listaus">
	<thead>
		<tr>
			<th colspan = "5" class = "oikealle"><span id = "uusiAsiakas">Lis�� uusi asiakas</span></th>
		</tr>
		<tr>
			<th	class = "oikealle">Hakusana:</th>
			<th class = "vasemmalle" colspan = "3"><input type = "text" id = hakusana></th>
			<th class = "vasemmalle"><input type = "button" value = "Hae" id = "haku"></th>
		</tr>
		<tr>
			<th class = "vasemmalle">Etunimi</th>
			<th class = "vasemmalle">Sukunimi</th>
			<th class = "vasemmalle">Puhelin</th>
			<th class = "vasemmalle">Sposti</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
	</tbody>	
</table>
<script>
$(document).ready(function() {
	
	$("#uusiAsiakas").click(function() {
		document.location = "lisaaasiakas.jsp";
	});
	
	haeAsiakkaat();
	$("#haku").click(function() {
		haeAsiakkaat();
	});
	
	$(document.body).on("keydown", function(event) {
		if(event.which==13) {
			haeAsiakkaat();
		}
	});
	
	$("#hakusana").focus();
//		haeAsiakkaat();
});

function haeAsiakkaat() {
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result) {
		$.each(result.asiakkaat, function(i, field) {
			var htmlStr;
			htmlStr+="<tr id='rivi_"+field.asiakas_id+"'>";
			htmlStr+= "<td>" + field.etunimi + "</td>";
			htmlStr+= "<td>" + field.sukunimi + "</td>";
			htmlStr+= "<td>" + field.puhelin + "</td>";
			htmlStr+= "<td>" + field.sposti + "</td>";
			htmlStr+="<td><span class='poista' onclick=poista('"+field.asiakas_id+"')>Poista</span></td>";
			htmlStr+= "</tr>";
			$("#listaus tbody").append(htmlStr);
		});
	}});
}

function poista(asiakas_id) {
	if(confirm("Poista asiakas " + asiakas_id + "?")) {
		$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) { 
	        if(result.response==0) {
	        	$("#ilmo").html("Asiakkaan poisto ep�onnistui.");
	        } else if(result.response==1){
	        	$("#rivi_" + asiakas_id).css("background-color", "red");
	        	alert("Asiakkaan " + asiakas_id + " poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
}
</script>
</body>
</html>