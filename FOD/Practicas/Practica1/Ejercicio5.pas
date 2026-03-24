program ejercicio5;
type

		celular = record
			codigoCelular: integer;
			nombre: String[30];
			descripcion: String[50];
			marca: String[30];
			precio: real;
			stockMinimo: integer;
			stockDisponible: integer;
		end;
		archivoCelular = file of celular;

procedure run;

	procedure crearArchivoBin(var archivoTxt: Text);
	var
		archivoBin: archivoCelular;
		regCel: celular;
		nombreArchivoBin: String;

	begin

		writeln;
		write('Ingrese el nombre del archivo binario: ');
		readln(nombreArchivoBin);

		assign(archivoBin, nombreArchivoBin);

		writeln;
		writeln('CREANDO ARCHIVO BINARIO...');

		reset(archivoTxt);
		rewrite(archivoBin);
		while(not eof(archivoTxt)) do begin

			with regCel do begin

				readln(archivoTxt, codigoCelular, precio, marca);
				readln(archivoTxt, stockDisponible, stockMinimo, descripcion);
				readln(archivoTxt, nombre);

			end;

			write(archivoBin, regCel); //Tengo que respetar el formato del archivo de texto? X

		end;

		close(archivoBin);
		close(archivoTxt);

		writeln;
		writeln('ARCHIVO CREADO CORRECTAMENTE');

	end;

	procedure obtenerCelularesConStockMenor;
	var
		archivoBin: archivoCelular;
		regCel: celular;
		nombreArchivoBin: String;
	
	begin

		writeln;
		writeln('---LISTADO CON POCO STOCK---');

		writeln;
		write('Ingrese el nombre del archivo: ');
		readln(nombreArchivoBin);

		assign(archivoBin, nombreArchivoBin);

		reset(archivoBin);

		while(not eof(archivoBin)) do begin

			read(archivoBin, regCel);

			if(regCel.stockDisponible < regCel.stockMinimo) then begin

				with regCel do begin

					writeln;
					writeln('Código de celular: ', codigoCelular);
					writeln('Nombre: ', nombre);
					writeln('Descripción: ', descripcion);
					writeln('Marca: ', marca);
					writeln('Precio: ', precio:3:2);
					writeln('Stock mínimo: ', stockMinimo);
					writeln('Stock Disponible: ', stockDisponible);
					
				end;

			end;

		end;

		close(archivoBin);

		writeln;
		writeln('---FIN DE LA CONSULTA---');

	end;

	procedure obtenerCelularesDescripcionChar;
	var
		archivoBin: archivoCelular;
		regCel: celular;
		nombreArchivoBin, descripcionABuscar: String;

	begin

		writeln;
		writeln('---LISTADO POR DESCRIPCIÓN CON X CARACTERES---');

		writeln;
		write('Ingrese el nombre del archivo: ');
		readln(nombreArchivoBin);

		assign(archivoBin, nombreArchivoBin);

		writeln;
		write('Ingrese el la descripción del celular: ');
		readln(descripcionABuscar);

		reset(archivoBin);

		while(not eof(archivoBin)) do begin

			read(archivoBin, regCel);

			if(regCel.descripcion = descripcionABuscar) then begin

				with regCel do begin

					writeln;
					writeln('Código de celular: ', codigoCelular);
					writeln('Nombre: ', nombre);
					writeln('Descripción: ', descripcion);
					writeln('Marca: ', marca);
					writeln('Precio: ', precio:3:2);
					writeln('Stock mínimo: ', stockMinimo);
					writeln('Stock Disponible: ', stockDisponible);

				end;

			end;

		end;

		close(archivoBin);

		writeln;
		writeln('---FIN DE LA CONSULTA---');

	end;

	procedure exportarAARchivoTxt(var archivoTxt: Text);
	var
		archivoBin: archivoCelular;
		regCel: celular;
		nombreArchivoBin: String;

	begin

		writeln;
		writeln('EXPORTANDO A ARCHIVO TXT...');

		writeln;
		write('Ingrese el nombre del archivo a exportar: ');
		readln(nombreArchivoBin);

		assign(archivoBin, nombreArchivoBin);
		//assign(archivoTxt, 'celulares'); //Es necesario reasignar el archivo lógico con el físico? La asignación ya se hizo al principio del programa

		reset(archivoBin);
		rewrite(archivoTxt);

		while(not eof(archivoBin)) do begin

			read(archivoBin, regCel);

			with regCel do begin

				writeln(archivoTxt, codigoCelular, ' ', precio, ' ', marca);
				writeln(archivoTxt, stockDisponible, ' ', stockMinimo, ' ', descripcion);
				writeln(archivoTxt, nombre);

			end;

		end;

		close(archivoTxt);
		close(archivoBin);

		writeln;
		writeln('ARCHIVO DE TEXTO ACTUALIZADO CORRECTAMENTE');

	end;

var
	opcion: integer;
	archivoTxt: Text;

begin

	assign(archivoTxt, 'celulares'); //Tengo que agregar la extensión?

	writeln;
	writeln('---PÁGINA PRINCIPAL---');

	writeln;
	writeln('Elija una de las siguientes opciones');
	writeln('0- Terminar programa');
	writeln('1- Crear archivo binario');
	writeln('2- Obtener celulares con stock menor al mínimo');
	writeln('3- Obtener celulares con descripción por cantidad de carácteres');
	writeln('4- Exportar a archivo de texto');

	writeln;
	write('Ingrese su opción: ');
	readln(opcion);

	while(opcion <> 0) do begin

		case opcion of
			1: crearArchivoBin(archivoTxt);
			2: obtenerCelularesConStockMenor;
			3: obtenerCelularesDescripcionChar;
			4: exportarAARchivoTxt(archivoTxt);
		else begin
				writeln;
				writeln('Opcion incorrecta! Ingrese una de las opciones que se muestra en pantalla');
			end;
		end;

		writeln;
		writeln('Elija una de las siguientes opciones');
		writeln('0- Terminar programa');
		writeln('1- Crear archivo binario');
		writeln('2- Obtener celulares con stock menor al mínimo');
		writeln('3- Obtener celulares con descripción por cantidad de carácteres');
		writeln('4- Exportar a archivo de texto');

		writeln;
		write('Ingrese su opción: ');
		readln(opcion);

	end;

end;


begin

	writeln;
	writeln('BIENVENIDO!');

	run;

	writeln;
	writeln('Fin del programa');

end.