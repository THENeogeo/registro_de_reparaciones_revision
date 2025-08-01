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
app.use(express.json()); // Para parsear JSON en login
app.use(express.static('public'));


// Pool de conexión MySQL
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'admin',
  database: 'ControlDeReparaciones',
  waitForConnections: true,
  connectionLimit: 10,
});


// Ruta de index
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'views', 'pages', 'index.html'));
});

// Ruta directa al dashboard
app.get('/dashboard.html', (req, res) => {
  res.sendFile(path.join(__dirname, 'views', 'pages', 'dashboard.html'));
});

// Mostrar formulario de nueva reparación
app.get('/reparaciones/nueva', async (req, res, next) => {
  try {
    const [tipos]       = await pool.query('SELECT tipo_id, nombre FROM tipos_equipos');
    //const [marcas]      = await pool.query('SELECT marca_id, nombre FROM marcas');
    //const [modelos]     = await pool.query('SELECT modelo_id, nombre FROM modelos');
    const [equipos]     = await pool.query('SELECT equipo_id, nombre FROM equipos');
    const [refacciones] = await pool.query('SELECT refaccion_id, nombre FROM refacciones');
    const [areas]       = await pool.query('SELECT area_id, nombre FROM areas');

    const success = req.query.success === '1';

    res.render('form-reparacion', {
      tipos,
      //marcas,
      //modelos,
      equipos,
      refacciones,
      areas,
      success
    });
  } catch (err) {
    next(err);
  }
});

// Endpoint para obtener marcas por tipo_id dinámicamente
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

// Endpoint para obtener modelos por marca_id dinámicamente
app.get('/modelos/:marcaId', async (req, res) => {
  const { marcaId } = req.params;

  try {
    const [modelos] = await pool.query(
      'SELECT modelo_id, nombre FROM modelos WHERE marca_id = ?',
      [marcaId]
    );
    res.json(modelos);
  } catch (error) {
    console.error('Error al obtener modelos:', error);
    res.status(500).json({ error: 'Error al obtener modelos' });
  }
});


// Procesar envío del formulario
app.post('/reparaciones', async (req, res, next) => {
  const {
    modelo_id,
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
         (modelo_id, inventario, refaccion_id, descripcion, fecha, usuario_id)
       VALUES (?, ?, ?, ?, CURDATE(), ?)`,
      [modelo_id, inventario_equipo, refaccion_id, descripcion, usuario_id]
    );

    res.redirect('/reparaciones/nueva?success=1');
  } catch (err) {
    next(err);
  }
});

// Mostrar lista de reparaciones
app.get('/reparaciones/lista', async (req, res, next) => {
  try {
    const [rows] = await pool.query(`
      SELECT 
        te.nombre AS tipo_equipo,
        m.nombre AS marca,
        mo.nombre AS modelo,
        r.inventario AS inventario_equipo,
        rf.nombre AS nombre_refaccion,
        rf.refaccion_inventario AS inventario_refaccion,
        r.descripcion AS descripcion_reparacion,
        r.fecha AS fecha_reparacion,
        u.expediente AS expediente_usuario,
        a.nombre AS area_usuario
      FROM reparacion r
      JOIN modelos mo ON r.modelo_id = mo.modelo_id
      JOIN marcas m ON mo.marca_id = m.marca_id
      JOIN tipos_equipos te ON m.tipo_id = te.tipo_id
      LEFT JOIN refacciones rf ON r.refaccion_id = rf.refaccion_id
      JOIN usuarios u ON r.usuario_id = u.usuario_id
      JOIN areas a ON u.area_id = a.area_id
      ORDER BY r.fecha DESC
    `);

    res.render('lista-reparacion', {
      title: 'Lista de Reparaciones',
      reparaciones: rows
    });
  } catch (err) {
    next(err);
  }
});

// NUEVA RUTA: Validar login para usuario único "Administrador"
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  const ADMIN_USER = 'Administrador';
  const ADMIN_PASS = 'admin';

  if (username === ADMIN_USER && password === ADMIN_PASS) {
    return res.json({ success: true });
  }

  return res.status(401).json({ success: false, message: 'Credenciales incorrectas' });
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
