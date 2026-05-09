const busboy = require('busboy');
const fs = require('fs');

const boundary = '--dio-boundary-1247917796';
const headers = {
  'content-type': `multipart/form-data; boundary=${boundary}`
};

// Create a mock rawBody
const body = Buffer.from(
`--${boundary}\r
Content-Disposition: form-data; name="name"\r
\r
sdfsdf\r
--${boundary}--\r
`);

const bb = busboy({ headers });
bb.on('field', (name, val) => console.log('Field:', name, val));
bb.on('file', (name, file, info) => {
  console.log('File:', name, info.filename);
  file.resume();
});
bb.on('close', () => console.log('Closed'));
bb.on('error', (err) => console.error('Error:', err));

bb.end(body);
