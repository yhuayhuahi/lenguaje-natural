const boton_enviar = document.querySelector('#enviar');

async function consultar(consulta) {
  // Verifica si la consulta está vacía antes de hacer la solicitud
  if (!consulta.trim()) {
    return { mensaje: "La consulta no puede estar vacía." };
  }

  const objeto = {
    consulta: consulta
  };
  const mi_consulta = JSON.stringify(objeto);

  const options = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: mi_consulta
  };

  let datos = null; // inicializado en null

  try {
    const res = await fetch('http://127.0.0.1:3000/consulta/', options);

    if (!res.ok) {
      throw new Error(`HTTP error! status: ${res.status}`);
    }

    datos = await res.json();
  } 
  catch (err) {
    // Llamar a logAndHandleError y pasar el error correctamente
    function logAndHandleError(err) {
      const status = err?.cause?.res?.status; // Asegúrate de acceder a la causa correctamente
      let respuesta = {}; // Asegura que `datos` siempre sea un objeto
    
      // Lógica de manejo de errores con base en el estado de la respuesta
      if (status === 400) {
        respuesta = {
          mensaje: datos.error
        }
        console.error('Bad request:', err);
      } 
      else if(status === 404) {
        console.error('Revisar el error:', err);
        respuesta = {
          mensaje: datos.mensaje
        }
      } else {
        respuesta = {
          mensaje: 'La consulta no es correcta.'
        }
      }
    
      return respuesta;
    }
    datos = logAndHandleError(err); 
  }

  return datos;
}

boton_enviar.addEventListener('click', async () => {
  const elemento_temporal = document.getElementById('error')
  if(elemento_temporal) {
    elemento_temporal.remove()
  }
  
  const consulta = document.querySelector('#consulta').value.trim(); // Usamos `trim()` para evitar espacios vacíos
  const datos = await consultar(consulta);

  const caja = document.querySelector('#contenido');
  const nuevoDiv = document.createElement('div');
  nuevoDiv.id = 'error'

  if(Array.isArray(datos)) {
    caja.innerHTML = ''

    const recargar = document.createElement('button');
    recargar.textContent = 'Buscar otra vivienda';
    recargar.addEventListener('click', () => {
      window.location.reload();
    });
    caja.appendChild(recargar);

    const tabla = document.createElement('table');
    const encabezado = `
      <tr>
        <th>ID</th>
        <th>Tipo</th>
        <th>Zona</th>
        <th>Número de Dormitorios</th>
        <th>Precio</th>
        <th>Tamaño</th>
        <th>Extras</th>
        <th>Foto</th>
      </tr>
    `;
    tabla.innerHTML = encabezado;

    // Agregar filas a la tabla
    datos.forEach(item => {
      const fila = document.createElement('tr');
      fila.innerHTML = `
        <td>${item.id}</td>
        <td>${item.tipo}</td>
        <td>${item.zona}</td>
        <td>${item.ndormitorios}</td>
        <td>${item.precio}</td>
        <td>${item.tamano}</td>
        <td>${item.extras}</td>
        <td><img src="${item.foto}" alt="Foto de la vivienda" width="100"></td>
      `;
      tabla.appendChild(fila);
    });
    caja.appendChild(tabla);
  }
  else if ('error' in  datos){
    nuevoDiv.textContent = datos.mensaje
  }
  else {
    nuevoDiv.textContent = datos.mensaje
  }
  caja.appendChild(nuevoDiv);
});
