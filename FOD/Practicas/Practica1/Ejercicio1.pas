program ejercicio1;

type

    archivoNumeros = file of integer;


procedure cargarArchivo(var archivo: archivoNumeros);
var
    numero: integer;

begin

    rewrite(archivo);

    writeln;
    writeln('Se ingresan numeros al archivo');

    write('Ingrese un numero: ');
    readln(numero);
    while(numero <> 30000) do begin

        write(archivo, numero);

        write('Ingrese un numero: ');
        readln(numero);

    end;

    close(archivo);

end;


var
    archivo: archivoNumeros;
    nombreArchivo: String;

begin

    write('Ingrese el nombre del archivo: ');
    readln(nombreArchivo);
    Assign(archivo, nombreArchivo);

    cargarArchivo(archivo);

    writeln;
    writeln('Fin del programa');

end.