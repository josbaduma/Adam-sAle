<!DOCTYPE html>
<html>
<head>
<link href="../CSS/StyleSheet.css" rel="stylesheet" type="text/css" />
<link href='http://fonts.googleapis.com/css?family=Peralta' rel='stylesheet' type='text/css'>
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
					<li><a href='inicio.html'>Inicio</a></li>
					<li><a href='../PHP/prematricula.php'>Prematricula</a></li>
					<li><a href='cursos.html'>Cursos</a></li>
					<li><a href='rendimiento.html'>Rendimiento Académico</a></li>
					<li><a href='../PHP/index.php'>Salir</a></li>
				</ul>
			</nav>
		</header>
		<section>
			<div id="Content">
				<hgroup>
					<h1>Prematricula</h1>
				</hgroup>
				<?php 
				$connection = mysql_connect("localhost", "root","J0s3D4n13l");
				mysql_select_db("mydb", $connection);
				$result = mysql_query("SELECT c.CodigoCurso, c.NombreCurso, e.Nombre FROM Curso INNER JOIN Curso ON c.EscuelaId = e.EscuelaId", $connection);
				if ($row = mysql_fetch_array($result)){
					echo "<table border = '1'> \n";
					echo "<tr><td>Nombre</td><td>E-Mail</td></tr> \n";
					do {
						echo "<tr><td>".$row["nombre"]."</td><td>".$row["email"]."</td></tr> \n";
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