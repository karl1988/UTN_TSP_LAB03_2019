CREATE DATABASE  TP_NORMALIZACION_N1_2019

GO

USE TP_NORMALIZACION_N1_2019

GO



CREATE TABLE PROVINCIAS--LOS NOMBRES DE LAS TABLAS VAN EN PLURAS 
(	ID_PRO TINYINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	NOMBRE VARCHAR(50) NOT NULL
)

GO

CREATE TABLE LOCALIDADES 
(	ID_LOC TINYINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	PROVINCIA TINYINT NOT NULL FOREIGN KEY REFERENCES PROVINCIAS(ID_PRO),
	NOMBRE VARCHAR(50) NOT NULL
)


GO

CREATE TABLE DOMICILIOS
(	ID_DOM TINYINT PRIMARY KEY NOT NULL IDENTITY(1,1),
	LOCALIDAD TINYINT NOT NULL FOREIGN KEY REFERENCES LOCALIDADES(ID_LOC),
	CALLE VARCHAR(50)NOT NULL,
	NUMERO VARCHAR(50)NOT NULL,
)

GO

CREATE TABLE CLIENTES
(	--ID_CLI TINYINT PRIMARY KEY NOT NULL IDENTITY(1,1),
	DNI VARCHAR(10) NOT NULL UNIQUE(DNI),
	DOMICILIO TINYINT FOREIGN KEY REFERENCES DOMICILIOS(ID_DOM),
	EMAIL VARCHAR(50) NOT  NULL ,
	APELLIDO VARCHAR(50) NOT NULL,
	NOMBRE VARCHAR(50) NOT NULL,
	FECHA_NAC SMALLDATETIME NULL


)

GO




CREATE TABLE TELEFONOS_CLIENTES
(	CLIENTE VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES CLIENTES(DNI),--UN EMPLEADO TIENE VARIOS NUMEROS
	NUMERO VARCHAR(10) NOT NULL,--NO REALIZAMOS NINGUNA OPERACION SOBRE LOS NUMEROS
	DESCRIPCION VARCHAR(50) NULL--PUEDE SER TELEFONO FIJO O CELULAR 

)
GO

CREATE TABLE PRODUCTOS
(	ID_PRO TINYINT PRIMARY KEY NOT NULL IDENTITY(1,1),--GENERACION AUTOMATICA
	DESCRIPCION VARCHAR(50) NOT NULL UNIQUE(DESCRIPCION),--
	PRECIO FLOAT NOT NULL CHECK(PRECIO>0),--PRECIO MINORISTA O DE LISTA
	PER_FAC INT NULL--DIAS QUE LLEVA FABRICAR EL PRODUCTO//DIFERENCIA ENTRE FECHA PEDIDO Y FECHA ENTREGA


)

GO

CREATE TABLE PEDIDOS
(	ID_PED INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	PRODUCTO TINYINT NOT NULL FOREIGN KEY REFERENCES PRODUCTOS(ID_PRO),
	CANTIDAD INT NOT NULL CHECK(CANTIDAD>0),
	CLIENTE VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES CLIENTES(DNI),
	FECHA_SOL SMALLDATETIME NOT NULL,--FECHA DE SOLICTIUD
	FECHA_ENT SMALLDATETIME NOT NULL,--FECHA DE ENTREGA
	IMPORTE FLOAT NULL CHECK(IMPORTE>=0),
	ABONADO BIT NOT NULL CHECK(ABONADO=0 OR ABONADO=1)--1 ES IGUAL A TRUE Y 0 ES IGUAL A FALSE 

)
GO

