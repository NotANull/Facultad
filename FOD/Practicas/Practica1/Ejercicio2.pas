program ejercicio2;

type

	archivoNumeros = file of integer;


procedure informes(var archivo: archivoNumeros);
var
	cantNumMenores, acumulador, numero, contador: integer;
	promedio: real;

begin

	cantNumMenores:= 0;
	acumulador:= 0;
	promedio:= 0;

	reset(archivo);

	while not eof(archivo) do begin

		read(archivo, numero);

		writeln('Numero en el archivo: ', numero);

		if(numero < 1500) then
			cantNumMenores:= cantNumMenores + 1;
		
		contador:= contador + 1;
		acumulador:= acumulador + numero;

	end;

	close(archivo);

	promedio:= acumulador / contador;

	writeln('Cantidad de numeros menores a 1500: ', cantNumMenores);
	writeln('Promedio de los numeros ingresados: ', promedio:3:2);

end;


var
	archivo: archivoNumeros;
	nombreArchivo: String;

begin

	write('Ingrese el nombre del archivo: ');
	readln(nombreArchivo);
	Assign(archivo, nombreArchivo);

	informes(archivo);

	writeln;
	writeln('Fin del programa');

end.