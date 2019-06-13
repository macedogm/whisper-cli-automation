var sjcl = require('./sjcl.js')

var args = process.argv.slice(2);

function randomString() {
	let text = "";
	const possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	for (var i = 0; i < 16; i++)
		text += possible.charAt(Math.floor(Math.random() * possible.length));
	return text;
}

var pass = randomString()

var ciphertext = sjcl.encrypt(pass, args[0])

var payload =  JSON.stringify({
	secret: ciphertext,
	expiration: 604800
})

console.log(pass + "|" + payload)
