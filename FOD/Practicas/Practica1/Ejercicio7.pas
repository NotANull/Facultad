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

var
	archivoText: Text;
	archivoBinario: archivoNovelas;
begin

	assign(ArchivoText, 'novelas');

	crearArchivoBinario(archivoText, archivoBinario);
	//actualizarArchivoBinario(archivoBinario);

end;

begin

	writeln('BIENVENIDO');

	run;

	write();
	writeln('FIN DEL PROGRAMA');

end.