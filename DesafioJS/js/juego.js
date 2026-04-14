const arrayLenguajes = ['java', 'C_num', 'C++', 'go', 'js', 'python'];
let cantidadFichasPorLenguaje = [2, 2, 2, 2, 2, 2];
const tabla = document.getElementById('tabla');

//La idea de la función es settearle un atributo a cada etiqueta img para luego obtener su valor de atributo
//Además que por cada lenguaje, solo habrá su par
function prepararJuego() {

    for (let i = 0; i < tabla.rows.length; i++) {

        let fila = tabla.rows[i];

        for (let j = 0; j < fila.cells.length; j++) {

            let columna = fila.cells[j];
            let ficha = columna.querySelector('img');

            let numeroRandom;
            do {
                numeroRandom = Math.floor(Math.random() * 6);
            } while (cantidadFichasPorLenguaje[numeroRandom] === 0);

            cantidadFichasPorLenguaje[numeroRandom]--;

            ficha.dataset.lenguaje = arrayLenguajes[numeroRandom]; //Es como si la etiqueta tenga un atributo escondido con el valor que le asignamos
        }
    }

}

let primeraFicha = null;
tabla.addEventListener('click', (event) => {

    let elementoClickeado = event.target;

    let fichaOculta = elementoClickeado.dataset.lenguaje; //Obtengo el valor del dataset de la ficha clickeada
    elementoClickeado.src = `/img/${fichaOculta}.png`; //Muestro la ficha

    if (primeraFicha === null) {
        primeraFicha = elementoClickeado;
    } else {
        if (primeraFicha.dataset.lenguaje === elementoClickeado.dataset.lenguaje) {

            elementoClickeado.style.opacity = '0.5';
            elementoClickeado.style.pointerEvents = 'none';

            primeraFicha.style.pointerEvents = 'none';
            primeraFicha.style.opacity = '0.5';

            primeraFicha = null; // Reseteamos memoria para la siguiente pareja
        } else {
            console.log('No coinciden, tapando...');

            setTimeout(() => {
                primeraFicha.src = '/img/pregunta.png';
                elementoClickeado.src = '/img/pregunta.png';
                
                primeraFicha = null;
            }, 500); // medio segundo
        }
    }
});


prepararJuego();