program ejercicio3;

	const

		valorAlto = 'ZZZZ';

	type

		str30 = String[30];

		alfabetizacion = record
			nombreProvincia: str30;
			cantPersonasAlfabetas: integer;
			totalEncuestados: integer;
		end;

		agencia = record
			nombreProvincia: str30;
			codigoLocalidad: integer;
			cantPersonasAlfabetas: integer;
			cantEncuestados: integer;
		end;

		maestro = file of alfabetizacion;
		detalle = file of agencia;

procedure leer(var ad: detalle; var regAd: agencia);
begin

	if(not eof(ad)) then
		read(ad, regAd)
	else
		regAd.nombreProvincia:= valorAlto;

end;

procedure minimo(var ad1, ad2: detalle; var regD1, regD2, regMin: agencia);
begin

	if(regD1.nombreProvincia <= regD2.nombreProvincia) then begin
		regMin:= regD1;
		leer(ad1, regD1);
	end
	else begin
		regMin:= regD2;
		leer(ad2, regD2);
	end;

end;

var
	am: maestro;
	regAm: alfabetizacion;

	ad1, ad2: detalle;
	regD1, regD2, regMin: agencia;

	provinciaActual: str30;
	acumularAlfabetizados, acumularEncuestados: integer;

begin

	assign(am, 'ArchivoM_Ejercicio3');
	assign(ad1, 'ArchivoD1_Ejercicio3');
	assign(ad2, 'ArchivoD2_Ejercicio3');

	reset(am);
	reset(ad1);
	reset(ad2);

	read(am, regAm);
	leer(ad1, regD1);
	leer(ad2, regD2);

	minimo(ad1, ad2, regD1, regD2, regMin);

	while(regMin.nombreProvincia <> valorAlto) do begin

		provinciaActual:= regMin.nombreProvincia;
		acumularAlfabetizados:= 0;
		acumularEncuestados:= 0;

		while(provinciaActual = regMin.nombreProvincia) do begin

			acumularAlfabetizados:= acumularAlfabetizados + regMin.cantPersonasAlfabetas;
			acumularEncuestados:= acumularEncuestados + regMin.cantEncuestados;
			minimo(ad1, ad2, regD1, regD2, regMin);

		end;

		while(regAm.nombreProvincia <> regMin.nombreProvincia) do
			read(am, regAm);

		regAm.cantPersonasAlfabetas:= regAm.cantPersonasAlfabetas + acumularAlfabetizados;
		regAm.totalEncuestados:= regAm.totalEncuestados + acumularEncuestados;

		seek(am, filepos(am)-1);

		write(am, regAm);

		if(not eof(am)) then
			read(am, regAm);

	end;

	close(ad2);
	close(ad1);
	close(am);

	writeln;
	writeln('Fin de la actualización del archivo maestro');

end.