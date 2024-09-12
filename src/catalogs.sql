/*
*Script de ejemplos de store procedures 
*en PostgreSQL
*/
--Creamos las tablas
CREATE TABLE Countries(
idcountry char(3) NOT NULL PRIMARY KEY
,name varchar(250) NOT NULL
,created timestamp DEFAULT NOW() NOT NULL
);

CREATE TABLE States(
idstate serial NOT NULL PRIMARY KEY
,name varchar(250) NOT NULL
,idcountry varchar(3) NOT NULL REFERENCES Countries(idcountry)
,created timestamp DEFAULT NOW() NOT NULL
);

CREATE TABLE Cities(
idcity serial NOT NULL PRIMARY KEY
,name varchar(250) NOT NULL
,idstate int NOT NULL REFERENCES States(idstate)
,created timestamp DEFAULT NOW() NOT NULL
);
--Insertamos paises
INSERT INTO Countries(idcountry,name)VALUES('arg','argentina');
INSERT INTO Countries(idcountry,name)VALUES('bra','brasil');
INSERT INTO Countries(idcountry,name)VALUES('ury','uruguay');
INSERT INTO Countries(idcountry,name)VALUES('mex','méxico');
