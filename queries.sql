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
/* verify */
SELECT species from animals;
/* roll back the change */ 
ROLLBACK;

/* Begin Transaction */
BEGIN;
/*Update the animals table by setting the species column to digimon for all animals that have a name ending in mon */
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
/*Update the animals table by setting the species column to pokemon for all animals that don't have species already set.*/
UPDATE animals SET species = 'pokemon' WHERE species = '';
/* verify */
SELECT name, species FROM animals;
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

/* queries to answer the following questions: */
/* -----------------------------------------  */

/* How many animals are there? */
SELECT COUNT(*) FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT neutered, COUNT(*) FROM animals GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT AVG(weight_kg) FROM animals WHERE date_of_birth BETWEEN '01-01-1990' AND '01-01-2000';


-- queries (using JOIN) to answer the following questions:
-----------------------------------------------------------

-- What animals belong to Melody Pond?
SELECT name, full_name 
    FROM animals 
    INNER JOIN owners 
    ON animals.owner_id = owners.id 
    WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name, s.name AS type
    FROM animals a 
    INNER JOIN species s 
    ON a.species_id = s.id 
    WHERE s.name = 'Pokimon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name 
    FROM owners 
    LEFT JOIN animals 
    ON owners.id = animals.owner_id; 

-- How many animals are there per species?
select s.name, count(a.name) 
    from species s 
    JOIN animals a 
    on s.id = a.species_id 
    GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
select a.name, s.name, o.full_name 
    from animals a 
    JOIN species s 
    on s.id = a.species_id 
    JOIN owners o 
    on o.id = a.owner_id 
    WHERE s.name = 'Digimon' 
    AND o.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
select a.name 
    from animals a 
    join owners o 
    on o.id = a.owner_id 
    where a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name, count(a.name) as number_of_animals 
    from owners o 
    join animals a 
    on a.owner_id = o.id 
    GROUP BY o.full_name;

------------------------------------------------------------------------
-- JOIN TABLES
------------------------------------------------------------------------

-- Who was the last animal seen by William Tatcher?
SELECT a.name AS "Name of Animal", vets.name AS "Vet", date_of_visit FROM visits v LEFT JOIN vets ON
v.vet_id = vets.id LEFT JOIN animals a ON v.animal_id = a.id WHERE vets.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name AS "Vet",COUNT(*) FROM visits v LEFT JOIN vets ON v.vet_id = vets.id 
    LEFT JOIN animals a
    ON v.animal_id = a.id 
    WHERE vets.name = 'Stephanie Mendez' 
    GROUP BY vets.name;


-- List all vets and their specialties, including vets with no specialties.
SELECT * FROM vets LEFT JOIN specializations s ON vets.id = s.vets_id
LEFT JOIN species ON s.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. ++++++++++
SELECT a.name AS "Animals", vets.name AS "Vet" 
    FROM visits v 
    LEFT JOIN animals a 
    ON v.animal_id = a.id
    LEFT JOIN vets 
    ON v.vet_id = vets.id 
    WHERE vets.name = 'Stephanie Mendez' 
    AND date_of_visit 
    BETWEEN '01-04-2020' AND '30-08-2020' 
    GROUP BY a.name, vets.name;

-- What animal has the most visits to vets?
SELECT a.name AS "Animal", COUNT(*) 
    FROM visits v
    LEFT JOIN animals a
    ON v.animal_id = a.id
    GROUP BY a.name 
    ORDER BY COUNT(*) 
    DESC LIMIT 1;


-- Who was Maisy Smith's first visit?
SELECT a.name 
    FROM visits v 
    LEFT JOIN animals a 
    ON v.animal_id = a.id 
    LEFT JOIN vets 
    ON v.vet_id = vets.id 
    WHERE vets.name = 'Maisy Smith' 
    ORDER BY date_of_visit 
    LIMIT 1;


-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT vets.name AS "Vet",a.name AS "Animal", date_of_visit 
    FROM visits v 
    LEFT JOIN animals a 
    ON v.animal_id = a.id 
    LEFT JOIN vets 
    ON v.vet_id = vets.id 
    WHERE vets.name = 'Jack Harkness' 
    ORDER BY date_of_visit 
    LIMIT 1;


-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name AS "Vet", COUNT(*) 
    FROM visits v
    LEFT JOIN vets 
    ON v.vet_id = vets.id
    LEFT JOIN specializations s
    ON vets.id = s.vets_id 
    LEFT JOIN species 
    ON s.species_id = species.id 
    WHERE s.species_id IS NULL OR s.species_id != species.id 
    GROUP BY vets.name;


-- What specialty should Maisy Smith consider getting? Look for the species she gets the most
SELECT vets.name AS "Vet", species.name AS "Specie", COUNT(*) 
    FROM visits v
    LEFT JOIN vets 
    ON v.vet_id = vets.id
    LEFT JOIN animals a
    ON v.animal_id = a.id 
    LEFT JOIN species 
    ON a.species_id = species.id
    WHERE vets.name = 'Maisy Smith' 
    GROUP BY vets.name, species.name 
    LIMIT 1;

-----------------------------------------------------------------------


explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;

explain analyse SELECT * FROM visits where vet_id = 2;

explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';
