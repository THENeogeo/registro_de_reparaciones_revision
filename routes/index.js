const express = require('express');
const router = express.Router();
const reparacionesController = require('../controllers/reparacionesController');

router.get('/', (req, res) => res.redirect('/form-reparacion'));
router.get('/form-reparacion', reparacionesController.mostrarFormulario);
router.post('/form-reparacion', reparacionesController.procesarFormulario);

router.get('/dashboard', (req, res) => {
  res.render('dashboard', { title: 'Dashboard' });
});

module.exports = router;