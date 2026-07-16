-- ============================================================
--  ProsperApp — Schema DDL
--  Proyecto Final Bases de Datos · Universidad del Valle
-- ============================================================

-- ── USUARIO ──────────────────────────────────────────────────
CREATE TABLE USUARIO (
    id_usuario      SERIAL          PRIMARY KEY,
    nombre          VARCHAR(100)    NOT NULL,
    email           VARCHAR(150)    NOT NULL UNIQUE,
    password_hash   VARCHAR(255)    NOT NULL
);

-- ── PROYECTO ─────────────────────────────────────────────────
CREATE TABLE PROYECTO (
    id_proyecto     SERIAL          PRIMARY KEY,
    id_usuario      INT             NOT NULL,
    nombre          VARCHAR(150)    NOT NULL,
    descripcion     TEXT,
    fecha_creacion  DATE            NOT NULL DEFAULT CURRENT_DATE,
    estado          VARCHAR(20)     NOT NULL DEFAULT 'activo'
                                    CHECK (estado IN ('activo', 'pausado', 'archivado')),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE
);

-- ── SECCION ──────────────────────────────────────────────────
CREATE TABLE SECCION (
    id_seccion      SERIAL          PRIMARY KEY,
    id_proyecto     INT             NOT NULL,
    nombre          VARCHAR(100)    NOT NULL,
    orden           INT             NOT NULL DEFAULT 1
                                    CHECK (orden BETWEEN 1 AND 6),
    FOREIGN KEY (id_proyecto) REFERENCES PROYECTO(id_proyecto)
        ON DELETE CASCADE
);

-- ── FUNCIONALIDAD ─────────────────────────────────────────────
CREATE TABLE FUNCIONALIDAD (
    id_funcionalidad SERIAL         PRIMARY KEY,
    id_seccion       INT            NOT NULL,
    titulo           VARCHAR(200)   NOT NULL,
    historia_usuario TEXT,
    prioridad        VARCHAR(10)    NOT NULL DEFAULT 'media'
                                    CHECK (prioridad IN ('alta', 'media', 'baja')),
    posicion         INT            NOT NULL DEFAULT 1,
    fecha_creacion   DATE           NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_seccion) REFERENCES SECCION(id_seccion)
        ON DELETE CASCADE
);

-- ── SUBTAREA ─────────────────────────────────────────────────
CREATE TABLE SUBTAREA (
    id_subtarea      SERIAL         PRIMARY KEY,
    id_funcionalidad INT            NOT NULL,
    descripcion      TEXT           NOT NULL,
    completada       BOOLEAN        NOT NULL DEFAULT FALSE,
    FOREIGN KEY (id_funcionalidad) REFERENCES FUNCIONALIDAD(id_funcionalidad)
        ON DELETE CASCADE
);

-- ── NOTA ─────────────────────────────────────────────────────
CREATE TABLE NOTA (
    id_nota          SERIAL         PRIMARY KEY,
    id_funcionalidad INT            NOT NULL,
    contenido        TEXT           NOT NULL,
    fecha            DATE           NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_funcionalidad) REFERENCES FUNCIONALIDAD(id_funcionalidad)
        ON DELETE CASCADE
);

-- ── FRAGMENTO_CODIGO ─────────────────────────────────────────
CREATE TABLE FRAGMENTO_CODIGO (
    id_fragmento     SERIAL         PRIMARY KEY,
    id_funcionalidad INT            NOT NULL,
    lenguaje         VARCHAR(50)    NOT NULL,
    codigo           TEXT           NOT NULL,
    FOREIGN KEY (id_funcionalidad) REFERENCES FUNCIONALIDAD(id_funcionalidad)
        ON DELETE CASCADE
);

-- ── DECISION_TECNICA ─────────────────────────────────────────
CREATE TABLE DECISION_TECNICA (
    id_decision      SERIAL         PRIMARY KEY,
    id_funcionalidad INT            NOT NULL,
    descripcion      TEXT           NOT NULL,
    fecha            DATE           NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_funcionalidad) REFERENCES FUNCIONALIDAD(id_funcionalidad)
        ON DELETE CASCADE
);
