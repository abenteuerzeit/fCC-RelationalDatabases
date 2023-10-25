# Assignment

```bash
periodic_table=> \l
                                List of databases
      Name      |  Owner   | Encoding | Collate |  Ctype  |   Access privileges
----------------+----------+----------+---------+---------+-----------------------
 periodic_table | postgres | UTF8     | C.UTF-8 | C.UTF-8 |
 postgres       | postgres | UTF8     | C.UTF-8 | C.UTF-8 |
 template0      | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                |          |          |         |         | postgres=CTc/postgres
 template1      | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                |          |          |         |         | postgres=CTc/postgres
(4 rows)
```

```bash
periodic_table=> \d
             List of relations
 Schema |    Name    | Type  |    Owner
--------+------------+-------+--------------
 public | elements   | table | freecodecamp
 public | properties | table | freecodecamp
(2 rows)
```

```bash
periodic_table=> \d elements
                        Table "public.elements"
    Column     |         Type          | Collation | Nullable | Default
---------------+-----------------------+-----------+----------+---------
 atomic_number | integer               |           | not null |
 symbol        | character varying(2)  |           |          |
 name          | character varying(40) |           |          |
```

```bash
periodic_table-> \d properties
                       Table "public.properties"
    Column     |         Type          | Collation | Nullable | Default
---------------+-----------------------+-----------+----------+---------
 atomic_number | integer               |           | not null |
 type          | character varying(30) |           |          |
 weight        | numeric(9,6)          |           | not null |
 melting_point | numeric               |           |          |
 boiling_point | numeric               |           |          |
Indexes:
    "properties_pkey" PRIMARY KEY, btree (atomic_number)
    "properties_atomic_number_key" UNIQUE CONSTRAINT, btree (atomic_number)
```

## Tests

1. You should rename the weight column to atomic_mass
2. You should rename the melting_point column to melting_point_celsius and the boiling_point column to boiling_point_celsius
3. Your melting_point_celsius and boiling_point_celsius columns should not accept null values
4. You should add the UNIQUE constraint to the symbol and name columns from the elements table
5. Your symbol and name columns should have the NOT NULL constraint
6. You should set the atomic_number column from the properties table as a foreign key that references the column of the same name in the elements table
7. You should create a types table that will store the three types of elements
8. Your types table should have a type_id column that is an integer and the primary key
9. Your types table should have a type column that's a VARCHAR and cannot be null. It will store the different types from the type column in the properties table
10. You should add three rows to your types table whose values are the three different types from the properties table
11. Your properties table should have a type_id foreign key column that references the type_id column from the types table. It should be an INT with the NOT NULL constraint
12. Each row in your properties table should have a type_id value that links to the correct type from the types table
13. You should capitalize the first letter of all the symbol values in the elements table. Be careful to only capitalize the letter and not change any others
14. You should remove all the trailing zeros after the decimals from each row of the atomic_mass column. You may need to adjust a data type to DECIMAL for this. The final values they should be are in the atomic_mass.txt file
15. You should add the element with atomic number 9 to your database. Its name is Fluorine, symbol is F, mass is 18.998, melting point is -220, boiling point is -188.1, and it's a nonmetal
16. You should add the element with atomic number 10 to your database. Its name is Neon, symbol is Ne, mass is 20.18, melting point is -248.6, boiling point is -246.1, and it's a nonmetal
17. You should create a periodic_table folder in the project folder and turn it into a git repository with git init
18. Your repository should have a main branch with all your commits
19. Your periodic_table repo should have at least five commits
20. You should create an element.sh file in your repo folder for the program I want you to make
21. Your script (.sh) file should have executable permissions
22. If you run ./element.sh, it should output only Please provide an element as an argument. and finish running.
23. If you run ./element.sh 1, ./element.sh H, or ./element.sh Hydrogen, it should output only The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
24. If you run ./element.sh script with another element as input, you should get the same output but with information associated with the given element.
25. If the argument input to your element.sh script doesn't exist as an atomic_number, symbol, or name in the database, the only output should be I could not find that element in the database.
26. The message for the first commit in your repo should be Initial commit
27. The rest of the commit messages should start with fix:, feat:, refactor:, chore:, or test:
28. You should delete the non existent element, whose atomic_number is 1000, from the two tables
29. Your properties table should not have a type column
30. You should finish your project while on the main branch. Your working tree should be clean and you should not have any uncommitted

## Queries

```sql
ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;
ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;
ALTER TABLE elements ADD UNIQUE(symbol);
ALTER TABLE elements ADD UNIQUE(name);
ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE elements ALTER COLUMN name SET NOT NULL;
ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);
CREATE TABLE types(type_id SERIAL PRIMARY KEY NOT NULL, type VARCHAR(30) NOT NULL);
INSERT INTO types (type) SELECT DISTINCT type FROM properties WHERE type IS NOT NULL;
ALTER TABLE properties ADD COLUMN type_id INT;
UPDATE properties SET type_id = types.type_id FROM types WHERE properties.type = types.type;
ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;
ALTER TABLE properties ADD FOREIGN KEY (type_id) REFERENCES types(type_id);
UPDATE elements SET symbol = UPPER(SUBSTRING(symbol, 1, 1)) || SUBSTRING(symbol, 2);
ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;
UPDATE properties SET atomic_mass = TRIM(TRAILING '0' FROM atomic_mass::TEXT)::DECIMAL;
INSERT INTO elements (atomic_number, name, symbol)
VALUES (9, 'Fluorine', 'F'),
       (10, 'Neon', 'Ne');
INSERT INTO properties (atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
VALUES
(9, 'nonmetal', 18.998, -220, -188.1, (SELECT type_id FROM types WHERE type = 'nonmetal')),
(10, 'nonmetal', 20.18, -248.6, -246.1, (SELECT type_id FROM types WHERE type = 'nonmetal'));
DELETE FROM properties WHERE atomic_number = 1000;
DELETE FROM elements WHERE atomic_number = 1000;
ALTER TABLE properties DROP COLUMN type;
```

## git log --oneline

```log
5b167c1 (HEAD -> main) refactor: remove task comments
6c7c964 feat: Display element details from database query results
8d74a2b feat: Add error handling for missing elements in the database
29b928e feat: Enhance argument parsing to handle atomic_number, symbol, and name
0d8cef1 feat: Fetch element details from the database
31aa640 feat: Setup initial script and database connection
acece03 feat: add argument check to exit script if none provided
111c350 Initial commit
```
