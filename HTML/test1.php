<?php
$con = mysql_connect("localhost","root","");
if (!$con) {
	die('Could not connect: ' . mysql_error());
}
else {
	mysql_select_db("mydb", $con);
}
if(isset($_POST['team'])) {
	foreach($_POST['team'] as $value) {
		$insert="INSERT INTO team ('team') VALUES ('$value')";
		// 		echo $insert;
		// 		mysql_query($insert);
		$query="SELECT Persona.Cedula,Curso.CodigoCurso,Curso.NombreCurso,Curso.Creditos,Horario.HorarioCurso,Horario.PersonasMatriculadas FROM Persona INNER JOIN PreMatriculaEstudiante,Prematricula,Curso,Horario WHERE Persona.PersonaId = PreMatriculaEstudiante.PersonaId AND PreMatriculaEstudiante.PrematriculaID = Prematricula.PrematriculaId AND Prematricula.CursoId = Curso.CursoId AND Curso.CursoId = Horario.CursoId AND Persona.Cedula = 304630535";
		$result=mysql_query($query);
		// 		$num=mysql_numrows($result);mysql_close();
		// 		echo "
		// 				<b><center>Database Output</center></b>
		// 				<br>
		// 				<br>";
		// 		$i=0;
		// 		while ($i < $num) {
		// 			$field1=mysql_result($result,$i,"CodigoCurso");
		// 			$field2=mysql_result($result,$i,"NombreCurso");
		// 			$field3=mysql_result($result,$i,"EscuelaId");
		// 			echo " <b>$field1 $field2 $field3</b>
		// 			<br>";$i++;
		// 		}
		// 	}


		// 	$query="select CardID, CardName from cards_tbl";

		// 	$result=mysql_query($query);



		//$rescardq="select CardID from restcards_tbl where RestID=$restid";

		//$rescardsr=mysql_query($rescardq);


		// Selecciona los checkbox desde la base de datos
		echo "<table border = '1'> \n";
		echo "<tr><td>Código Curso</td><td>Nombre Curso</td><td>Horario</td></tr>";
		while($array= mysql_fetch_array($result))

		{
			// 			$field1 = $array['CodigoCurso'];
			
			
			echo "<tr>
					<td>".$array['CodigoCurso']."</td>".
					"<td>"."<input type='checkbox' name='card[]' value='".$array['NombreCurso']."' nonchecked>".utf8_encode($array['NombreCurso'])."</td>".
					"<td>".$array['HorarioCurso']. "</td>".
					"</tr>";
		}
		
		echo "</table> \n";
		echo "<b>FIN</b>\n";
	}
}?>