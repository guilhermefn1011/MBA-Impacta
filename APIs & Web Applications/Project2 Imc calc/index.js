const btn = document.querySelector("#send");


btn.addEventListener("click", function(e,showResult) {
    e.preventDefault();

    const peso = document.querySelector("#peso");
    const pesoValue = peso.value;

    const altura = document.querySelector("#altura");
    const alturaValue = altura.value;

    console.log( alturaValue, pesoValue, imc);

    var imc = (pesoValue/alturaValue);
    return imc;
    
})

function calcImc() {
    var imc = pesoValue / Math.pow(alturaValue, 2);
    return imc;
}

function showResult() {
    document.querySelector('.container h3')
    .innerHTML = calcImc();
}

