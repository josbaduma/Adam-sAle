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
		</header>
		<section>
			<div id="Content">
				<h2>Bienvenidos</h2>
				<form action="conection.php" method="POST">
					<i>Cédula:</i>
					<p>
						<input type="text" name="cedula" size="20" />
					</p>
					<i>Contraseña:</i>
					<p>
						<input type="password" name="password" size="20" />
					</p>
					<p>
						<input type="submit" value="Log In" id="btnSubmit" />
					</p>
				</form>
			</div>
		</section>
	</div>
	<footer>
		<canvas id="footerCanvas"></canvas>
	</footer>
</body>
</html>
