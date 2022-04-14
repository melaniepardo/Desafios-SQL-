-- Requerimientos
-- 1.Cargar el respaldo de la base de datos unidad2.sql.
--Creando base de datos llamada blog.
--ruta del programa a usar: C:\Program Files\PostgreSQL\14\bin
CREATE DATABASE unidad2;
-- con \c nos vamos a la database
\c unidad2
--cargando base de datos
psql -U postgres unidad2 < C:/Users/melan/Desktop/sql01/desafio_comportamiento_clientes/unidad2.sql

--2.El cliente usuario01 ha realizado la siguiente compra:
-- ● producto: producto9.
--● cantidad: 5.
--● fecha: fecha del sistema.
BEGIN TRANSACTION;

INSERT INTO
    compra (cliente_id, fecha)
VALUES
    (1, now());

INSERT INTO
    detalle_compra (producto_id, compra_id, cantidad)
VALUES
    (9, 40, 5);

UPDATE
    producto
SET
    stock = stock - 5
WHERE
    id = 9;
ROLLBACK;

--Mediante el uso de transacciones,realiza las consultas correspondientes
-- para este requerimiento y luego consulta la tabla producto para validar si
--fue efectivamente descontado en el stock.



--3.El cliente usuario02 ha realizado la siguiente compra:
--● producto: producto1,producto 2,producto 8.
--● cantidad: 3 de cada producto.● fecha: fecha del sistema._ 2 www.desafiolatam.com Mediante el uso de transacciones,
-- realiza las consultas correspondientes para este requerimiento y luego consulta la tabla producto para validar que si alguno de ellos se queda sin stock,
-- no se realice la compra.

BEGIN TRANSACTION;

INSERT INTO
    compra (cliente_id, fecha)
VALUES
    (2, now());

INSERT INTO
    detalle_compra (producto_id, compra_id, cantidad)
VALUES
    (1, 41, 3);

UPDATE
    producto
SET
    stock = stock - 3
WHERE
    id = 1;

INSERT INTO
    detalle_compra (producto_id, compra_id, cantidad)
VALUES
    (2, 41, 3);

UPDATE
    producto
SET
    stock = stock - 3
WHERE
    id = 2;

SAVEPOINT nueva_compra;

INSERT INTO
    detalle_compra (producto_id, compra_id, cantidad)
VALUES
    (8, 41, 3);


UPDATE
    producto
SET
    stock = stock - 3
WHERE
    id = 8;

ROLLBACK TO nueva_compra;


--4.Realizar las siguientes consultas: a.Deshabilitar el AUTOCOMMIT.b.Insertar un nuevo cliente.c.Confirmar que fue agregado en la tabla cliente.d.Realizar un ROLLBACK.e.Confirmar que se restauró la información,
-- sin considerar la inserción del punto b.f.Habilitar de nuevo el AUTOCOMMIT.

-- a. Deshabilitar el AUTOCOMMIT.
\
set
    AUTOCOMMIT off -- b. Insertar un nuevo cliente.
INSERT INTO
    cliente(nombre, email)
VALUES
    ('usuario11', 'usuario11@gmail.com');

-- c. Confirmar que fue agregado en la tabla cliente.
SELECT
    *
FROM
    cliente;

-- d. Realizar un ROLLBACK.
ROLLBACK;

-- e. Confirmar que se restauró la información, sin considerar la inserción del
-- punto b.
SELECT
    *
FROM
    cliente;

-- f. Habilitar de nuevo el AUTOCOMMIT.
\
set
    AUTOCOMMIT on