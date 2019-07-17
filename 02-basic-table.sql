create extension if not exists "ltree";

-- We'll create a table that has just a single field of type ltree.
create table node(
  path ltree not null
);

-- Inserting the following allows us to capture in the DB this tree
-- representation:
--   Foo
--   |
--   +- Bar
--   |  |
--   |  `- Quux
--   |
--   `- Baz
insert into node values ('Foo');
insert into node values ('Foo.Bar');
insert into node values ('Foo.Bar.Quux');
insert into node values ('Foo.Baz');
