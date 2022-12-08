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

/* Create owners table */ 
CREATE TABLE owners(
    id serial primary key ,
    full_name varchar,
    age int
);

/* Create species table */ 
CREATE TABLE species(
    id serial primary key,
    name varchar
);