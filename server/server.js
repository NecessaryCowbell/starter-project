const express = require('express');
const path = require('path');
const app = express();

let hostPath = '../exports/html5';
let port = 8080;

if (process.argv[2]) {
  hostPath = process.argv[2];
}
if (process.argv[3]) {
  port = process.argv[3];
}

app.use((req, res, next) => {
  res.setHeader('Cross-Origin-Opener-Policy', 'same-origin');
  res.setHeader('Cross-Origin-Embedder-Policy', 'require-corp');
  next();
});

app.use(express.static(path.join(__dirname, hostPath)));

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
