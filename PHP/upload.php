<?php

$horario = $_POST["horario"];
$curso = $_POST["curso"];

var_dump($_POST);

function validate($pList){
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

if(isset($ju)){
	echo "Victory\n";
}
else{
	echo "Sigue intentándolo\n";
}

if (isset($horario))
{
	if(!validate($horario)){ // valida no horarios repetidos
		echo "Hay horarios repetidos";
	}
	if(!validate($curso)){ // valida cursos del mismo tipo marcados
		echo "Hay cursos del mismo tipo seleccionados";
	}
}
else{
	// 	echo
}
?>