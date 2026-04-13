const arrayLenguajes = ['java', 'C_num', 'C++', 'go', 'js', 'python'];
let intentosPorLenguaje = [2, 2, 2, 2, 2, 2];

const tabla = document.getElementById('tabla');

for (let i = 0; i < tabla.rows.length; i++) { //Fila
    
    let fila = tabla.rows[i];
        
    for (let j = 0; j < fila.cells.length; j++) { //Columna
        
        let columna = fila.cells[j];
        let imagen = columna.querySelector('img');
        imagen.addEventListener('click', () => {

            let numeroRandom;

            do {
                numeroRandom = Math.floor(Math.random() * 6);
            } while (intentosPorLenguaje[numeroRandom] === 0);

            intentosPorLenguaje[numeroRandom]--;

            imagen.src = '/img/'+arrayLenguajes[numeroRandom]+'.png';

        });
            
    }
}