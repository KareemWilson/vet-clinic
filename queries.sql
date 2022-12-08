SELECT * from animals WHERE name LIKE '%mon'
SELECT * from animals WHERE date_of_birth BETWEEN '01-01-2016' AND '01-01-2019';
SELECT * from animals WHERE neutered IS true AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name IN ('Agumon','Pikachu');
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS true;
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Begin Transaction */
BEGIN TRANSACTION;
/* UPDATE species columns to 'unspecified' */
UPDATE animals SET species = "unspecified";
/* roll back the change */ 
ROLLBACK;

/* Begin Transaction */
BEGIN;
/*Update the animals table by setting the species column to digimon for all animals that have a name ending in mon */
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
/*Update the animals table by setting the species column to pokemon for all animals that don't have species already set.*/
UPDATE animals SET species = 'pokemon' WHERE species = '';
/* COMMIT TRANSACTION */
commit;

/* BEGIN TRANSACTION to delete all records in table */ 
BEGIN;
/* Start Deleting.. */ 
DELETE FROM animals;
/* ROLLBACK */
ROLLBACK;

/* BEGIN TRANSACTION to delete some animals and update their weight_kg */
BEGIN;
/* Start Deleting.. */ 
DELETE FROM animals WHERE date_of_birth > '01-01-2022';
/* make a SAVEPOINT called 'delete_some_animals' */
SAVEPOINT delete_some_animals;
/* update weight_kg of all animals */
UPDATE animals SET weight_kg =  weight_kg * -1;
/* ROLLBACK TO 'delete_some_animals' SAVEPOINT */
ROLLBACK TO delete_some_animals;
/* UPDATE animals' weight_kg that smaller than 0 */ 
UPDATE animals SET weight_kg =  weight_kg * -1 WHERE weight_kg < 0;
/* COMMIT the changes */ 
COMMIT;

