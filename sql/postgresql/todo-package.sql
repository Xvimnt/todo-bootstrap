CREATE OR REPLACE FUNCTION todo_item__new (integer,varchar,text,char,integer,date,varchar,integer)
RETURNS integer AS '
DECLARE
 p_item_id ALIAS FOR $1;
 p_title ALIAS FOR $2; -- default null
 p_description ALIAS FOR $3; -- default null
 p_status ALIAS FOR $4; -- default null
 p_creation_user ALIAS FOR $5; -- default null
 p_due_date ALIAS FOR $6;
 p_creation_ip ALIAS FOR $7; -- default null
 p_context_id ALIAS FOR $8; -- default null
 
 v_id integer;
 v_type varchar;
BEGIN
 
 v_type := ''todo_item'';
 
 v_id := acs_object__new(
 p_item_id,
 v_type,
 now(),
 p_creation_user,
 p_creation_ip,
 p_context_id::Integer,
 true
 );
 insert into todo_item
 (item_id, title, description, status, due_date)
 values
 (p_item_id, p_title, p_description, p_status, p_due_date);
 return v_id;
END;' LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION todo_item_delete (integer)
RETURNS VOID AS '
DECLARE
 p_item_id ALIAS FOR $1; 
BEGIN 
 delete from todo_item where item_id = p_item_id;
 PERFORM acs_object__delete(p_item_id);
END;
' LANGUAGE 'plpgsql';