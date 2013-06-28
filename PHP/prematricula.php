<!DOCTYPE html>
<html>
<head>
<link href="../CSS/StyleSheet.css" rel="stylesheet" type="text/css" />
<link href='http://fonts.googleapis.com/css?family=Peralta'
	rel='stylesheet' type='text/css'>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
<script src="../SCRIPTS/script.js"></script>
</head>
<body>
	<div id="header">
		<header>
			<hgroup>
				<h1>
					<span></span>Instituto Tecnológico de Costa Rica
				</h1>
				<h2>Prematricula</h2>
			</hgroup>
			<nav>
				<ul>
					<li><a href='inicio.php'>Inicio</a></li>
					<li><a href='prematricula.php'>Prematricula</a></li>
					<li><a href='cursos.php'>Cursos</a></li>
					<li><a href='rendimiento.php'>Rendimiento</a></li>
					<li><a href='index.php'>Salir</a></li>
				</ul>
			</nav>
		</header>
		<section>
			<div class="Content">
				<hgroup>
					<h2>Prematricula</h2>
				</hgroup>
				<p>Curso óptimos a llevar para el próximo semestre.</p>
				<?php 
				session_start();
				$connection = mysql_connect("localhost", "root","");
				mysql_select_db("mydb", $connection);
				$query = "SELECT Persona.Cedula,Curso.CodigoCurso,Curso.NombreCurso,Curso.Creditos,Hora.Hora,Horario.PersonasMatriculadas FROM Persona INNER JOIN PreMatriculaEstudiante,Prematricula,Curso,Horario,Hora WHERE Persona.PersonaId = PreMatriculaEstudiante.PersonaId AND PreMatriculaEstudiante.PrematriculaID = Prematricula.PrematriculaId AND Prematricula.CursoId = Curso.CursoId AND Curso.CursoId = Horario.CursoId AND Horario.HorarioId = Hora.HorarioId AND Persona.Cedula = '".$_SESSION["cedula"]."'";
				$result = mysql_query($query);

				if ($row = mysql_fetch_array($result)){
				echo "<form action='upload.php' method='POST'>";
				echo "<table border = '1'> \n";
				echo "<tr><td><b>Código Curso</b></td><td><b>Nombre Curso</b></td><td><b>Horario</b></td><td><b>Personas matriculadas</b></td></tr>";
				$i = 1;
				while($array= mysql_fetch_array($result))

				{
					echo "<tr>
						<td>".$array['CodigoCurso']."</td>".
						"<td align='left'>"."<input type='checkbox' name='card[]' value='".$i."' nonchecked>".utf8_encode($array['NombreCurso'])."</td>".
						"<td>".$array['Hora'].
						"<td>".$array['PersonasMatriculadas']. "</td>".
						"</tr>";
					echo $i;
				}

				echo "</table> \n";				
				echo "<p>";
				echo "<input type='submit' value='Ingresar datos' name='btnUploadData'/>";
				echo "</p>";
				echo "</form>";
			}else{
				echo "¡ No se ha encontrado ningún registro !";
			} ?>
			</div>
		</section>
	</div>
	<footer>
		<canvas id="footerCanvas"></canvas>
	</footer>
</body>
</html>
