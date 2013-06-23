
<?php

$cedula = $_POST["cedula"];
$password = $_POST["password"];

function conect()
{
	if(!$conection = mysql_connect("localhost", "root", "J0s3D4n13l"))
	{
		echo "Error de conexión";
		exit();
	}
	if(!mysql_select_db("mydb", $conection))
	{
		echo "Error de base de datos";
		exit();
	}
	return $conection;
}

$con = conect();
$query = "SELECT Cedula FROM Persona WHERE Cedula = '".$cedula."'";
$querySQL = mysql_query($query,$con);
try{
	if(mysql_result($querySQL, 0))
	{
		$result = mysql_result($querySQL, 0);
		echo "Usuario validado";
		header("Location: ../HTML/inicio.html");
	}else{
		echo "Usario o password incorrecto.";
	}
}catch(Exception $error){
}
mysql_close($conect);

?>