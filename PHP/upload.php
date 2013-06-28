<?php
// $con=mysql_connect("localhost", "root", "", "mydb");

session_start();
$con = mysql_connect("localhost", "root","");


$info = $_POST["info"];

function validate($pList){
	var_dump($_GET);
	echo"<br/>";
	print_r($pList);
	$i = 0;

	$size = sizeof($pList);
	$flag = true;

	while($i < $size && $flag){

		$j = $i + 1;
		while($j < $size && $flag){
			if ($pList[$i] == $pList[$j]){
				$flag = false;
			}
			$j++;
		}
		$i++;
	}

	return $flag;
}

function updateDB($horario, $curso, $con){

	if (mysqli_connect_errno()){
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	else{
		mysql_select_db("mydb", $con);
		$i = 0;
		$size = sizeof($horario);
		echo "Size $size<br/><br/>";

		while($i < $size){
			echo "Horario $horario[$i] Curso $curso[$i]<br/>";
			if (is_numeric($horario[$i])) {
				echo "'$horario[$i]' is numeric", PHP_EOL;
			} else {
				echo "'$horario[$i]' is NOT numeric", PHP_EOL;
			}
				
			$query = "UPDATE Horario SET Horario.PersonasMatriculadas = Horario.PersonasMatriculadas + 1 WHERE Horario.HorarioId = '".$horario[$i]."' AND Horario.CursoId = ".$curso[$i]."";
			if(mysql_query($query, $con)){
				echo "exito<br/>";
			}
			else{
				echo "fail<br/>";
			}
			$i++;
		}
	}

	mysqli_close($con);
}

if (isset($info))
{
	$horario = array();
	$curso = array();
	$i = 0;
	foreach ($info as $value){
		$tmp = explode(".", $info[$i]);
		$horario[] = $tmp[0];
		$curso[] = $tmp[1];

		$i++;
	}

	$flag = true;
	if(!validate($horario)){ // valida no horarios repetidos
		$flag = false;
		echo "Hay horarios repetidos";
	}
	if(!validate($curso) && $flag){ // valida cursos del mismo tipo marcados
		$flag = false;
		echo "Hay cursos del mismo tipo seleccionados";
	}

	if($flag){ // todos los datos validados correctamente
		updateDB($horario, $curso, $con);
	}
}
else{
	// 	echo
}
?>