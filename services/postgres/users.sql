DO $$
BEGIN
  FOR i IN 1..10000 LOOP
    INSERT INTO usuarios (nombre, correo)
    VALUES (
      CONCAT('Usuario_', i),
      CONCAT('usuario_', i, '@ejemplo.com')
    );
  END LOOP;
END $$;
