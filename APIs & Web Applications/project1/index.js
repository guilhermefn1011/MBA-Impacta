var messages = [
    " oioioi",
    " tchau tchau",
    " volta aqui", 
    " ah esquece falou"
];

function pickMessage() {
    var nr = Math.random();
    var msgIndex = parseInt(nr * messages.length);
    return messages[msgIndex];
}

function updateMessage() {
    document.querySelector('.letter p')
    .innerHTML = pickMessage();
}

window.onload = function() {
    updateMessage();
}