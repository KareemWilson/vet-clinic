SELECT * from animals WHERE name LIKE '%mon%'
SELECT * from animals WHERE date_of_birth BETWEEN '01-01-2016' AND '01-01-2019';
SELECT * from animals WHERE neutered IS true AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name IN ('Agumon','Pikachu');
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS true;
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;