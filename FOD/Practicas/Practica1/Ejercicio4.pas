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

procedure crearArchivo(var archivo: archivoEmpleados);
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
	writeln('---PÁGINA DE CONSULTA---');

	writeln;
	writeln('Elije una de las opciones de su consulta');
	writeln('0- Fin de su consulta');
	writeln('1- Obtener empleado por nombre o apellido');
	writeln('2- Obtener todos los empleados');
	writeln('3- Obtener los empleados mayores de 70 anios');
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

			writeln;
			writeln('Elije una de las opciones de su consulta');
			writeln('0- Fin de su consulta');
			writeln('1- Obtener empleado por nombre o apellido');
			writeln('2- Obtener todos los empleados');
			writeln('3- Obtener los empleados mayores de 70 anios');
			write('Ingrese la opcion de su consulta: ');
			readln(opcionConsulta);

		end
		else begin
			opcionConsulta:= 0;
			writeln('Fin de la consulta');
		end;

	end;

end;

procedure agregarEmpleados(var archivo: archivoEmpleados);

	procedure empleadoExistente(var archivo: archivoEmpleados; empNuevo: empleado; var existente: boolean);
	var
		emp: empleado;

	begin

		Existente:= false;
		seek(archivo, 0); //Vuelvo a posicionar el puntero al principio del archivo
		while( (not eof(archivo)) and (not Existente) ) do begin

			read(archivo, emp);
			if(emp.numEmpleado = empNuevo.numEmpleado) then begin
				existente:= true;
			end;

		end;

		if(existente) then begin

			writeln;
			writeln('El empleado con n° de empleado ', empNuevo.numEmpleado, ' ya existe!');

		end;

	end;

var
	empNuevo: empleado;
	existente: boolean;
	confirma: char;

begin

	confirma:= 'S';

	writeln;
	writeln('---PÁGINA PARA AGREGAR EMPLEADOS---');

	reset(archivo);

	leerEmpleado(empNuevo);
	empleadoExistente(archivo, empNuevo, existente);
	//seek(archivo, filesize(archivo)); //Si empleado con el número de empleado ya existe en el archivo, posicionaría el puntero al final del archivo
	while( (empNuevo.apellido <> 'fin') and ((confirma = 'S') or (confirma = 's')) ) do begin

		if(not existente) then begin

			seek(archivo, filesize(archivo));
			write(archivo, empNuevo);

		end;

		writeln;
		write('Le gustaria agregar a otro empleado? [S/N]: ');
		readln(confirma);
		if( (confirma = 'S') or (confirma = 's') ) then begin

			leerEmpleado(empNuevo);
			empleadoExistente(archivo, empNuevo, existente);

		end;

	end;

	close(archivo);

	writeln;
	writeln('Fin de la carga de empleados');

end;

procedure modificarEdadEmpleado(var archivo: archivoEmpleados);
var
	emp: empleado;
	NumEmpleadoABuscar: integer;

begin

	writeln;
	writeln('---PÁGINA PARA MODIFICAR LA EDAD DE UN EMPLEADO---');

	reset(archivo);

	writeln;
	write('Ingrese el número de empleado a modificar la edad: ');
	readln(NumEmpleadoABuscar);

	while( (not eof(archivo)) and (emp.numEmpleado <> NumEmpleadoABuscar) ) do
		read(archivo, emp);

	if(emp.numEmpleado <> NumEmpleadoABuscar) then begin

		writeln;
		writeln('No se encuentra registrado el empleado con numero ', NumEmpleadoABuscar);

	end
	else begin

		writeln;
		writeln('Se modificará la edad a el/la empleada/o ', emp.nombre, ' ', emp.apellido);
		write('Ingrese la edad: ');
		readln(emp.edad);

		seek(archivo, filepos(archivo)-1);
		write(archivo, emp);

	end;

	close(archivo);

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
	writeln('3- Agregar empleados');
	writeln('4- Modificar edad de un empleado');
	write('Ingrese la opción: ');
	readln(opcion);

	while(opcion <> 0) do begin

		case opcion of
			1: crearArchivo(archivo);
			2: consultarArchivo(archivo);
			3: agregarEmpleados(archivo);
			4: modificarEdadEmpleado(archivo);
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
		writeln('3- Agregar empleados');
		writeln('4- Modificar edad de un empleado');
		write('Ingrese la opción: ');
		readln(opcion);

	end;

	writeln;
	writeln('Fin del programa');

end.