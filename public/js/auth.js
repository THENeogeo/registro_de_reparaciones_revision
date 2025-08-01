document.addEventListener('DOMContentLoaded', () => {
  const loginForm = document.getElementById('loginForm');
  if (loginForm) {
    loginForm.addEventListener('submit', async (e) => {
      e.preventDefault();

      const username = document.getElementById('username').value.trim();
      const password = document.getElementById('password').value.trim();

      try {
        const res = await fetch('/login', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ username, password }),
        });

        const data = await res.json();

        if (data.success) {
          localStorage.setItem('isLoggedIn', 'true');
          window.location.href = 'dashboard.html';
        } else {
          alert(data.message || 'Credenciales incorrectas');
        }
      } catch (err) {
        console.error('Error de red:', err);
        alert('Error en la conexión con el servidor');
      }
    });
  }

  // logout como ya estaba
  const logoutBtn = document.getElementById('logoutBtn');
  if (logoutBtn) {
    logoutBtn.addEventListener('click', () => {
      localStorage.removeItem('isLoggedIn');
      window.location.href = '/';
    });
  }

  checkAuth();
});
