// server.js
const express    = require('express');
const mysql      = require('mysql2/promise');
const bodyParser = require('body-parser');
const path       = require('path');

const app = express();

// Motor de vistas
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Archivos estáticos
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: false }));

// Pool de conexión MySQL
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'admin',
  database: 'ControlDeReparaciones',
  waitForConnections: true,
  connectionLimit: 10,
});

// Ruta directa al dashboard
app.get('/dashboard.html', (req, res) => {
  res.sendFile(path.join(__dirname, 'dashboard.html'));
});

// Mostrar formulario de nueva reparación
app.get('/reparaciones/nueva', async (req, res, next) => {
  try {
    const [tipos]       = await pool.query('SELECT tipo_id, nombre FROM tipos_equipos');
    //const [marcas]      = await pool.query('SELECT marca_id, nombre FROM marcas');
    const [modelos]     = await pool.query('SELECT modelo_id, nombre FROM modelos');
    const [equipos]     = await pool.query('SELECT equipo_id, nombre FROM equipos');
    const [refacciones] = await pool.query('SELECT refaccion_id, nombre FROM refacciones');
    const [areas]       = await pool.query('SELECT area_id, nombre FROM areas');

    const success = req.query.success === '1';

    res.render('form-reparacion', {
      tipos,
      //marcas,
      modelos,
      equipos,
      refacciones,
      areas,
      success
    });
  } catch (err) {
    next(err);
  }
});

// Endpoint para obtener marcas por tipo_id
app.get('/marcas/:tipo_id', async (req, res) => {
  try {
    const tipoId = req.params.tipo_id;
    const [marcas] = await pool.query(
      'SELECT marca_id, nombre FROM marcas WHERE tipo_id = ?',
      [tipoId]
    );
    res.json(marcas);
  } catch (err) {
    res.status(500).json({ error: 'Error al obtener marcas' });
  }
});

// Procesar envío del formulario
app.post('/reparaciones', async (req, res, next) => {
  const {
    equipo_id,
    inventario_equipo,
    refaccion_id,
    inventario_refaccion,
    descripcion,
    expediente,
    nombre,
    area_id
  } = req.body;

  try {
    // 1. Actualizar inventario de refacción (si aplica)
    await pool.query(
      `UPDATE refacciones
         SET refaccion_inventario = ?
       WHERE refaccion_id = ?`,
      [inventario_refaccion, refaccion_id]
    );

    // 2. Insertar usuario
    const [userResult] = await pool.query(
      `INSERT INTO usuarios
         (expediente, nombre, area_id)
       VALUES (?, ?, ?)`,
      [expediente, nombre, area_id]
    );
    const usuario_id = userResult.insertId;

    // 3. Insertar reparación
    await pool.query(
      `INSERT INTO reparacion
         (equipo_id, inventario, refaccion_id, descripcion, fecha, usuario_id)
       VALUES (?, ?, ?, ?, CURDATE(), ?)`,
      [equipo_id, inventario_equipo, refaccion_id, descripcion, usuario_id]
    );

    res.redirect('/reparaciones/nueva?success=1');
  } catch (err) {
    next(err);
  }
});

// Manejador de errores
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).send('Error interno: ' + err.message);
});

// Iniciar servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`✅✅ Servidor corriendo en http://localhost:${PORT} ✅✅`);
});
