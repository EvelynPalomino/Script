/* Eliminar base de datos */
DROP DATABASE db_SalesClothes;
/* Si la base de datos ya existe la eliminamos */
DROP DATABASE IF EXISTS db_SalesClothes;
/* Crear base de datos Sales Clothes */
CREATE DATABASE db_SalesClothes;
/* Poner en uso la base de datos */
USE db_SalesClothes;
/* Poner en uso base de datos master */
USE master;
/* Crear tabla client */
CREATE TABLE client
(
	id int,
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	email varchar(80),
	cell_phone char(9),
	birthdate date,
	active bit
	CONSTRAINT client_pk PRIMARY KEY (id)
);

/* Ver estructura de tabla client */
EXEC sp_columns @table_name = 'client';

/* Listar tablas de la base de datos db_SalesClothes */
SELECT * FROM INFORMATION_SCHEMA.TABLES;

/* Eliminar tabla client */
DROP TABLE client;

/*Crear tabla client*/
CREATE TABLE client (
    id int ,
    type_document char(3),
    number_document char(15),
    names varchar(60),
    last_name varchar(90),
    email varchar(80),
    cell_phone char(9),
    birthdate date ,
    active  bit ,
    CONSTRAINT client_pk PRIMARY KEY(id)
);



/*Crear tabla clothes*/
CREATE TABLE clothes (
    id int,
    description varchar(60),
    brand varchar(60),
    amount int ,
    size varchar(10) ,
    price decimal(8,2) ,
    active bit,
    CONSTRAINT clothes_pk PRIMARY KEY  (id)
);



/*Crear tabla sale*/
CREATE TABLE sale (
    id int,
    date_time datetime ,
    active bit ,
    CONSTRAINT sale_pk PRIMARY KEY  (id)
);


/*Crear tabla seller*/
CREATE TABLE seller (
    id int  ,
    type_document char(3)  ,
    number_document char(15)  ,
    names char(15)  ,
    last_name varchar(90) ,
    salary decimal(8,2)  ,
    cell_phone char(9),
    email varchar(80) ,
    activo bit  NOT NULL,
    CONSTRAINT seller_pk PRIMARY KEY  (id)
)

/*Crear tabla sale_detail*/
CREATE TABLE sale_detail (
    id int ,
    amount int,
    CONSTRAINT sale_detail_pk PRIMARY KEY (id)
);

/*crear relacion*/

/* Relacionar tablas*/

-- Table: sale_detail
CREATE TABLE sale_detail (
    id int  NOT NULL,
    amount int  NOT NULL,
    sale_id int  NOT NULL,
    clothes_id int  NOT NULL,
    CONSTRAINT sale_detail_pk PRIMARY KEY  (id)
);

/* Ver estructura de sale_detail */
EXEC sp_columns @table_name = 'sale_detail';

-- Table: seller
CREATE TABLE seller (
    id int  NOT NULL,
    type_document char(3)  NOT NULL,
    number_document char(15)  NOT NULL,
    names varchar(60)  NOT NULL,
    last_name varchar(90)  NOT NULL,
    salary decimal(8,2)  NOT NULL,
    cell_phone char(9)  NOT NULL,
    email varchar(80)  NOT NULL,
    activo bit  NOT NULL,
    CONSTRAINT seller_pk PRIMARY KEY  (id)
);

/* Ver estructura de seller */
EXEC sp_columns @table_name = 'seller';

-- foreign keys
-- Reference: sale_client (table: sale)
ALTER TABLE sale ADD CONSTRAINT sale_client
    FOREIGN KEY (client_id)
    REFERENCES client (id);

-- Reference: sale_detail_clothes (table: sale_detail)
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_clothes
    FOREIGN KEY (clothes_id)
    REFERENCES clothes (id);

-- Reference: sale_detail_sale (table: sale_detail)
ALTER TABLE sale_detail ADD CONSTRAINT sale_detail_sale
    FOREIGN KEY (sale_id)
    REFERENCES sale (id);

-- Reference: sale_seller (table: sale)
ALTER TABLE sale ADD CONSTRAINT sale_seller
    FOREIGN KEY (seller_id)
    REFERENCES seller (id);

/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO

/* Eliminar una relaci�n */
ALTER TABLE sale
	DROP CONSTRAINT sale_client
GO
/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO



