INSERT INTO animals (
    id,
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
) VALUES (1, 'Agumon', '03-02-2020', 10.23, true, 0);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
) VALUES (2, 'Gabumon', '15-11-2018', 8, true, 2);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
) VALUES (3, 'Pikachu', '01-07-2021', 15.04, false, 1);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
) VALUES (4, 'Devimon', '12-05-2017', 11, true, 5);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
) VALUES (5, 'Charmander', '08-02-2020', -11, false, 0);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
) VALUES (6, 'Plantmon', '15-11-2021', -5.7, true, 2);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
) VALUES (7, 'Squirtle', '02-04-1993', -12.13, false, 3);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
) VALUES (8, 'Angemon', '12-06-2005', -45, true, 1);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
) VALUES (9, 'Boarmon', '07-06-2005', 20.4, true, 7);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
) VALUES (10, 'Blossom', '13-10-1998', 17, true, 3);

INSERT INTO animals (
    id,
    name,
    date_of_birth,
    weight_kg,
    neutered,
    escape_attempts
) VALUES (11, 'Ditto', '14-05-2022', 22, true, 4);

/* insert data into owner table */ 

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

/* insert data into species table */ 

INSERT INTO species (name) VALUES ('Digimon');
INSERT INTO species (name) VALUES ('Pokimon');

-- Modify animals table 'species_id column'
UPDATE animals SET species_id = 1 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 2 WHERE species_id is null;

-- Modify animals table 'owner_id column'
UPDATE animals SET owner_id = 1 WHERE name in ('Agumon');
UPDATE animals SET owner_id = 2 WHERE name in ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name in ('Plantmon');
UPDATE animals SET owner_id = 4 WHERE name in ('Charmander','Squirtle','Blossom');
UPDATE animals SET owner_id = 5 WHERE name in ('Boarmon','Angemon');

-- Insert data for vets:
INSERT INTO vets (name, age, date_of_graduation) VALUES('William Tatcher', 45, '23-04-2000');
INSERT INTO vets (name, age, date_of_graduation) VALUES('Maisy Smith', 26, '17-01-2019');
INSERT INTO vets (name, age, date_of_graduation) VALUES('Stephanie Mendez', 64, '04-05-1981');
INSERT INTO vets (name, age, date_of_graduation) VALUES('Jack Harkness', 38, '08-01-2008');

-- Insert data for specializations.
INSERT INTO specializations(species_id, vets_id)
VALUES((SELECT id FROM species WHERE name = 'Pokimon'), (SELECT id FROM vets WHERE name = 'William Tatcher')),
((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
((SELECT id FROM species WHERE name = 'Pokimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'));

-- Insert data for visits table.

INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES(1, 1, '24-05-2020'), (1, 3, '22-07-2020'), (2, 4, '02-02-2021'),
(3, 2, '05-01-2020'), (3, 2, '08-03-2020'), (3, 2, '14-05-2020'), (4, 3, '04-05-2021'),
(5, 4, '24-02-2021'), (6, 2, '21-12-2019'), (6, 1, '10-10-2020'), (6, 2, '07-04-2021'),
(7, 3, '29-09-2019'), (8, 4, '03-10-2020'), (8, 4, '04-11-2020'), (9, 2, '27-01-2019'),
(9, 2, '15-05-2019'), (9, 2, '27-02-2020'), (9, 2, '03-08-2020'), (10, 3, '24-05-2020'), (10, 1, '11-01-2021');

------------------------------------------------------------------
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';


