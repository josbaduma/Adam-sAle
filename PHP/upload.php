<?php 
var_dump($_POST);
var_dump($_GET);
$list = $_POST["card"];
$ju = $_POST["muu"];

echo "\n\n";

if(isset($ju)){
	echo "Victory\n";
}
else{
	echo "Sigue intentándolo\n";
}

if (isset($list))
{
	$i = 0;
	$size = sizeof($list);
	$flag = true;
	while($i < $size && $flag){
		$j = $i + 1;
		while($j < $size && $flag){
			if ($list[$i] == $list[$j]){
				$flag = false;
			}
			$j++;
		}
		$i++;
	}
	
	if(!$flag){
		echo "Hay horarios iguales!";
		
	}
	else{
		echo "No problem here!";
	}
}
else{
// 	echo 
}
?>