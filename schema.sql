-- Create Table.
CREATE TABLE animals(
    id serial primary key,
    name varchar,
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal
)

-- Add a column species of type string to my animals table.
ALTER TABLE animals ADD species VARCHAR;

-- Create owners table 
CREATE TABLE owners(
    id serial primary key ,
    full_name varchar,
    age int
);

-- Create species table
CREATE TABLE species(
    id serial primary key,
    name varchar
);

--Remove column 'species' from animals table.
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);