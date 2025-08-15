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
app.use(express.json());
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
    const [equipos]     = await pool.query('SELECT DISTINCT equipo_id, nombre FROM equipos');
    const [refacciones] = await pool.query('SELECT refaccion_id, nombre FROM refacciones');
    const [areas]       = await pool.query('SELECT area_id, nombre FROM areas');
    const [tiposRef]    = await pool.query('SELECT tipo_ref_id, nombre FROM tipo_refaccion');

    const success = req.query.success === '1';

    res.render('form-reparacion', {
      tipos,
      equipos,
      refacciones,
      areas,
      tiposRef,
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

// Endpoint para obtener refacciones por tipo de equipo
app.get('/refacciones/:tipoId', async (req, res) => {
  const { tipoId } = req.params;
  try {
    const [refacciones] = await pool.query(
      `SELECT refaccion_id, nombre
       FROM refacciones
       WHERE tipo_id = ?`,
      [tipoId]
    );
    res.json(refacciones);
  } catch (error) {
    console.error('Error al obtener refacciones:', error);
    res.status(500).json({ error: 'Error al obtener refacciones' });
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
    area_id,
    tipo_refaccion
  } = req.body;

  try {
    //Actualizar inventario de refacción
    await pool.query(
      `UPDATE refacciones
         SET refaccion_inventario = ?, tipo_ref_id = ?
       WHERE refaccion_id = ?`,
      [inventario_refaccion, tipo_refaccion, refaccion_id]
    );

    // Insertar usuario
    const [userResult] = await pool.query(
      `INSERT INTO usuarios
         (expediente, nombre, area_id)
       VALUES (?, ?, ?)`,
      [expediente, nombre, area_id]
    );
    const usuario_id = userResult.insertId;

    //Insertar reparación (fecha y hora)
    await pool.query(
      `INSERT INTO reparacion
         (modelo_id, inventario, refaccion_id, descripcion, fecha, hora, usuario_id)
       VALUES (?, ?, ?, ?, CURDATE(), CURTIME(), ?)`,
      [modelo_id, inventario_equipo, refaccion_id, descripcion, usuario_id]
    );

    res.redirect('/reparaciones/nueva?success=1');
  } catch (err) {
    next(err);
  }
});

// Mostrar lista de reparaciones con filtros y opciones dinámicas para selects
app.get('/reparaciones/lista', async (req, res, next) => {
  const { tipo_equipo, marca, modelo, inventario_equipo, fecha_inicio, fecha_fin, area } = req.query;

  try {
    const connection = await pool.getConnection();

    let query = `
      SELECT 
        te.nombre AS tipo_equipo,
        m.nombre AS marca,
        mo.nombre AS modelo,
        r.inventario AS inventario_equipo,
        rf.nombre AS nombre_refaccion,
        tr.nombre AS tipo_refaccion,
        rf.refaccion_inventario AS inventario_refaccion,
        r.descripcion AS descripcion_reparacion,
        r.fecha AS fecha_reparacion,
        r.hora AS hora_reparacion,
        u.nombre AS nombre_usuario,
        u.expediente AS expediente_usuario,
        a.nombre AS area_usuario
      FROM reparacion r
      JOIN modelos mo ON r.modelo_id = mo.modelo_id
      JOIN marcas m ON mo.marca_id = m.marca_id
      JOIN tipos_equipos te ON m.tipo_id = te.tipo_id
      LEFT JOIN refacciones rf ON r.refaccion_id = rf.refaccion_id
      LEFT JOIN tipo_refaccion tr ON rf.tipo_ref_id = tr.tipo_ref_id
      JOIN usuarios u ON r.usuario_id = u.usuario_id
      JOIN areas a ON u.area_id = a.area_id
      WHERE 1=1
    `;

    const params = [];
    if (tipo_equipo) {
      query += ' AND te.nombre = ?';
      params.push(tipo_equipo);
    }
    if (marca) {
      query += ' AND m.nombre = ?';
      params.push(marca);
    }
    if (modelo) {
      query += ' AND mo.nombre = ?';
      params.push(modelo);
    }
    if (inventario_equipo) {
      query += ' AND r.inventario = ?';
      params.push(inventario_equipo);
    }
    if (area) {
      query += ' AND a.nombre = ?';
      params.push(area);
    }

    if (fecha_inicio && fecha_fin) {
      query += ' AND r.fecha BETWEEN ? AND ?';
      params.push(fecha_inicio, fecha_fin);
    } else if (fecha_inicio) {
      query += ' AND r.fecha >= ?';
      params.push(fecha_inicio);
    } else if (fecha_fin) {
      query += ' AND r.fecha <= ?';
      params.push(fecha_fin);
    }

    // Ordenar por fecha y hora descendente
    query += ' ORDER BY r.fecha DESC, r.hora DESC';

    const [reparaciones] = await connection.query(query, params);

    // Opciones para selects
    const [tipos] = await connection.query(`SELECT DISTINCT te.nombre AS tipo_equipo FROM tipos_equipos te JOIN marcas m ON te.tipo_id = m.tipo_id JOIN modelos mo ON m.marca_id = mo.marca_id JOIN reparacion r ON mo.modelo_id = r.modelo_id`);
    const [marcas] = await connection.query(`SELECT DISTINCT m.nombre AS marca FROM marcas m JOIN modelos mo ON m.marca_id = mo.marca_id JOIN reparacion r ON mo.modelo_id = r.modelo_id`);
    const [modelos] = await connection.query(`SELECT DISTINCT mo.nombre AS modelo FROM modelos mo JOIN reparacion r ON mo.modelo_id = r.modelo_id`);
    const [inventarios] = await connection.query(`SELECT DISTINCT r.inventario AS inventario_equipo FROM reparacion r`);
    const [areas] = await connection.query(`SELECT DISTINCT a.nombre AS area FROM areas a JOIN usuarios u ON a.area_id = u.area_id JOIN reparacion r ON u.usuario_id = r.usuario_id`);

    connection.release();

    res.render('lista-reparacion', {
      title: 'Lista de Reparaciones',
      reparaciones,
      tipos,
      marcas,
      modelos,
      inventarios,
      areas,
      tipo_equipo: tipo_equipo || '',
      marca: marca || '',
      modelo: modelo || '',
      inventario_equipo: inventario_equipo || '',
      area: area || '',
      fecha_inicio: fecha_inicio || '',
      fecha_fin: fecha_fin || ''
    });
  } catch (err) {
    next(err);
  }
});

// Login
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
