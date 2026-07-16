-- ============================================================
--  ProsperApp — Seed Data
--  Proyecto Final Bases de Datos · Universidad del Valle
-- ============================================================

-- ── USUARIOS ─────────────────────────────────────────────────
INSERT INTO USUARIO (nombre, email, password_hash) VALUES
    ('Jefferson Peña',   'jefferson@email.com', '$2b$10$hashedpassword1'),
    ('Ana Martínez',     'ana@email.com',        '$2b$10$hashedpassword2'),
    ('Carlos Ríos',      'carlos@email.com',     '$2b$10$hashedpassword3');

-- ── PROYECTOS ────────────────────────────────────────────────
INSERT INTO PROYECTO (id_usuario, nombre, descripcion, fecha_creacion, estado) VALUES
    (1, 'Portfolio Personal',   'Sitio web para mostrar mis proyectos',       '2026-01-10', 'activo'),
    (1, 'Bot de Telegram',      'Bot para recordatorios diarios',             '2026-02-15', 'activo'),
    (2, 'App de Presupuesto',   'Control de gastos personales',               '2026-03-01', 'pausado'),
    (3, 'CLI de Tareas',        'Herramienta de línea de comandos para TODO', '2026-01-20', 'archivado');

-- ── SECCIONES ────────────────────────────────────────────────
INSERT INTO SECCION (id_proyecto, nombre, orden) VALUES
    -- Proyecto 1: Portfolio (4 secciones)
    (1, 'Backlog',    1),
    (1, 'Doing',      2),
    (1, 'Completed',  3),
    (1, 'Release',    4),
    -- Proyecto 2: Bot Telegram (3 secciones)
    (2, 'Backlog',    1),
    (2, 'Doing',      2),
    (2, 'Completed',  3),
    -- Proyecto 3: App Presupuesto (2 secciones)
    (3, 'Pendiente',  1),
    (3, 'Hecho',      2);

-- ── FUNCIONALIDADES ──────────────────────────────────────────
INSERT INTO FUNCIONALIDAD (id_seccion, titulo, historia_usuario, prioridad, posicion, fecha_creacion) VALUES
    -- Sección 1 (Portfolio - Backlog)
    (1, 'Sección de contacto',
        'Como visitante, quiero un formulario de contacto para escribirle al dueño del portfolio.',
        'media', 1, '2026-01-11'),
    (1, 'Modo oscuro',
        'Como usuario, quiero alternar entre modo claro y oscuro para mayor comodidad visual.',
        'baja', 2, '2026-01-11'),
    -- Sección 2 (Portfolio - Doing)
    (2, 'Galería de proyectos',
        'Como visitante, quiero ver los proyectos con imagen y descripción para evaluarlos.',
        'alta', 1, '2026-01-12'),
    -- Sección 3 (Portfolio - Completed)
    (3, 'Página de inicio',
        'Como visitante, quiero ver una presentación clara del desarrollador al entrar.',
        'alta', 1, '2026-01-13'),
    -- Sección 5 (Bot - Backlog)
    (5, 'Comando /ayuda',
        'Como usuario del bot, quiero un comando /ayuda que liste todas las opciones disponibles.',
        'alta', 1, '2026-02-16'),
    -- Sección 6 (Bot - Doing)
    (6, 'Recordatorio diario',
        'Como usuario, quiero recibir un mensaje cada mañana con mis tareas del día.',
        'alta', 1, '2026-02-17'),
    -- Sección 8 (Presupuesto - Pendiente)
    (8, 'Registro de gastos',
        'Como usuario, quiero registrar un gasto con categoría y monto para llevar control.',
        'alta', 1, '2026-03-02');

-- ── SUBTAREAS ────────────────────────────────────────────────
INSERT INTO SUBTAREA (id_funcionalidad, descripcion, completada) VALUES
    (3, 'Diseñar tarjeta de proyecto en Figma',     TRUE),
    (3, 'Implementar componente React',              FALSE),
    (3, 'Conectar con API de GitHub',                FALSE),
    (4, 'Escribir copy de presentación',             TRUE),
    (4, 'Maquetar sección hero',                     TRUE),
    (6, 'Configurar cron job en servidor',           FALSE),
    (6, 'Redactar mensaje de recordatorio',          TRUE);

-- ── NOTAS ────────────────────────────────────────────────────
INSERT INTO NOTA (id_funcionalidad, contenido, fecha) VALUES
    (3, 'Usar lazy loading para las imágenes de proyectos.',           '2026-01-14'),
    (3, 'Revisar diseño de Dribbble para inspiración de tarjetas.',    '2026-01-15'),
    (6, 'El cron debe correr a las 7:00 AM hora Colombia (UTC-5).',    '2026-02-18'),
    (7, 'Categorías iniciales: comida, transporte, entretenimiento.',   '2026-03-03');

-- ── FRAGMENTOS DE CÓDIGO ─────────────────────────────────────
INSERT INTO FRAGMENTO_CODIGO (id_funcionalidad, lenguaje, codigo) VALUES
    (6, 'JavaScript',
        'const cron = require(''node-cron'');
cron.schedule(''0 7 * * *'', () => {
  bot.sendMessage(chatId, ''Buenos días! Tus tareas de hoy:'');
});'),
    (7, 'SQL',
        'SELECT categoria, SUM(monto) as total
FROM gasto
WHERE EXTRACT(MONTH FROM fecha) = EXTRACT(MONTH FROM CURRENT_DATE)
GROUP BY categoria
ORDER BY total DESC;');

-- ── DECISIONES TÉCNICAS ──────────────────────────────────────
INSERT INTO DECISION_TECNICA (id_funcionalidad, descripcion, fecha) VALUES
    (3, 'Se usará la API de GitHub para obtener repos automáticamente en lugar de datos hardcodeados.',  '2026-01-14'),
    (6, 'Se eligió node-cron sobre setTimeout por ser más confiable para tareas programadas en Node.js.','2026-02-18'),
    (7, 'Se usará PostgreSQL en lugar de SQLite por mejor soporte de tipos y escalabilidad futura.',     '2026-03-03');
