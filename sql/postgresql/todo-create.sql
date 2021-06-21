create table todo_item (
item_id integer,
title varchar(500),
description text,
status char(1),
due_date date default now(),
constraint todo_item_pk primary key (item_id),
constraint todo_item_fk foreign key (item_id) references acs_objects(object_id)
);

create function inline_0 ()
returns integer as '
begin
 PERFORM acs_object_type__create_type (
 ''todo_item'',
 ''To Do Item'',
 ''To Do Items'',
 ''acs_object'',
 ''todo_item'',
 ''item_id'',
 ''todo'',
 ''f'',
 null,
 null
 );
 return 0;
end;' language 'plpgsql';

select inline_0 ();

drop function inline_0 ();

\i packages/todo/sql/postgresql/todo-package.sql