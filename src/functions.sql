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