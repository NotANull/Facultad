program ejercicio3;

type

	empleado = record
		numEmpleado: integer;
		apellido: String[20];
		nombre: String[20];
		edad: integer;
		dni: String[8];
	end;

	archivoEmpleados = file of empleado;


procedure crearArchivo(var archivo: archivoEmpleados);

	procedure leerEmpleado(var emp: empleado);
	begin

		with emp do begin

			write('Ingrese su apellido: ');
			readln(apellido);
			if(apellido <> 'fin') then begin

				write('Ingrese su nombre: ');
				readln(nombre);
				write('Ingrese su DNI: ');
				readln(dni);
				write('Ingrese su edad: ');
				readln(edad);
				write('Ingrese su numero de empleado: ');
				readln(numEmpleado);

			end;

		end;

	end;

var
	emp: empleado;

begin

	writeln;
	writeln('Creando Archivo...');

	rewrite(archivo);

	writeln;
	leerEmpleado(emp);
	while(emp.apellido <> 'fin') do begin

		write(archivo, emp);

		writeln;
		leerEmpleado(emp);

	end;

	writeln;
	writeln('Cerrando Archivo...');
	close(archivo);

end;


procedure consultarArchivo(var archivo: archivoEmpleados);

	procedure obtenerEmpleadoPorNomApe(var archivo: archivoEmpleados);
	var
		emp, infoEmpleado: empleado;
		encontre: boolean;
		nomApe: String;

	begin

		encontre:= false;

		writeln;
		write('Ingrese el nombre o apellido del empleado: ');
		readln(nomApe);

		reset(archivo);

		while ( (not eof(archivo)) and (not encontre) ) do begin

			read(archivo, emp);
			if( (emp.nombre = nomApe) or (emp.apellido = nomApe) ) then begin

				infoEmpleado:= emp;
				encontre:= true;

			end;

		end;

		close(archivo);

		if(encontre) then begin

			with infoEmpleado do begin

				writeln('Empleado ', numEmpleado);
				writeln('Nombre: ', nombre);
				writeln('Apellido: ', apellido);
				writeln('DNI: ', dni);
				writeln('Edad: ', edad);

			end;

		end
		else
			writeln('No se encuentra el empleado');

	end;

	procedure obtenerTodosLosEmpleados(var archivo: archivoEmpleados);
	var
		emp: empleado;
	
	begin

		reset(archivo);

		while not eof(archivo) do begin

			read(archivo, emp);

			with emp do begin

				writeln;
				writeln('Empleado ', numEmpleado);
				writeln('Nombre: ', nombre);
				writeln('Apellido: ', apellido);
				writeln('DNI: ', dni);
				writeln('Edad: ', edad);

			end;

		end;

		close(archivo);

	end;

	procedure ObtenerEmpleadosMayores(var archivo: archivoEmpleados);
	var
		emp: empleado;
		contador: integer;
	
	begin

		contador:= 0;

		reset(archivo);

		while not eof(archivo) do begin

			read(archivo, emp);

			if(emp.edad > 70) then begin

				with emp do begin

					writeln;
					writeln('Empleado ', numEmpleado);
					writeln('Nombre: ', nombre);
					writeln('Apellido: ', apellido);
					writeln('DNI: ', dni);
					writeln('Edad: ', edad);

				end;

				contador:= contador + 1;

			end;

		end;

		close(archivo);

		if(contador = 0) then begin

			writeln;
			writeln('No hay empleados con más de 70 anios');

		end;

	end;

var
	opcionConsulta: integer;
	confirma: char;

begin

	writeln;
	writeln('Elije una de las opciones de su consulta');
	writeln('1- Obtener empleado por nombre o apellido');
	writeln('2- Obtener todos los empleados');
	writeln('3- Obtener los empleados mayores de 70 anios');
	writeln('0- Fin de su consulta');
	write('Ingrese la opcion de su consulta: ');
	readln(opcionConsulta);

	while(opcionConsulta <> 0) do begin

		case opcionConsulta of
			1: obtenerEmpleadoPorNomApe(archivo);
			2: obtenerTodosLosEmpleados(archivo);
			3: ObtenerEmpleadosMayores(archivo);
			else begin
				writeln;
				writeln('Opcion incorrecta, ingrese una opcion valida!');
			end;
		end;

		writeln;
		write('Le gustaria hacer otra consulta? [S/N]: ');
		readln(confirma);
		if( (confirma = 'S') or (confirma = 's')) then begin

			write('Ingrese la opcion de su consulta: ');
			readln(opcionConsulta);

		end
		else begin
			opcionConsulta:= 0;
			writeln('Hasta la proximaaa');
		end;

	end;

end;


var
	archivo: archivoEmpleados;
	nombreArchivo: String;
	opcion: integer;

begin

	write('Ingrese el nombre del archivo a trabajar: ');
	readln(nombreArchivo);
	Assign(archivo, nombreArchivo);

	writeln;
	writeln('BIENVENIDO!');

	writeln;
	writeln('---PÁGINA PRINCIPAL---');
	writeln('Elije una de las opciones');
	writeln('0- Terminar programa');
	writeln('1- Crear Archivo');
	writeln('2- Consultar Archivo');
	write('Ingrese la opción: ');
	readln(opcion);

	while(opcion <> 0) do begin

		case opcion of
			1: crearArchivo(archivo);
			2: consultarArchivo(archivo);
		else begin
				writeln;
				writeln('Opcion incorrecta! Ingrese una de las opciones que se muestra en pantalla');
			end;
		end;

		writeln;
		writeln('---PÁGINA PRINCIPAL---');
		writeln('Elije una de las opciones');
		writeln('0- Terminar programa');
		writeln('1- Crear Archivo');
		writeln('2- Consultar Archivo');
		write('Ingrese la opción: ');
		readln(opcion);

	end;

	writeln;
	writeln('Fin del programa');

end.