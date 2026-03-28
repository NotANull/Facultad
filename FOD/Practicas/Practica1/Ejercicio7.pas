program ejercicio7;

type

	novela = record
		codigoNovela: integer;
		nombre: String[50];
		genero: String[30];
		precio: real;
	end;

	archivoNovelas = file of novela;

procedure run;

	procedure crearArchivoBinario(var archivoText: Text; var archivoBinario: archivoNovelas);
	var
		nombreArchivoBinario: String;
		regNovela: novela;

	begin

		writeln;
		writeln('---PÁGINA PARA CREAR EL ARCHIVO BINARIO---');

		writeln;
		write('Ingrese el nombre del archivo binario: ');
		readln(nombreArchivoBinario);

		assign(archivoBinario, nombreArchivoBinario);

		reset(archivoText);
		rewrite(archivoBinario);

		while(not eof(archivoText)) do begin

			with regNovela do begin

				readln(archivoText, codigoNovela, precio, genero);
				readln(archivoText, nombre);

			end;

			write(archivoBinario, regNovela);

		end;

		close(archivoBinario);
		reset(archivoText);

		writeln;
		writeln('---ARCHIVO BINARIO CREADO EXITOSAMENTE---');

	end;

	procedure actualizarArchivoBinario(var archivoBinario: archivoNovelas);

		procedure agregarNovela(var archivoBinario: archivoNovelas);

			procedure leerNovela(var regNuevo: novela);
			begin

				writeln;
				writeln('Se ingresa la información de la novela');

				with regNuevo do begin

					writeln;
					write('Código de la novela: ');
					readln(codigoNovela);
					write('Precio: ');
					readln(precio);
					write('Género: ');
					readln(genero);
					write('Nombre: ');
					readln(nombre);


				end;

			end;

		var
			regNovela, regNuevo: novela;
			existe: boolean;
			confirma: char;
		
		begin

			writeln;
			writeln('---AGREGAR NOVELAS AL ARCHIVO BINARIO---');

			reset(archivoBinario);

			confirma:= 'S';
			while( (confirma = 'S') or (confirma = 's') ) do begin

				existe:= false;

				seek(archivoBinario, 0); //Vuelvo a posicionar el puntero para saber si la siguiente novela a agregar existe

				leerNovela(regNuevo);
				while( (not eof(archivoBinario)) and (not existe) ) do begin

					read(archivoBinario, regNovela);

					if(regNovela.codigoNovela = regNuevo.codigoNovela) then
						existe:= true;

				end;

				if(existe) then begin

					writeln;
					writeln('La novela con código ', regNuevo.codigoNovela, ' ya existe!');

				end
				else begin

					seek(archivoBinario, fileSize(archivoBinario));
					write(archivoBinario, regNuevo);

				end;

				writeln;
				write('Le gustaría agregar otra novela al archivo?[S/N]: ');
				readln(confirma);

			end;

			close(archivoBinario);

			writeln;
			writeln('---FIN DE LA INCORPORACIÓN DE NOVELAS AL ARCHIVO BINARIO---');

		end;

		procedure modificarNovela(var archivoBinario: archivoNovelas);
		var
			regNovela: novela;
			codigoABuscar: integer;
			existe: boolean;

		begin

			existe:= false;

			writeln;
			writeln('---PÁGINA PARA MODIFICAR UNA NOVELA EXISTENTE---');

			writeln;
			write('Ingrese el código de la novela a modificar: ');
			readln(codigoABuscar);

			reset(archivoBinario);

			while( (not eof(archivoBinario)) and (not existe) ) do begin

				read(archivoBinario, regNovela);

				if(regNovela.codigoNovela = codigoABuscar) then
					existe:= true;

			end;

			if(existe) then begin

				//modificarRegistro(regNovela); //Consultar por el método que nos pide modificar un registro

				seek(archivoBinario, filepos(archivoBinario)-1);
				write(archivoBinario, regNovela);


			end
			else begin

				writeln;
				writeln('La novela con código ', codigoABuscar, ' no existe!');

			end;


			close(archivoBinario);

			writeln;
			writeln('---FIN DE LA MODIFICACIÓN---');

		end;

	var
		opcion: integer;

	begin

		writeln;
		writeln('---PÁGINA PARA ACTUALIZAR EL ARCHIVO BINARIO---');

		writeln;
		writeln('Elija una de las siguientes opciones');
		writeln('0- fin del programa');
		writeln('1- Agregar una novela al archivo');
		writeln('2- Modificar una novela');

		writeln;
		write('Ingrese su opción: ');
		readln(opcion);

		while(opcion <> 0) do begin

			case opcion of
				1: agregarNovela(archivoBinario);
				2: modificarNovela(archivoBinario);
			else begin
					writeln;
					writeln('Opcion incorrecta! Ingrese una de las opciones que se muestra en pantalla');
				end;
			end;

			writeln;
			writeln('Elija una de las siguientes opciones');
			writeln('0- fin del programa');
			writeln('1- Agregar una novela al archivo');
			writeln('2- Modificar una novela');

			writeln;
			write('Ingrese su opción: ');
			readln(opcion);

		end;

		writeln;
		writeln('---FIN DE LA ACTUALIZACIÓN---');

	end;

var
	archivoText: Text;
	archivoBinario: archivoNovelas;
begin

	assign(ArchivoText, 'novelas');

	crearArchivoBinario(archivoText, archivoBinario);
	actualizarArchivoBinario(archivoBinario);

end;

begin

	writeln('BIENVENIDO');

	run;

	write();
	writeln('FIN DEL PROGRAMA');

end.