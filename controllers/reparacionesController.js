exports.mostrarFormulario = (req, res) => {
  res.render('form-reparacion', { title: 'Formulario de Reparación' });
};

exports.procesarFormulario = (req, res) => {
  console.log('Datos recibidos:', req.body);
  res.redirect('/dashboard');
};