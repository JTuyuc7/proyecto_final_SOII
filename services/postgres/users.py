import psycopg2
from psycopg2.extras import execute_values

# Conexión a PostgreSQL
conn = psycopg2.connect(
    host="localhost",       # o la IP del contenedor si está fuera
    port=5432,              # o 6432 si lo haces desde fuera del droplet
    database="proyectos",
    user="remotereader",
    password="tu_password_segura"
)

cur = conn.cursor()

# Generar datos
usuarios = [
    (f"Usuario_{i}", f"usuario_{i}@ejemplo.com")
    for i in range(1, 10001)  # Cambia este valor para más
]

# Insertar por lote
query = "INSERT INTO usuarios (nombre, correo) VALUES %s"
execute_values(cur, query, usuarios)

conn.commit()
cur.close()
conn.close()

print("✅ Usuarios insertados correctamente.")
