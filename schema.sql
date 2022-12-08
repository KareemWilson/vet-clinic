/*Create Table.*/

CREATE TABLE animals(
    id int NOT NULL,
    name varchar,
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal,
    PRIMARY KEY(id)
)

/*Add a column species of type string to my animals table.*/

ALTER TABLE animals ADD species VARCHAR;