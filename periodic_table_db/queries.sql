ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;


ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;


ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;


ALTER TABLE properties
ALTER COLUMN melting_point_celsius
SET
NOT NULL;


ALTER TABLE properties
ALTER COLUMN boiling_point_celsius
SET
NOT NULL;


ALTER TABLE elements ADD UNIQUE(symbol);


ALTER TABLE elements ADD UNIQUE(name);


ALTER TABLE elements
ALTER COLUMN symbol
SET
NOT NULL;


ALTER TABLE elements
ALTER COLUMN name
SET
NOT NULL;


ALTER TABLE properties ADD
FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);


CREATE TABLE types
(
    type_id SERIAL PRIMARY KEY NOT NULL,
    type VARCHAR(30) NOT NULL
);


INSERT INTO types
    (type)
SELECT DISTINCT type
FROM properties
WHERE type IS NOT NULL;


ALTER TABLE properties ADD COLUMN type_id INT;


UPDATE properties
SET type_id = types.type_id
FROM types
WHERE properties.type = types.type;


ALTER TABLE properties
ALTER COLUMN type_id
SET
NOT NULL;


ALTER TABLE properties ADD
FOREIGN KEY (type_id) REFERENCES types(type_id);


UPDATE elements
SET symbol = UPPER(SUBSTRING(symbol, 1, 1)) || SUBSTRING(symbol, 2);


ALTER TABLE properties
ALTER COLUMN atomic_mass TYPE
DECIMAL;


UPDATE properties
SET atomic_mass = TRIM( TRAILING '0'
                       FROM atomic_mass::TEXT )
::DECIMAL;


INSERT INTO elements
    (atomic_number, name, symbol)
VALUES
    (9,
        'Fluorine',
        'F'),
    (10,
        'Neon',
        'Ne');


INSERT INTO properties
    ( atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id )
VALUES
    ( 9,
        'nonmetal',
        18.998,
        -220,
        -188.1,
        ( SELECT type_id
        FROM types
        WHERE type = 'nonmetal' ) ),
    ( 10,
        'nonmetal',
        20.18,
        -248.6,
        -246.1,
        ( SELECT type_id
        FROM types
        WHERE type = 'nonmetal' ) );


DELETE
FROM properties
WHERE atomic_number = 1000;


DELETE
FROM elements
WHERE atomic_number = 1000;


ALTER TABLE properties
DROP COLUMN type;