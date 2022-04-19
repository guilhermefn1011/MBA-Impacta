function calculaimc() {
    let peso = parseFloat(document.getElementById('Fpeso').value);
    let altura = parseFloat(document.getElementById('Faltura').value);

    const imc = peso / (altura ^ 2);
    let tipo = "";

        if (imc > 30) {
            tipo = "Obesidade";
            
        }else if(imc > 24.9){
            tipo = "Sobrepeso";
        }
        else if (imc > 18.5){
            tipo = "Normal";
        } else {
            tipo = "Magreza";
        }

    document.querySelector('#imc').innerHTML = tipo + " - " + imc.toFixed(2);
}