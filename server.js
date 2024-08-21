const express = require('express');
const app = express();
const massaSalarialRoutes = require('./routes/massaSalarial.routes');
const fatorRRoutes = require('./routes/fatorR.routes');
const anexosRoutes = require('./routes/anexos.routes');
const dasRoutes = require('./routes/das.routes');

// Middleware
app.use(express.json());

// Rotas
app.use('/api/massaSalarial', massaSalarialRoutes);
app.use('/api/fatorR', fatorRRoutes);
app.use('/api/anexos', anexosRoutes);
app.use('/api/das', dasRoutes);

// Porta para o servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log("Server is running on port ");
});

module.exports = app;
