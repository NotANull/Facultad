program ejercicio1;

const

	valorAlto = 'ZZZZ';

type

	str4 = String[4];

	empleado = record
		codigoEmpleado: str4;
		nombre: String[30];
		montoComision: real;
	end;

	acumulado = record
		codigoEmpleado: str4;
		montoComisionTotal: real;
	end;

	maestro = file of acumulado;
	detalle = file of empleado;

procedure leer(var archivoD: detalle; var regD: empleado);
begin

	if(not eof(archivoD)) then
		read(archivoD, regD)
	else
		regD.codigoEmpleado:= valorAlto;

end;

procedure crearArchivoDetalle(var archivoD: detalle);
var
	e: empleado;

begin

	rewrite(archivoD);

	write('Código de empleado: ');
	readln(e.codigoEmpleado);

	while(e.codigoEmpleado <> 'ZZZZ') do begin

		with e do begin

			write('Nombre del empleado: ');
			readln(nombre);
			write('Monto de la comisión: ');
			readln(montoComision);

			write(archivoD, e);

			writeln;
			write('Código de empleado: ');
			readln(codigoEmpleado);

		end;

	end;

	close(archivoD);

end;

procedure mostrarArchivoMaestro(var archivoM: maestro);
var
	a: acumulado;

begin

	reset(archivoM);

	while(not eof(archivoM)) do begin

		read(archivoM, a);

		with a do begin

			writeln('Código de empleado: ', codigoEmpleado);
			writeln('Monto TOTAL de la comisión: ', montoComisionTotal:3:2);

			writeln;

		end;

	end;

	close(archivoM);

end;

var

	archivoM: maestro;
	archivoD: detalle;
	regM: acumulado;
	regD: empleado;

begin
	
	assign(archivoM, 'ArchivoM_Ejercicio1');
	assign(archivoD, 'ArchivoD_Ejercicio1');

	//crearArchivoDetalle(archivoD); //Solo de prueba

	reset(archivoD);
	rewrite(archivoM);

	leer(archivoD, regD);

	while(regD.codigoEmpleado <> valorAlto) do begin

		regM.codigoEmpleado:= regD.codigoEmpleado;
		regM.montoComisionTotal:= 0;

		while(regM.codigoEmpleado = regD.codigoEmpleado) do begin

			regM.montoComisionTotal:= regM.montoComisionTotal + regD.montoComision;
			leer(archivoD, regD);

		end;

		write(archivoM, regM);

	end;

	close(archivoM);
	close(archivoD);

	//mostrarArchivoMaestro(archivoM); //Solo de prueba

	writeln('Programa Terminado');

end.