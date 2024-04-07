const http = require('http');
const fs = require('fs');

// Read the configuration from config.json
const config = JSON.parse(fs.readFileSync('config.json'));

// Create a server object
const server = http.createServer((req, res) => {
  // Check if the request is for favicon.ico
  if (req.url === '/favicon.ico') {
    res.writeHead(200, { 'Content-Type': 'image/x-icon' });
    res.end();
    return;
  }

  // Set the response HTTP header with HTTP status and Content type
  res.writeHead(200, {'Content-Type': 'text/plain'});

  // Send the response body "Hello World"
  res.end('Hello World\n');
});

// Listen for new connections
server.on('request', (req, res) => {
  // Log a message when a new client arrives, but not for favicon request
  if (req.url !== '/favicon.ico') {
    console.log('New client connected.');
  }
});

// Server listens on the configured IP address and port
const { ip, port } = config;
server.listen(port, ip, () => {
  console.log(`Server running at http://${ip}:${port}/`);
});
