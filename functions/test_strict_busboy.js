const busboy = require('busboy');

const boundary = '--dio-boundary-1247917796';
const headers = { 'content-type': `multipart/form-data; boundary=${boundary}` };

// Buffer WITHOUT trailing \r\n
const body = Buffer.from(
`--${boundary}\r
Content-Disposition: form-data; name="name"\r
\r
sdfsdf\r
--${boundary}--`); // NO \r\n here!

const bb = busboy({ headers });
bb.on('field', (name, val) => console.log('Field:', name, val));
bb.on('error', (err) => console.error('Error:', err.message));
bb.on('close', () => console.log('Closed'));

bb.end(body);
