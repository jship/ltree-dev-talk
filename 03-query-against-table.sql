create extension if not exists "ltree";

-- Remember our tree representation:
--   Foo
--   |
--   +- Bar
--   |  |
--   |  `- Quux
--   |
--   `- Baz

-- Considering we know that 'Foo' is the top-most label in our ltree, we can
-- get the whole tree (a.k.a. in this case, all the records in the table) via
-- the ancestor operators: <@ and @>

-- The @> operator checks if the left arg is an ancestor of the right arg (or
-- if they are equal).
select * from node where 'Foo' @> path;

-- We could equivalently write this query as:
select * from node where path <@ 'Foo';

-- The way I remember the ancestor operator arg order is to think of the '@' as
-- the letter 'A' for ancestor. The side the '@' is on is where the ancestor
-- path goes.

-- To illustrate this, what happens if we instead asked the following:
select * from node where 'Foo' <@ path;

-- We can again combine usage of the ancestor operator and nlevel:
select * from node where 'Foo' @> path order by nlevel(path);
select * from node where 'Foo' @> path and nlevel(path) > 2;
