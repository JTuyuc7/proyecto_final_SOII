DO $$
BEGIN
  FOR i IN 1..5000 LOOP
    INSERT INTO usuarios (username, nombre, apellido, correo)
    VALUES (
      CONCAT('Usuario_', i),
      CONCAT('Nombre_', i),
      CONCAT('Apellido_', i),
      CONCAT('usuario_', i, '@ejemplo.com')
    );
  END LOOP;
END $$;
