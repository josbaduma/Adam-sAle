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
				<h1>Instituto Tecnológico de Costa Rica</h1>
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
					<h2>Cursos</h2>
				</hgroup>
				<p>
				En esta sección se muestra cursos optimos a llevar según el número de creditos que posean cada uno.
				</p>
				<?php 
				session_start();
				$connection = mysql_connect("localhost", "root","");
				mysql_select_db("mydb", $connection);
				$result = mysql_query("SELECT c.CodigoCurso, c.NombreCurso FROM Persona p INNER JOIN PreMatriculaEstudiante pr ON pr.PersonaId = p.PersonaId INNER JOIN Prematricula pe ON pe.PrematriculaId=pr.PrematriculaId INNER JOIN Curso c ON c.CursoId=pe.CursoId WHERE p.Cedula='".$_SESSION["cedula"]."' AND pe.Cantidad >= 3", $connection);
				if ($row = mysql_fetch_array($result)){
					echo "<table border = '1'> \n";
					echo "<tr><td>Código Curso</td><td>Nombre Curso</td></tr> \n";
					do {
						echo "<tr><td>".$row["CodigoCurso"]."</td><td>".utf8_encode($row["NombreCurso"])."</td></tr> \n";
					} while ($row = mysql_fetch_array($result));
					echo "</table> \n";
				} else {
					echo "¡ No se ha encontrado ningún registro !";
				}
				?>
			</div>
		</section>
	</div>
	<footer>
		<canvas id="footerCanvas"></canvas>
	</footer>
</body>
</html>
