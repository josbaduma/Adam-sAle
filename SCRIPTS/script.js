$(document).on("ready", configureApp);

function configureApp() {
	var canvas = document.getElementById("footerCanvas");
	var context = canvas.getContext("2d");
	canvas.width = screen.availWidth;
	drawFooter(canvas, context);
}

function drawFooter(canvas, context) {
	context.fillStyle = "rgba(0,0,0,0.8)";
	context.moveTo(0,0);
	context.quadraticCurveTo(0, -40,canvas.width-100, canvas.height-50);
	context.fill();
}