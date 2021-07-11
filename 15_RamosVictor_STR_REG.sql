﻿-- Crear base de datos dbMesajil
CREATE DATABASE dbMesajil;
GO

-- Ponemos en uso la base de datos dbMesajil
USE dbMesajil;
GO

-- Crear tabla CLIENTE
CREATE TABLE CLIENTE (
	IDCLI int NOT NULL IDENTITY (1,1),
	NOMCLI varchar(30) NOT NULL,
	APECLI varchar(30) NOT NULL,
	DNICLI char(8) NOT NULL,
	ESTCLI char(1) NOT NULL,
	CONSTRAINT Pk_CLIENTE PRIMARY KEY (IDCLI)   
)
GO

-- Crear tabla PROVEEDOR
CREATE TABLE PROVEEDOR (
	IDPROV int NOT NULL IDENTITY (1,1),
	NOMPROV varchar(30) NOT NULL,
	RUCPROV char(11) NOT NULL,
	TELPROV char(9),
	EMAPROV varchar(30),
	TIPPROV varchar(18) NOT NULL,
	NCOMPROV varchar(80),
	ABREPROV varchar(8),
	DIRPROV varchar(80) NOT NULL,
	IDSUC char(6) NOT NULL,
	ESTPROV char(1) NOT NULL,
	CONSTRAINT Pk_PROVEEDOR PRIMARY KEY (IDPROV)   
)
GO

-- Crear tabla EMPLEADO
CREATE TABLE EMPLEADO (
	IDEMP int NOT NULL IDENTITY (1,1),
	NOMEMP varchar(30) NOT NULL,
	APEEMP varchar(30) NOT NULL,
	DNIEMP char(8) NOT NULL,
	TELFEMP char(9),
	DIREMP varchar(50) NOT NULL,
	IDSUC char(6) NOT NULL,
	IDUSU int NOT NULL,
	ESTEMP char(1) NOT NULL,	
	CONSTRAINT Pk_VENDEDOR PRIMARY KEY (IDEMP)   
)
GO

-- Crear tabla EQUIPOS INFORMATICOS
CREATE TABLE EQUIPO_INFORMATICOS (
	IDEI int NOT NULL IDENTITY (1,1),
	NOMEI varchar(50) NOT NULL,
	MAREI varchar(30) NOT NULL,
	STOCEI int NOT NULL,
	CAREI varchar(60) NOT NULL,
	IDPROV int NOT NULL,
	ESTEI char(1) NOT NULL,
	CONSTRAINT Pk_MEDICAMENTO PRIMARY KEY (IDEI)   
)
GO


-- Crear la tabla BOLETA
CREATE TABLE BOLETA (
	IDBOLE int NOT NULL IDENTITY (1,1),
	FECHBOLE date NOT NULL,
	IDCLI int NOT NULL,
	IDEMP int NOT NULL,
	IMPBOLE decimal(7,2) NOT NULL,
	ESTBOLE char(1) NOT NULL,
	CONSTRAINT Pk_BOLETA PRIMARY KEY (IDBOLE) 
)
GO

--DROP DATABASE dbMesajil;

-- Crear la tabla BOLETA_DETALLE
CREATE TABLE BOLETA_DETALLE (
	IDBODE int NOT NULL IDENTITY (1,1),
	CANTBODE int NOT NULL,
	IDBOLE int NOT NULL,
	IDEI int NOT NULL,
	SUBTOT decimal(5,2) NOT NULL,
	ESTBODE char(1) NOT NULL,
	CONSTRAINT Pk_BOLETA_DETALLE PRIMARY KEY (IDBODE) 
)
GO


-- Crear la tabla SUCURSAL
CREATE TABLE SUCURSAL (
	IDSUC char(6) NOT NULL,
	DEPSUC varchar(80) NOT NULL,
	PROSUC varchar(80) NOT NULL,
	DISSUC varchar(80) NOT NULL,
	CONSTRAINT Pk_UBIGEO PRIMARY KEY (IDSUC)
)
GO

-- Crear la tabla USUARIO
CREATE TABLE USUARIO (
	IDUSU int NOT NULL IDENTITY (1,1),
	USUARIO varchar(30) NOT NULL,
	CLAVE varchar(30) NOT NULL,
	IDCAR int NOT NULL,
	CONSTRAINT Pk_USUARIO PRIMARY KEY (IDUSU)
)
GO


-- Crear la tabla CARGO
CREATE TABLE CARGO (
	IDCAR int NOT NULL IDENTITY (1,1),
	NOMCAR varchar(30) NOT NULL,
	CONSTRAINT Pk_CARGO PRIMARY KEY (IDCAR)
)
GO


-- Relacionando la tabla VENDEDOR con la tabla UBIGEO
ALTER TABLE EMPLEADO
ADD CONSTRAINT FK_EMPLEADO_SUCURSAL
FOREIGN KEY (IDSUC) REFERENCES SUCURSAL (IDSUC);

-- Relacionando la tabla PROVEEDOR con la tabla SUCURSAL
ALTER TABLE PROVEEDOR
ADD CONSTRAINT FK_PROVEEDOR_SUCURSAL
FOREIGN KEY (IDSUC) REFERENCES SUCURSAL (IDSUC);

-- Relacionando la tabla BOLETA con la tabla CLIENTE
ALTER TABLE BOLETA
ADD CONSTRAINT FK_BOLETA_CLIENTE
FOREIGN KEY (IDCLI) REFERENCES CLIENTE (IDCLI);

-- Relacionando la tabla BOLETA con la tabla EMPLEADO
ALTER TABLE BOLETA
ADD CONSTRAINT FK_BOLETA_EMPLEADO
FOREIGN KEY (IDEMP) REFERENCES EMPLEADO (IDEMP);

-- Relacionando la tabla EQUIPO_INFORMATICOS con la tabla PROVEEDOR
ALTER TABLE EQUIPO_INFORMATICOS
ADD CONSTRAINT FK_EQUIPOS_INFORMATICO_PROVEEDOR
FOREIGN KEY (IDPROV) REFERENCES PROVEEDOR (IDPROV);


-- Relacionando la tabla BOLETA_DETALLE con la tabla EQUIPO INFORMATICOS
ALTER TABLE BOLETA_DETALLE
ADD CONSTRAINT FK_BOLETA_DETALLE_EQUIPO_INFORMATICOS
FOREIGN KEY (IDEI) REFERENCES EQUIPO_INFORMATICOS (IDEI);


-- Relacionando la tabla BOLETA_DETALLE con la tabla BOLETA
ALTER TABLE BOLETA_DETALLE
ADD CONSTRAINT FK_BOLETA_DETALLE_BOLETA
FOREIGN KEY (IDBOLE) REFERENCES BOLETA (IDBOLE);


-- Relacionando la tabla EMPLEADO con la tabla USUARIO
ALTER TABLE EMPLEADO
ADD CONSTRAINT FK_EMPLEADO_USUARIO
FOREIGN KEY (IDUSU) REFERENCES USUARIO (IDUSU);

-- Relacionando la tabla CARGO con la tabla USUARIO
ALTER TABLE USUARIO
ADD CONSTRAINT FK_CARGO_USUARIO
FOREIGN KEY (IDCAR) REFERENCES CARGO (IDCAR);





-- Insetar registros en la tabla UBIGEO
INSERT INTO SUCURSAL
	(IDSUC, DEPSUC, PROSUC, DISSUC)
VALUES
	('150101','LIMA','LIMA','LIMA'),
	('150102','LIMA','LIMA','ANCON'),
	('150103','LIMA','LIMA','ATE'),
	('150104','LIMA','LIMA','BARRANCO'),
	('150105','LIMA','LIMA','BRE�A'),
	('150106','LIMA','LIMA','CARABAYLLO'),
	('150107','LIMA','LIMA','CHACLACAYO'),
	('150108','LIMA','LIMA','CHORRILLOS'),
	('150109','LIMA','LIMA','CIENEGUILLA'),
	('150110','LIMA','LIMA','COMAS'),
	('150111','LIMA','LIMA','EL AGUSTINO'),
	('150112','LIMA','LIMA','INDEPENDENCIA'),
	('150113','LIMA','LIMA','JESUS MARIA'),
	('150114','LIMA','LIMA','LA MOLINA'),
	('150115','LIMA','LIMA','LA VICTORIA'),
	('150116','LIMA','LIMA','LINCE'),
	('150117','LIMA','LIMA','LOS OLIVOS'),
	('150118','LIMA','LIMA','LURIGANCHO'),
	('150119','LIMA','LIMA','LURIN'),
	('150120','LIMA','LIMA','MAGDALENA DEL MAR'),
	('150121','LIMA','LIMA','MAGDALENA VIEJA'),
	('150122','LIMA','LIMA','MIRAFLORES'),
	('150123','LIMA','LIMA','PACHACAMAC'),
	('150124','LIMA','LIMA','PUCUSANA'),
	('150125','LIMA','LIMA','PUENTE PIEDRA'),
	('150126','LIMA','LIMA','PUNTA HERMOSA'),
	('150127','LIMA','LIMA','PUNTA NEGRA'),
	('150128','LIMA','LIMA','RIMAC'),
	('150129','LIMA','LIMA','SAN BARTOLO'),
	('150130','LIMA','LIMA','SAN BORJA'),
	('150131','LIMA','LIMA','SAN ISIDRO'),
	('150132','LIMA','LIMA','SAN JUAN DE LURIGANCHO'),
	('150133','LIMA','LIMA','SAN JUAN DE MIRAFLORES'),
	('150134','LIMA','LIMA','SAN LUIS'),
	('150135','LIMA','LIMA','SAN MARTIN DE PORRES'),
	('150136','LIMA','LIMA','SAN MIGUEL'),
	('150137','LIMA','LIMA','SANTA ANITA'),
	('150138','LIMA','LIMA','SANTA MARIA DEL MAR'),
	('150139','LIMA','LIMA','SANTA ROSA'),
	('150140','LIMA','LIMA','SANTIAGO DE SURCO'),
	('150141','LIMA','LIMA','SURQUILLO'),
	('150142','LIMA','LIMA','VILLA EL SALVADOR'),
	('150143','LIMA','LIMA','VILLA MARIA DEL TRIUNFO'),
	('150501','LIMA','CA�ETE','SAN VICENTE DE CA�ETE'),
	('150502','LIMA','CA�ETE','ASIA'),
	('150503','LIMA','CA�ETE','CALANGO'),
	('150504','LIMA','CA�ETE','CERRO AZUL'),
	('150505','LIMA','CA�ETE','CHILCA'),
	('150506','LIMA','CA�ETE','COAYLLO'),
	('150507','LIMA','CA�ETE','IMPERIAL'),
	('150508','LIMA','CA�ETE','LUNAHUANA'),
	('150509','LIMA','CA�ETE','MALA'),
	('150510','LIMA','CA�ETE','NUEVO IMPERIAL'),
	('150511','LIMA','CA�ETE','PACARAN'),
	('150512','LIMA','CA�ETE','QUILMANA'),
	('150513','LIMA','CA�ETE','SAN ANTONIO'),
	('150514','LIMA','CA�ETE','SAN LUIS'),
	('150515','LIMA','CA�ETE','SANTA CRUZ DE FLORES'),
	('150516','LIMA','CA�ETE','ZU�IGA'),
	('110204','ICA','CHINCHA','CHINCHA BAJA'),
	('110205','ICA','CHINCHA','EL CARMEN');


-- Insertar registros en la tabla CLIENTE
INSERT INTO CLIENTE
	(NOMCLI, APECLI, DNICLI, ESTCLI)
VALUES
	('PEDRO CARLOS', 'VARGAS CAMPOS', '45367892', 'A'),
	('ANA LUCIA', 'VEGAS RODRIGUEZ', '69067892', 'A'),
	('FRANCISCO EDUARDO', 'LLOSA GOMEZ', '40923892', 'A'),
	('PEDRP PABLO', 'GONZALES GODINEZ', '45360012', 'A'),
	('MARIA PAULA', 'RODRIGUEZ GONZALES', '56701292', 'A'),
	('FERNANDO DANTE', 'QUISPE AVALOS', '67677892', 'A'),
	('RENATO MAXIMO', 'HUAMAN QUISPE', '73934789', 'A'),
	('JESUS ARTURO', 'GAMEZ LLANOS', '55667892', 'A'),
	('ROSA FLOR', 'VALENCIA MANRIQUE', '49909012', 'A'),
	('PEPE ALFREDO', 'VELASCO RAMOS', '90367892', 'A');

-- Insertar registros en la tabla CARGO
INSERT INTO CARGO
	(NOMCAR)
VALUES
	('ADMINISTRADOR'),
	('JEFE DE SUCURSAL'),
	('VENDEDOR');

-- Insertar registros en la tabla USUARIO
INSERT INTO USUARIO
	(USUARIO, CLAVE, IDCAR)
VALUES
	('PEPE', 'PEPITO123', '1'),
	('PABLO', 'PABLITO123', '2'),
	('VICTOR', 'VICTOR123', '3');


-- Insertar registros en la tabla EMPLEADO
INSERT INTO EMPLEADO
	(NOMEMP, APEEMP, DNIEMP, TELFEMP, DIREMP, IDSUC, IDUSU, ESTEMP)
VALUES
	('JAVIER FRANCISCO', 'GONZALES PADILLA', '43567654', '908763452', 'A.V LOS PINOS', '150101','1', 'A'),
	('JOSE ENRIQUE', 'GALES LLOSA', '43567009', '902312121', 'A.V LAS PALMAS', '150502','2', 'A'),
	('BETO PAUL', 'RAMOS ORTIZ', '55434654', '987654321', 'A.V PRADOS', '150512','3', 'A'),
	('ERIKA ANGIE', 'CASTILLO FLORES', '43500989', '900087698', 'A.V PUERTO MOLDE', '150514','1', 'A'),
	('VANESA JULIA', 'GOYA PADILLA', '67567654', '987023456', 'A.V 23 DE JUNIO', '110205','1', 'A');



-- Insertar registros en la tabla PROVEEDOR
INSERT INTO PROVEEDOR
	(NOMPROV, RUCPROV, TELPROV, EMAPROV, TIPPROV, NCOMPROV, ABREPROV, DIRPROV, IDSUC, ESTPROV)
VALUES
	('EDUSISTEM S.A.C.', '20108983583', '994756342', 'alfaro@hotmail.com', 'DISTRIBUIDOR', 'ALFARO', 'ALF', 'A.V SAN PABLO', '150101', 'A'),
	('HARD RENTAL S.A.', '20105556783', '967446342', 'abbott@hotmail.com',  'DISTRIBUIDOR', 'ABBOTT', 'ABOT', 'A.V SIEMPRE VIVA', '150502', 'A'),
	('LENOVO S.A', '20108980000', '994756342', 'andratx@outlook.com',  'DISTRIBUIDOR', 'CIRCADIN', 'CIRCA', 'A.V LOS GIRASOLES', '150512', 'A'),
	('ASUS S.A.', '34190983583', '955123122', 'biosintex@outlook.com',  'FABRICA', 'DIROLAC', 'BIOS', 'A.V 30 DE JUNIO', '150504', 'A'),
	('KREATECH S.A.C', '20100129028', '', '', 'DISTRIBUIDOR', '', '', 'AV. JUAN DE ARONA NRO. 151 RES. SAN ISIDRO', '150513', 'A'),
	('INFORDATA', '20415090316', '984673621', '', 'DISTRIBUIDOR', '', '', 'AV. FELIPE PARDO Y ALIAGA NRO. 675 INT. 202', '150131', 'A'),
	('TOSHIBA S.A.', '20100096341', '903457213', '', 'FABRICA', 'BAYER', 'BAYER', 'AV. PASEO DE LA REPUBLICA NRO. 3074 INT. 1001', '150131', 'A'),
	('HP S.A.', '20112954288', '999765408', '', 'FABRICA', '', '', 'AV. LOS FRUTALES NRO. 220', '150103', 'A'),
	('NETCORPORATE S.A.', '20415090316', '900213451', '', 'DISTRIBUIDOR', '', '', 'AV. FELIPE PARDO Y ALIAGA NRO. 675 INT. 202', '150131', 'A'),
	('DELL S.A.', '34208683583', '990001242', 'gador@hotmail.com',  'FABRICA', 'HARVONI', 'GADOR', 'A.V LOS PORTALES', '150514', 'A');



-- Insertar registros en la tabla EQUIPO_INFORMATICOS
INSERT INTO EQUIPO_INFORMATICOS
	(NOMEI, MAREI, STOCEI, CAREI, IDPROV, ESTEI)
VALUES
	('LAPTOP', 'ASUS', '5', '8GB DE RAM/128GB SSD', '2', 'A'),
	('LAPTOP', 'HP', '7', '12GB DE RAM/256GB SSD', '3', 'A'),
	('LAPTOP', 'DELL', '3', '4GB DE RAM/256GB SSD', '5', 'A'),
	('LAPTOP', 'LENOVO', '8', '8GB DE RAM/512GB SSD', '4', 'A'),
	('LAPTOP', 'TOSHIBA', '2', '4GB DE RAM/128GB SSD', '8', 'A');


-- Insetar registros en la tabla BOLETA
INSERT INTO BOLETA
	(FECHBOLE, IDCLI, IDEMP, IMPBOLE, ESTBOLE)
VALUES
	('05-03-2001', '1', '3', '2580.4', 'A'),
	('07-05-2002', '2', '5', '2257.5', 'A'),
	('09-05-2012', '3', '3', '2300.8', 'A'),
	('05-02-2004', '4', '2', '2700.7', 'A'),
	('05-05-2021', '1', '2', '1980.6', 'A'),
	('05-01-2014', '5', '4', '2300.3', 'A'),
	('07-06-2021', '5', '2', '1850.5', 'A'),
	('09-06-2021', '7', '3', '2500.8', 'A'),
	('15-06-2021', '2', '4', '2100.8', 'A'),
	('24-06-2021', '1', '6', '2300.2', 'A');

-- Insetar registros en la tabla BOLETA_DETALLE
INSERT INTO BOLETA_DETALLE
	(CANTBODE, IDBOLE, IDEI, SUBTOT, ESTBODE)
VALUES
	('5', '1', '3', '850.40', 'A'),
	('7', '29', '2', '950.80', 'A'),
	('8', '38', '6', '925.60', 'A'),
	('9', '39', '4', '445.00', 'A'),
	('5', '40', '5', '780.00', 'A'),
	('6', '41', '4', '750.40', 'A'),
	('5', '42', '2', '650.40', 'A'),
	('4', '45', '6', '850.50', 'A');

SELECT*FROM EQUIPO_INFORMATICOS;
SELECT*FROM BOLETA;