-- ============================================================
--  ProsperApp — Consultas principales
--  Proyecto Final Bases de Datos · Universidad del Valle
-- ============================================================


-- ── Q1: Dashboard ────────────────────────────────────────────
-- Proyectos activos de un usuario con su progreso
-- (% de funcionalidades en sección 'Completed' o 'Release')
SELECT
    p.id_proyecto,
    p.nombre,
    p.estado,
    COUNT(f.id_funcionalidad)                              AS total_funcionalidades,
    COUNT(f.id_funcionalidad) FILTER (
        WHERE s.nombre IN ('Completed', 'Release')
    )                                                      AS completadas,
    ROUND(
        COUNT(f.id_funcionalidad) FILTER (
            WHERE s.nombre IN ('Completed', 'Release')
        ) * 100.0 /
        NULLIF(COUNT(f.id_funcionalidad), 0), 1
    )                                                      AS porcentaje_progreso
FROM PROYECTO p
JOIN SECCION s            ON s.id_proyecto      = p.id_proyecto
LEFT JOIN FUNCIONALIDAD f ON f.id_seccion        = s.id_seccion
WHERE p.id_usuario = 1
  AND p.estado     = 'activo'
GROUP BY p.id_proyecto, p.nombre, p.estado
ORDER BY p.fecha_creacion DESC;


-- ── Q2: Tablero ───────────────────────────────────────────────
-- Funcionalidades de un proyecto agrupadas por sección,
-- ordenadas por posición dentro de cada sección
SELECT
    s.nombre        AS seccion,
    s.orden         AS orden_seccion,
    f.id_funcionalidad,
    f.titulo,
    f.historia_usuario,
    f.prioridad,
    f.posicion
FROM SECCION s
LEFT JOIN FUNCIONALIDAD f ON f.id_seccion = s.id_seccion
WHERE s.id_proyecto = 1
ORDER BY s.orden, f.posicion;


-- ── Q3: Detalle de funcionalidad ─────────────────────────────
-- Todo el contenido de una funcionalidad: subtareas, notas,
-- fragmentos de código y decisiones técnicas
SELECT
    f.titulo,
    f.historia_usuario,
    f.prioridad,
    st.descripcion  AS subtarea,
    st.completada,
    n.contenido     AS nota,
    n.fecha         AS fecha_nota,
    fc.lenguaje,
    fc.codigo,
    dt.descripcion  AS decision_tecnica,
    dt.fecha        AS fecha_decision
FROM FUNCIONALIDAD f
LEFT JOIN SUBTAREA          st ON st.id_funcionalidad = f.id_funcionalidad
LEFT JOIN NOTA               n ON  n.id_funcionalidad = f.id_funcionalidad
LEFT JOIN FRAGMENTO_CODIGO  fc ON fc.id_funcionalidad = f.id_funcionalidad
LEFT JOIN DECISION_TECNICA  dt ON dt.id_funcionalidad = f.id_funcionalidad
WHERE f.id_funcionalidad = 3;


-- ── Q4: Tareas pendientes del usuario ────────────────────────
-- Subtareas sin completar en todos los proyectos activos
SELECT
    p.nombre        AS proyecto,
    f.titulo        AS funcionalidad,
    st.descripcion  AS subtarea_pendiente
FROM SUBTAREA st
JOIN FUNCIONALIDAD f ON f.id_funcionalidad = st.id_funcionalidad
JOIN SECCION s       ON s.id_seccion       = f.id_seccion
JOIN PROYECTO p      ON p.id_proyecto      = s.id_proyecto
WHERE p.id_usuario  = 1
  AND p.estado      = 'activo'
  AND st.completada = FALSE
ORDER BY p.nombre, f.posicion;


-- ── Q5: Progreso de subtareas por funcionalidad ──────────────
-- Total y completadas por funcionalidad (barra de progreso en tarjeta)
SELECT
    f.id_funcionalidad,
    f.titulo,
    COUNT(st.id_subtarea)                               AS total_subtareas,
    COUNT(st.id_subtarea) FILTER (WHERE st.completada)  AS completadas,
    ROUND(
        COUNT(st.id_subtarea) FILTER (WHERE st.completada) * 100.0 /
        NULLIF(COUNT(st.id_subtarea), 0), 0
    )                                                   AS porcentaje
FROM FUNCIONALIDAD f
LEFT JOIN SUBTAREA st ON st.id_funcionalidad = f.id_funcionalidad
WHERE f.id_seccion IN (
    SELECT id_seccion FROM SECCION WHERE id_proyecto = 1
)
GROUP BY f.id_funcionalidad, f.titulo
ORDER BY f.posicion;


-- ── Q6: Funcionalidades por prioridad ────────────────────────
-- Para filtrar el tablero por prioridad
SELECT
    f.titulo,
    f.prioridad,
    s.nombre AS seccion
FROM FUNCIONALIDAD f
JOIN SECCION s ON s.id_seccion = f.id_seccion
WHERE s.id_proyecto = 1
ORDER BY
    CASE f.prioridad
        WHEN 'alta'  THEN 1
        WHEN 'media' THEN 2
        WHEN 'baja'  THEN 3
    END,
    f.posicion;
