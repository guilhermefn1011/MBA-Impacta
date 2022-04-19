var diet;
var alturaEl ;
var pesoEl ;
var imc ;

function Person(height, weight) {
    if (typeof(height) !== 'number' || isNaN(height))
        throw Error('height not a number');

    if (typeof(weight) !== 'number' || isNaN(weight))
        throw Error('weight not a number');

    this.height = height;
    this.weight = weight;
}

function Dietician(height, weight, crn) {
    Person.call(this, height, weight);
    this.crn = crn;
    this.calculateImc = function() {
        return this.weight / Math.pow(this.height, 2);
    }
    console.log(this);
}
Dietician.prototype = Object.create(Person.prototype);
Dietician.prototype.constructor = Dietician;

function Athlete(height, weight, crn) {
    Dietician.call(this, height, weight, crn);
    this.calculateDiet = function() {
        var imc = this.calculateImc();
        if (imc > 30) {
            return "Ultra leve";
        } else {
            return "Normal";
        }
    }
}
Athlete.prototype = Object.create(Dietician);
Athlete.prototype.constructor = Athlete;

function calculateImc() {
    var height = parseFloat(alturaEl.value);
    var weight = parseFloat(pesoEl.value);
    imc.innerHTML = new Dietician(height, weight, 1234).calculateImc();
    diet.innerHTML = new Athlete(height, weight, 1234).calculateDiet();
}

function builder() { 
    alturaEl = document.querySelector('#altura');
    pesoEl = document.querySelector('#peso');
    imc = document.querySelector("#imc");
    diet = document.querySelector("#diet");
}

window.onload = function(evt) {
    builder();
    var btn = document.querySelector(".form button");
    btn.addEventListener("click", calculateImc);
}
