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

			write(archivoBin, regCel);

        end;

        close(archivoBin);
        close(archivoTxt);

		writeln;
		writeln('ARCHIVO CREADO CORRECTAMENTE');

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