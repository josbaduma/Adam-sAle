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
					<h2>Rendimiento Académico</h2>
				</hgroup>
				<p>Esta información contiene su rendimiento académico en los
					distintos cursos matriculados.</p>
				<?php
				session_start();
				$connection = mysql_connect("localhost", "root","J0s3D4n13l");
				mysql_select_db("mydb", $connection);
				$result = mysql_query("SELECT c.CodigoCurso, c.NombreCurso, m.Nota, e.Nombre FROM Persona p INNER JOIN Matricula m ON p.PersonaId = m.PersonaId INNER JOIN Oferta o ON o.OfertaId = m.OfertaId INNER JOIN Curso c ON c.CursoId = o.OfertaId INNER JOIN Estados e ON e.EstadoId = m.EstadoId WHERE p.Cedula='".$_SESSION['cedula']."'", $connection);
				if ($row = mysql_fetch_array($result)){
					echo "<table border = '1'> \n";
					echo "<tr><td>Código Curso</td><td>Nombre Curso</td><td>Nota</td><td>Estado</td></tr> \n";
					do {
						echo "<tr><td>".$row["CodigoCurso"]."</td><td>".utf8_encode($row["NombreCurso"])."</td><td>".$row["Nota"]."</td><td>".$row["Nombre"]."</td></tr> \n";
					} while ($row = mysql_fetch_array($result));
					echo "</table> \n";
					$result = mysql_query("SELECT AVG(m.Nota) AS Promedio FROM Persona p INNER JOIN Matricula m ON p.PersonaId = m.PersonaId INNER JOIN Oferta o ON o.OfertaId = m.OfertaId INNER JOIN Curso c ON c.CursoId = o.OfertaId INNER JOIN Estados e ON e.EstadoId = m.EstadoId WHERE p.Cedula='".$_SESSION['cedula']."'", $connection);
					$row = mysql_fetch_array($result);
					echo "<p>Promedio: ".$row["Promedio"];
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
