program ejercicio2;

const

	valorAlto = 'ZZZZ';

type

	str4 = String[4];

	producto = record
		codigoProducto: str4;
		nombre: String[4];
		precio: real;
		stockActual: integer;
		stockMinimo: integer;
	end;

	venta = record
		codigoProducto: str4;
		cantVendido: integer;
	end;

	maestro = file of producto;
	detalle = file of venta;

procedure leer(var archivoD: detalle; var regD: venta);
begin

	if(not eof(archivoD)) then
		read(archivoD, regD)
	else
		regD.codigoProducto:= valorAlto;

end;

procedure crearArchivos(var archivoM: maestro; var archivoD: detalle);
var
	regM: producto;
	regD: venta;

begin

	writeln;
	writeln('PARA EL ARCHIVO MAESTRO');

	rewrite(archivoM);

	writeln;
	write('Código del producto: ');
	readln(regM.codigoProducto);
	while(regM.codigoProducto <> valorAlto) do begin

		write('Nombre del producto: ');
		readln(regM.nombre);
		write('Precio del producto: ');
		readln(regM.precio);
		write('Stock actual: ');
		readln(regM.stockActual);
		write('Stock mínimo: ');
		readln(regM.stockMinimo);

		write(archivoM, regM);

		writeln;
		write('Código del producto: ');
		readln(regM.codigoProducto);

	end;

	close(archivoM);

	writeln;
	writeln('PARA EL ARCHIVO DETALLE');

	rewrite(archivoD);

	writeln;
	write('Código del producto: ');
	readln(regD.codigoProducto);
	while(regD.codigoProducto <> valorAlto) do begin

		write('Cantidad de productos vendidos: ');
		readln(regD.cantVendido);

		write(ArchivoD, regD);

		writeln;
		write('Código del producto: ');
		readln(regD.codigoProducto);

	end;

	close(archivoD);

end;

procedure MostrarArchivoMaestro(var archivoM: maestro);
var
	regM: producto;

begin

	writeln;
	writeln('SE MUESTRA LA INFORMACIÓN DEL ARCHIVO MAESTRO DESPUÉS DE ACTUALIZARSE');

	reset(archivoM);

	while(not eof(archivoM)) do begin

		read(archivoM, regM);

		writeln;
		writeln('Código del producto: ', regM.codigoProducto);
		writeln('Nombre del producto: ', regM.nombre);
		writeln('Precio del producto: ', regM.precio:3:2);
		writeln('Stock actual: ', regM.stockActual);
		writeln('Stock mínimo: ', regM.stockMinimo);

	end;

	close(archivoM);

end;

var

	archivoM: maestro;
	archivoD: detalle;
	regM: producto;
	regD: venta;
	codigoActual: str4;
	acumuladorVentas: integer;

begin

	assign(archivoM, 'ArchivoM_Ejercicio2');
	assign(archivoD, 'ArchivoD_Ejercicio2');

	//crearArchivos(archivoM, archivoD); //SOLO DE PRUEBA

	reset(archivoM);
	reset(archivoD);

	read(archivoM, regM);
	leer(archivoD, regD);

	while(regD.codigoProducto <> valorAlto) do begin

		codigoActual:= regD.codigoProducto;
		acumuladorVentas:= 0;

		while(codigoActual = regD.codigoProducto) do begin

			acumuladorVentas:= acumuladorVentas + regD.cantVendido;
			leer(archivoD, regD);

		end;

		while(regM.codigoProducto <> codigoActual) do
			read(archivoM, regM);
		
		regM.stockActual:= regM.stockActual - acumuladorVentas;
		seek(archivoM, filepos(archivoM)-1);
		write(archivoM, regM);

		if(not eof(archivoM)) then
			read(archivoM, regM);

	end;

	close(archivoD);
	close(archivoM);

	//MostrarArchivoMaestro(archivoM); //SOLO DE PRUEBA

	writeln('Fin del programa');

end.