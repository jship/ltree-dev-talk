create extension if not exists "ltree";

-- An ltree value with a single label.
-- Tree representation:
--   Foo
select 'Foo'::ltree;

-- A label can only contain the following characters:
--   A-Za-z0-9_

-- An ltree value with two labels. Labels are separated via the '.' character.
-- Tree representation:
--   Foo
--   |
--   `- Bar
select 'Foo.Bar'::ltree;

-- Another ltree value with two labels.
-- Tree representation:
--   Foo
--   |
--   `- Baz
select 'Foo.Baz'::ltree;

-- Text can be converted to ltree value.
select text2ltree('Foo.Bar');

-- Ltree value can be converted to text.
select ltree2text('Foo.Bar');

-- These conversions can also be done via casts:
select ('Foo.Bar'::text)::ltree;
select ('Foo.Bar'::ltree)::text;

-- Let's say we had the above three ltree values in our DB somehow (we'll see how later!).
-- Conceptually, we can think of the tree representation as:
--   Foo
--   |
--   +- Bar
--   |
--   `- Baz

-- Asking for how many labels are in an ltree path.
select nlevel('Foo.Bar');

-- Asking for an ltree subpath: subpath(ltree, int offset, int len)
select subpath('Foo.Bar.Quux', 0, 2);
select subpath('Foo.Bar.Quux', 1);

-- "Moving" a node, a.k.a. re-parenting the node:
-- This will move the Quux node from this path
--   Foo
--   |
--   +- Bar
--      |
--      `- Quux
-- to the following path:
--   Wombo
--   |
--   +- Quux
-- (This is assuming we saved the value to the DB!)

select 'Wombo' || subpath('Foo.Bar.Quux', 2);

-- We can more flexibly move a node via also using nlevel:
select 'Wombo' || subpath('Foo.Bar.Quux', nlevel('Foo.Bar.Quux') - 1);
