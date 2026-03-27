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

				writeln(archivoTxt, codigoCelular, ' ', precio:3:2, ' ', marca);
				writeln(archivoTxt, stockDisponible, ' ', stockMinimo, ' ', descripcion);
				writeln(archivoTxt, nombre);

			end;

		end;

		close(archivoTxt);
		close(archivoBin);

		writeln;
		writeln('ARCHIVO DE TEXTO ACTUALIZADO CORRECTAMENTE');

	end;

	procedure agregarCelulares;

		procedure leerCelular(var regNuevo: celular);
		begin

			with regNuevo do begin

				writeln;
				write('Ingrese el código: ');
				readln(codigoCelular);
				write('Ingrese el precio: ');
				readln(precio);
				write('Ingrese la marca: ');
				readln(marca);
				write('Ingrese el stock disponible: ');
				readln(stockDisponible);
				write('Ingrese el stock mínimo: ');
				readln(stockMinimo);
				write('Ingrese la descripción: ');
				readln(descripcion);
				write('Ingrese el nombre: ');
				readln(nombre);

			end;

		end;

	var
		archivoBin: archivoCelular;
		regNuevo: celular;
		nombreArchivoBin: String;
		confirma: char;
	
	begin

		writeln;
		writeln('---PÁGINA PARA AGREGAR CELULARES---');

		writeln;
		write('Ingrese el nombre del archivo: ');
		readln(nombreArchivoBin);

		assign(archivoBin, nombreArchivoBin);

		reset(archivoBin);

		confirma:= 'S';

		writeln;
		writeln('A continuación ingrese la información de cada celular');

		while( (confirma = 'S') or (confirma = 's') ) do begin

			leerCelular(regNuevo);
			seek(archivoBin, filesize(archivoBin)); //Estaría apuntando a eof
			write(archivoBin, regNuevo);

			writeln;
			write('Le gustaria agregar otro celular? [S/N]: ');
			readln(confirma);

		end;

		close(archivoBin);

		writeln;
		writeln('---FIN DE LA CARGA---');

	end;

	procedure modificarStock;
	var
		archivoBin: archivoCelular;
		regCel, celAModificar: celular;
		nombreArchivoBin, nombreCelularABuscar: String;
		encontre: boolean;
	
	begin

		writeln;
		writeln('---PÁGINA PARA MODIFICAR EL STOCK---');

		writeln;
		write('Ingrese el nombre del archivo: ');
		readln(nombreArchivoBin);

		assign(archivoBin, nombreArchivoBin);

		reset(archivoBin);

		writeln;
		write('Ingrese el nombre del celular a buscar: ');
		readln(nombreCelularABuscar);

		encontre:= false;

		while( (not eof(archivoBin)) and (not encontre) ) do begin

			read(archivoBin, regCel);

			if(regCel.nombre = nombreCelularABuscar) then begin

				celAModificar:= regCel;
				encontre:= true;

			end;

		end;

		if(encontre) then begin

			writeln;
			write('Ingrese la cantidad de celulares al stock: ');
			readln(celAModificar.stockDisponible);

			seek(archivoBin, filepos(archivoBin)-1);
			write(archivoBin, celAModificar);

		end
		else begin

			writeln;
			writeln('El celular con nombre ', nombreCelularABuscar, ' no se encuentra en la lista');

		end;

		close(archivoBin);

		writeln;
		writeln('---FIN DE LA CARGA---');

	end;

	procedure exportarAArchivoSinStock;
	var
		archivoBin: archivoCelular;
		archivoTxt: Text;
		regCel: celular;
		nombreArchivoBin: String;
		contador: integer; //Solo para mostrar en pantalla un cartel
	
	begin

		contador:= 0;

		writeln;
		writeln('EXPORTANDO A ARCHIVO SinStock.txt...');

		writeln;
		write('Ingrese el nombre del archivo binario: ');
		readln(nombreArchivoBin);

		assign(archivoBin, nombreArchivoBin);
		assign(archivoTxt, 'SinStock');

		reset(archivoBin);
		rewrite(archivoTxt);

		while(not eof(archivoBin)) do begin

			read(archivoBin, regCel);

			if(regCel.stockDisponible = 0) then begin

				contador:= contador + 1;

				with regCel do begin

					writeln(archivoTxt, codigoCelular, ' ', precio:3:2, ' ', marca);
					writeln(archivoTxt, stockDisponible, ' ', stockMinimo, ' ', descripcion);
					writeln(archivoTxt, nombre);

				end;

			end;

		end;

		close(archivoTxt);
		close(archivoBin);

		if(contador > 0) then begin

			writeln;
			writeln('EXPORTACIÓN EXITOSA');

		end
		else begin

			writeln;
			writeln('NO SE ENCUENTRAN CELULARES CON STOCK 0'); //Se va a crear el archivo aunque tengan stocks en todos los celulares

		end;

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
	writeln('5- Agregar celular/es al archivo');
	writeln('6- Modificar stock');
	writeln('7- Exportar a archivo SinStock.txt');

	writeln;
	write('Ingrese su opción: ');
	readln(opcion);

	while(opcion <> 0) do begin

		case opcion of
			1: crearArchivoBin(archivoTxt);
			2: obtenerCelularesConStockMenor;
			3: obtenerCelularesDescripcionChar;
			4: exportarAARchivoTxt(archivoTxt);
			5: agregarCelulares;
			6: modificarStock;
			7: exportarAArchivoSinStock;
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
		writeln('5- Agregar celular/es al archivo');
		writeln('6- Modificar stock');
		writeln('7- Exportar a archivo SinStock.txt');

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