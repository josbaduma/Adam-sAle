
<?php

session_start();

$cedula = strip_tags($_POST["cedula"]);
$password = strip_tags($_POST["password"]);

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
echo $cedula."<br></br>";
echo $password."<br></br>";
$result = mysql_query('SELECT * FROM Persona WHERE Cedula="'.mysql_real_escape_string($cedula).'" AND Clave="'.mysql_real_escape_string($password).'"');
try{
	if(mysql_fetch_object($result))
	{
		echo "Usuario validado";
		$_SESSION['logged'] = 'yes';
		$_SESSION['cedula'] = $cedula;
		header("Location: ../PHP/inicio.php");
	}else{
		echo "Usuario o password incorrecto.";
	}
}catch(Exception $error){
}
mysql_close($conect);
?>