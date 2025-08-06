const express = require('express');
const promClient = require('prom-client');
const app = express();
const port = 3000;

// Metrics endpoint
const collectDefaultMetrics = promClient.collectDefaultMetrics;
collectDefaultMetrics();
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', promClient.register.contentType);
  res.end(await promClient.register.metrics());
});

// Hello World endpoint
app.get('/', (req, res) => {
  res.send('Hello World from Node.js in Kubernetes!');
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});

