# ProsperApp

Herramienta para gestionar proyectos de software personales. Proyecto final del curso de Bases de Datos — Universidad del Valle.

## ¿Qué es esto?

Una app tipo Kanban pensada para developers que trabajan solos en sus proyectos personales. Podés organizar tus ideas en tableros, dividirlas en tareas y llevar registro de decisiones técnicas, notas y snippets de código.

## Estructura del repo

```
/docs        → diagramas ER y MER, informe
/db          → schema.sql y seed.sql
/backend     → API REST
/frontend    → interfaz de usuario
```

## Base de datos

PostgreSQL. Para inicializar:

```bash
psql -U tu_usuario -d prosperapp -f db/schema.sql
psql -U tu_usuario -d prosperapp -f db/seed.sql
```

## Entidades principales

`USUARIO` → `PROYECTO` → `SECCION` → `FUNCIONALIDAD` → subtareas, notas, código, decisiones técnicas

## Stack

- **Backend:** Node.js + Express
- **BD:** PostgreSQL
- **Frontend:** React + Tailwind

## Equipo

Pablo Alejandro Arias Gaviria — Estudiante de la escuela de Ingeniería de Sistemas y Computación, Univalle
