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
				// 				$query = "SELECT p.Cedula, c.NombreCurso, cu.CodigoCurso, cu.NombreCurso FROM Persona p INNER JOIN PreMatriculaEstudiante pe ON pe.PersonaId=p.PersonaId INNER JOIN Prematricula pr ON pr.PrematriculaId=pe.PrematriculaId INNER JOIN Curso cu ON cu.CursoId=pr.CursoId INNER JOIN  Requisitos r ON r.CursoId=cu.CursoId INNER JOIN Curso c ON c.CursoId=r.CursoRequisitoId INNER JOIN Matricula m ON m.PersonaId=p.PersonaId INNER JOIN Oferta o ON o.OfertaId=m.OfertaId INNER JOIN Estados e ON e.EstadoId=m.EstadoId WHERE e.Nombre='Aprobado' AND p.Cedula='".$_SESSION["cedula"]."' GROUP BY cu.NombreCurso";
				// 				if ($row = mysql_fetch_array($result)){
				// 					echo "<table border = '1'> \n";
				// 					echo "<tr><td>Código Curso</td><td>Nombre Curso</td></tr> \n";
				// 					do {
				// 						echo "<tr><td>".$row["CodigoCurso"]."</td><td>".utf8_encode($row["NombreCurso"])."</td></tr> \n";
				// 					} while ($row = mysql_fetch_array($result));
				// 					echo "</table> \n";
				// 				} else {
				//
				// 				}
// 				$query = "SELECT Persona.Cedula,Curso.CodigoCurso,Curso.NombreCurso,Curso.Creditos,Horario.HorarioCurso,Horario.PersonasMatriculadas FROM Persona INNER JOIN PreMatriculaEstudiante,Prematricula,Curso,Horario WHERE Persona.PersonaId = PreMatriculaEstudiante.PersonaId AND PreMatriculaEstudiante.PrematriculaID = Prematricula.PrematriculaId AND Prematricula.CursoId = Curso.CursoId AND Curso.CursoId = Horario.CursoId AND Persona.Cedula = '".$_SESSION["cedula"]."'";
				$query = "SELECT Persona.Cedula,Curso.CodigoCurso,Curso.NombreCurso,Curso.Creditos,Hora.Hora,Horario.PersonasMatriculadas FROM Persona INNER JOIN PreMatriculaEstudiante,Prematricula,Curso,Horario,Hora WHERE Persona.PersonaId = PreMatriculaEstudiante.PersonaId AND PreMatriculaEstudiante.PrematriculaID = Prematricula.PrematriculaId AND Prematricula.CursoId = Curso.CursoId AND Curso.CursoId = Horario.CursoId AND Horario.HorarioId = Hora.HorarioId AND Persona.Cedula = '".$_SESSION["cedula"]."'";
				$result = mysql_query($query);

				if ($row = mysql_fetch_array($result)){
				echo "<table border = '1'> \n";
				echo "<tr><td><b>Código Curso</b></td><td><b>Nombre Curso</b></td><td><b>Horario</b></td><td><b>Personas matriculadas</b></td></tr>";
				while($array= mysql_fetch_array($result))

				{
					echo "<tr>
						<td>".$array['CodigoCurso']."</td>".
						"<td align='left'>"."<input type='checkbox' name='card[]' value='".$array['NombreCurso']."' nonchecked>".utf8_encode($array['NombreCurso'])."</td>".
						"<td>".$array['Hora'].
						"<td>".$array['PersonasMatriculadas']. "</td>".
						"</tr>";
				}

				echo "</table> \n";
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
