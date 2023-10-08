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

--Creamos la funcion
CREATE FUNCTION UpperCamelCase(varchar) RETURNS varchar AS
'DECLARE
	res varchar;
BEGIN
	SELECT INTO  res UPPER(SUBSTRING($1,1,1)) || LOWER(SUBSTRING($1,2));
	return res;
END;'
LANGUAGE 'plpgsql';
--Creamos los store procedures

CREATE FUNCTION InsertState(varchar,varchar) RETURNS int AS
'DECLARE
	regs record;
	res numeric;
BEGIN
	SELECT INTO regs count(name) FROM States WHERE name = UpperCamelCase($1);
	IF regs.count = 0
		THEN
		INSERT INTO States(name,idcountry)VALUES(UpperCamelCase($1),$2);
		SELECT INTO res idstate FROM States WHERE name = UpperCamelCase($1);
		RETURN res;
	END IF;
	IF regs.count > 0
		THEN
		SELECT INTO res idstate FROM States WHERE name = UpperCamelCase($1);
	RETURN res;
	END IF;
END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION InsertCity (varchar,numeric) RETURNS int AS
'DECLARE
	regs record;
	res numeric;
BEGIN
	SELECT INTO regs count(name) FROM Cities WHERE name = UpperCamelCase($1);
	IF regs.count = 0
		THEN
		INSERT INTO Cities(name,idstate)VALUES(UpperCamelCase($1),$2);
		SELECT INTO res idcity FROM Cities WHERE name = UpperCamelCase($1);
		RETURN res;
	END IF;
	IF regs.count > 0
		THEN
		SELECT INTO res idcity FROM Cities WHERE name = UpperCamelCase($1);
	RETURN res;
	END IF;
END;
' LANGUAGE 'plpgsql';


