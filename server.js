// server.js
require('dotenv').config({ path: './config.env' });

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

// Pool de conexión MySQL c k c c / c u

const pool = mysql.createPool({
    host: process.env.DB_HOST,     
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
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

// Envío  del formulario
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

    const now = new Date(); 
    const hora = now.toTimeString().split(' ')[0]; // Formato 'HH:MM:SS'

    await pool.query(
      `INSERT INTO reparacion
         (modelo_id, inventario, refaccion_id, descripcion, fecha, hora, usuario_id)
       VALUES (?, ?, ?, ?, CURDATE(), ?, ?)`,
      [modelo_id, inventario_equipo, refaccion_id, descripcion, hora, usuario_id]
    );

    res.redirect('/reparaciones/nueva?success=1');
  } catch (err) {
    next(err);
  }
});

// -------------------------------------------Listado de reparaciones (con paginación)
app.get('/reparaciones/lista', async (req, res, next) => {
  const { tipo_equipo, marca, modelo, inventario_equipo, fecha_inicio, fecha_fin, area } = req.query;

  // Paginación
  let page  = Math.max(parseInt(req.query.page || '1', 10), 1);
  const LIMIT_DEFAULT = 5;        // <- cámbialo a la cantidad que quieras
  const limit = LIMIT_DEFAULT;     // <- límite fijo
  const offset = (page - 1) * limit;


  try {
    const connection = await pool.getConnection();

    // Base + filtros (reutilizamos en SELECT y COUNT)
    const baseSql = `
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

    let where = '';
    const params = [];

    if (tipo_equipo) {
      where += ' AND te.nombre = ?';
      params.push(tipo_equipo);
    }
    if (marca) {
      where += ' AND m.nombre = ?';
      params.push(marca);
    }
    if (modelo) {
      where += ' AND mo.nombre = ?';
      params.push(modelo);
    }
    if (inventario_equipo) {
      where += ' AND r.inventario = ?';
      params.push(inventario_equipo);
    }
    if (area) {
      where += ' AND a.nombre = ?';
      params.push(area);
    }
    if (fecha_inicio && fecha_fin) {
      where += ' AND r.fecha BETWEEN ? AND ?';
      params.push(fecha_inicio, fecha_fin);
    } else if (fecha_inicio) {
      where += ' AND r.fecha >= ?';
      params.push(fecha_inicio);
    } else if (fecha_fin) {
      where += ' AND r.fecha <= ?';
      params.push(fecha_fin);
    }

    // COUNT total
    const countSql = `SELECT COUNT(*) AS total ${baseSql} ${where}`;
    const [countRows] = await connection.query(countSql, params);
    const total = countRows[0]?.total || 0;
    const totalPages = Math.max(Math.ceil(total / limit), 1);

    // SELECT con orden y paginación
    const selectSql = `
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
      ${baseSql} ${where}
      ORDER BY r.fecha DESC, r.hora DESC
      LIMIT ? OFFSET ?
    `;
    const [reparaciones] = await connection.query(selectSql, [...params, limit, offset]);

    // Opciones para selects (sin cambios)
    const [tipos] = await connection.query(`
      SELECT DISTINCT te.nombre AS tipo_equipo
      FROM tipos_equipos te
      JOIN marcas m ON te.tipo_id = m.tipo_id
      JOIN modelos mo ON m.marca_id = mo.marca_id
      JOIN reparacion r ON mo.modelo_id = r.modelo_id
    `);
    const [marcas] = await connection.query(`
      SELECT DISTINCT m.nombre AS marca
      FROM marcas m
      JOIN modelos mo ON m.marca_id = mo.marca_id
      JOIN reparacion r ON mo.modelo_id = r.modelo_id
    `);
    const [modelos] = await connection.query(`
      SELECT DISTINCT mo.nombre AS modelo
      FROM modelos mo
      JOIN reparacion r ON mo.modelo_id = r.modelo_id
    `);
    const [inventarios] = await connection.query(`
      SELECT DISTINCT r.inventario AS inventario_equipo
      FROM reparacion r
    `);
    const [areas] = await connection.query(`
      SELECT DISTINCT a.nombre AS area
      FROM areas a
      JOIN usuarios u ON a.area_id = u.area_id
      JOIN reparacion r ON u.usuario_id = r.usuario_id
    `);

    connection.release();

    res.render('lista-reparacion', {
      title: 'Lista de Reparaciones',
      reparaciones,
      tipos, marcas, modelos, inventarios, areas,

      // valores seleccionados
      tipo_equipo: tipo_equipo || '',
      marca: marca || '',
      modelo: modelo || '',
      inventario_equipo: inventario_equipo || '',
      area: area || '',
      fecha_inicio: fecha_inicio || '',
      fecha_fin: fecha_fin || '',

      // paginación
      page, limit, total, totalPages
    });
  } catch (err) {
    next(err);
  }
});

//----------------------------------CONSUMIBLES----------------------------------------------------------------------
// Ruta para mostrar formulario de consumibles
app.get('/consumibles/nuevo', async (req, res) => {
  try {
    const [consumibles] = await pool.query("SELECT * FROM catalogo_consumibles");
    const [tiposRef] = await pool.query("SELECT tipo_ref_id, nombre FROM tipo_refaccion"); // asegúrate que 'nombre' existe
    const [areas] = await pool.query("SELECT * FROM areas");
    const [usuarios] = await pool.query("SELECT usuario_id, nombre FROM usuarios"); // para mostrar lista de usuarios

    res.render('form-consumibles', { consumibles, tiposRef, areas, usuarios, success: false });
  } catch (err) {
    console.error("Error cargando formulario de consumibles:", err);
    res.status(500).send("Error cargando formulario de consumibles");
  }
});

// Ruta para guardar consumible
app.post('/consumibles/nuevo', async (req, res) => {
  try {
    const { consumible_id, inventario, marca, modelo, tipo_ref_id, descripcion, nombre, area_id } = req.body;

    // Insertar usuario
    const [userResult] = await pool.query(
      `INSERT INTO usuarios (nombre, area_id) VALUES (?, ?)`,
      [nombre, area_id]
    );
    const usuario_id = userResult.insertId;

    // Insertar consumible
    await pool.query(
      `INSERT INTO registro_consumible 
      (consumible_id, inventario, marca, modelo, tipo_ref_id, descripcion, usuario_id, area_id) 
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [consumible_id, inventario, marca, modelo, tipo_ref_id, descripcion, usuario_id, area_id]
    );

    // Recargar datos para el formulario
    const [consumibles] = await pool.query("SELECT * FROM catalogo_consumibles");
    const [tiposRef] = await pool.query("SELECT tipo_ref_id, nombre FROM tipo_refaccion");
    const [areas] = await pool.query("SELECT * FROM areas");

    //Redirecciona nuevamente al formulario vacio
    res.render('form-consumibles', { consumibles, tiposRef, areas, success: true });

  } catch (err) {
    console.error("Error al guardar consumible:", err);
    res.status(500).send("Error al guardar consumible");
  }
});

// ---------------------------------- LISTADO DE CONSUMIBLES (con paginación)
app.get('/consumibles/lista', async (req, res, next) => {
  const {
    consumible_id,
    marca,
    modelo,
    inventario,
    tipo_ref_id,
    area_id,
    fecha_inicio,
    fecha_fin,
  } = req.query;

  // ➊ Lee paginación de la URL (con límites razonables)
  // Sustituye tu cálculo de limit por uno fijo:
  let page  = Math.max(parseInt(req.query.page || '1', 10), 1);
  const LIMIT_DEFAULT = 5;        // <- cámbialo a la cantidad que quieras
  const limit = LIMIT_DEFAULT;     // <- límite fijo
  const offset = (page - 1) * limit;

  try {
    const connection = await pool.getConnection();

    // ➋ Construye el WHERE una sola vez para reutilizar en SELECT y COUNT
    let where = ' WHERE 1=1';
    const whereParams = [];

    if (consumible_id) { where += ' AND rc.consumible_id = ?'; whereParams.push(consumible_id); }
    if (marca)         { where += ' AND rc.marca = ?';        whereParams.push(marca); }
    if (modelo)        { where += ' AND rc.modelo = ?';       whereParams.push(modelo); }
    if (inventario)    { where += ' AND rc.inventario = ?';   whereParams.push(inventario); }
    if (tipo_ref_id)   { where += ' AND rc.tipo_ref_id = ?';  whereParams.push(tipo_ref_id); }
    if (area_id)       { where += ' AND rc.area_id = ?';      whereParams.push(area_id); }

    if (fecha_inicio && fecha_fin) {
      where += ' AND rc.fecha BETWEEN ? AND ?';
      whereParams.push(fecha_inicio, fecha_fin);
    } else if (fecha_inicio) {
      where += ' AND rc.fecha >= ?';
      whereParams.push(fecha_inicio);
    } else if (fecha_fin) {
      where += ' AND rc.fecha <= ?';
      whereParams.push(fecha_fin);
    }

    // ➌ COUNT total (mismo WHERE, sin LIMIT/OFFSET)
    const [countRows] = await connection.query(
      'SELECT COUNT(*) AS total FROM registro_consumible rc' + where,
      whereParams
    );
    const total = countRows[0]?.total || 0;
    const totalPages = Math.max(Math.ceil(total / limit), 1);

    // ➍ SELECT principal con LIMIT/OFFSET
    const selectSql = `
      SELECT
        DATE_FORMAT(rc.fecha, '%Y-%m-%d') AS fecha,
        TIME_FORMAT(rc.hora, '%H:%i:%s') AS hora,
        cc.nombre AS consumible,
        rc.inventario,
        rc.marca,
        rc.modelo,
        tr.nombre AS tipo_refaccion,
        rc.descripcion,
        u.nombre AS nombre_usuario,
        a.nombre AS area
      FROM registro_consumible rc
      LEFT JOIN catalogo_consumibles cc ON rc.consumible_id = cc.consumible_id
      LEFT JOIN tipo_refaccion tr ON rc.tipo_ref_id = tr.tipo_ref_id
      LEFT JOIN usuarios u ON rc.usuario_id = u.usuario_id
      LEFT JOIN areas a ON rc.area_id = a.area_id
    `;

    const [registros] = await connection.query(
      selectSql + where + ' ORDER BY rc.fecha DESC, rc.hora DESC LIMIT ? OFFSET ?',
      [...whereParams, limit, offset]
    );

    // Opciones para los selects (sin cambios)
    const [consumibles] = await connection.query(`
      SELECT c.consumible_id, c.nombre
      FROM catalogo_consumibles c
      ORDER BY c.nombre
    `);
    const [tiposRef] = await connection.query(`
      SELECT tipo_ref_id, nombre
      FROM tipo_refaccion
      ORDER BY nombre
    `);
    const [areas] = await connection.query(`
      SELECT area_id, nombre
      FROM areas
      ORDER BY nombre
    `);
    const [marcas] = await connection.query(`
      SELECT DISTINCT marca
      FROM registro_consumible
      WHERE marca IS NOT NULL AND marca <> ''
      ORDER BY marca
    `);
    const [modelos] = await connection.query(`
      SELECT DISTINCT modelo
      FROM registro_consumible
      WHERE modelo IS NOT NULL AND modelo <> ''
      ORDER BY modelo
    `);
    const [inventarios] = await connection.query(`
      SELECT DISTINCT inventario
      FROM registro_consumible
      WHERE inventario IS NOT NULL AND inventario <> ''
      ORDER BY inventario
    `);

    connection.release();

    res.render('lista-consumibles', {
      title: 'Lista de Consumibles',
      registros,

      // opciones de selects
      consumibles, tiposRef, areas, marcas, modelos, inventarios,

      // filtros seleccionados (para mantener estado)
      consumible_id: consumible_id || '',
      marca:         marca || '',
      modelo:        modelo || '',
      inventario:    inventario || '',
      tipo_ref_id:   tipo_ref_id || '',
      area_id:       area_id || '',
      fecha_inicio:  fecha_inicio || '',
      fecha_fin:     fecha_fin || '',

      // paginación
      page, limit, total, totalPages
    });
  } catch (err) {
    next(err);
  }
});

// Login
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  const ADMIN_USER = process.env.ADMIN_USER;
  const ADMIN_PASS = process.env.ADMIN_PASS;

  if (username === ADMIN_USER && password === ADMIN_PASS) {
    return res.json({ success: true });
  }

  return res.status(401).json({ success: false, message: 'Credenciales incorrectas' });
});

app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).send('Error interno: ' + err.message);
});

// Iniciar servidor
const PORT = process.env.PORT;
app.listen(PORT, () => {
  console.log(`✅✅ Servidor corriendo en http://localhost:${PORT} ✅✅`);
});