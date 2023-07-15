/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name like '%mon';

SElECT * from animals WHERE date_of_birth between '2016-01-01' and '2019-12-31';

SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Pikachu', 'Agumon');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;

SELECT * FROM animals WHERE neutered = TRUE;

SELECT * FROM animals WHERE name NOT IN ('Gabumon');

SELECT * FROM animals WHERE weight_kg BETWEEN 10.40 and 17.30;





-- Transaction 1: Set species column to unspecified for all animals
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals; 
ROLLBACK;
SELECT * FROM animals; 

-- Transaction 2: Set species column to digimon for animals with name ending in mon
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;

-- Set species column to pokemon for animals without a species set
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;

COMMIT;
SELECT * FROM animals;

-- Transaction 3: Delete all records in the animals table
BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Transaction 4: Delete animals born after Jan 1st, 2022
BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT weight_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO weight_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT * FROM animals; -- Verify changes after commit




SELECT count(*) FROM animals;
SELECT count(*) FROM animals WHERE escape_attempts = 0;
SELECT avg(weight_kg) from animals;
SELECT * FROM animals WHERE neutered = true ORDER BY escape_attempts DESC LIMIT 1;
SELECT * FROM animals WHERE neutered = false ORDER BY escape_attempts DESC LIMIT 1;
SELECT MAX(weight_kg) FROM animals WHERE species = 'pokemon';
SELECT MIN(weight_kg) FROM animals WHERE species = 'pokemon';
SELECT MAX(weight_kg) FROM animals WHERE species = 'digimon';
SELECT MIN(weight_kg) FROM animals WHERE species = 'digimon';
SELECT AVG(escape_attempts) FROM animals WHERE species = 'pokemon' and date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';
SELECT AVG(escape_attempts) FROM animals WHERE species = 'digimon' and date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';




-- What animals belong to Melody Pond?
SELECT name, full_name
FROM animals
JOIN owners
ON animals.owner_id = owners.id AND animals.owner_id = 4;


-- List of all animals that are pokemon (their type is Pokemon)

SELECT animals.name, species.name
FROM animals
JOIN species
ON animals.species_id = species.id AND animals.species_id = 1;

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT name, full_name
FROM animals
FULL JOIN owners
ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT animals.species_id, species.name as species_name, COUNT(animals.species_id) as num_animals
FROM animals
JOIN species
ON animals.species_id = species.id
GROUP BY animals.species_id, species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name, owners.full_name
FROM animals
INNER JOIN owners
ON animals.owner_id = 2 AND owners.id = 2
INNER JOIN species
ON animals.species_id = 2 AND species.id = 2;

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT animals.name, owners.full_name
FROM animals
INNER JOIN owners
ON animals.owner_id = 5 AND owners.id = 5 AND animals.escape_attempts = 0;

-- Who owns the most animals?

SELECT COUNT(animals.owner_id) as num_animals, owners.full_name
FROM animals
JOIN owners
ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY num_animals DESC
LIMIT 1;




-- Who was the last animal seen by William Tatcher?
SELECT date_of_visit, vets.name as vet_name, animals.name as animal_name
FROM visits
JOIN vets
ON visits.vet_id = 1 AND vets.id = 1
JOIN animals
ON visits.animal_id = animals.id
GROUP BY date_of_visit, vet_name, animal_name
ORDER BY date_of_visit DESC
LIMIT 1;


-- How many different animals did Stephanie Mendez see?
SELECT COUNT(animal_id) as animal_count, vet_id, vets.name as vet_name
FROM visits
JOIN vets
ON visits.vet_id = 3 AND vets.id = 3
GROUP BY vet_id, vet_name;



-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name as vet_name, species.name as specialty
FROM specializations
FULL JOIN vets
ON specializations.vet_id = vets.id
FULL JOIN species
ON specializations.species_id = species.id;


-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name as animal_name, vets.name as vet_name, date_of_visit
FROM visits
JOIN animals
ON visits.animal_id = animals.id
JOIN vets
ON visits.vet_id = vets.id AND vets.id = 3
GROUP BY animal_name, vet_name, date_of_visit
HAVING date_of_visit BETWEEN DATE '2020-04-01' AND '2020-08-30';


-- What animal has the most visits to vets?
SELECT COUNT(animals.id) as most_visit, animals.name as animal_name
FROM visits
JOIN animals
ON visits.animal_id = animals.id
GROUP BY animal_name
ORDER BY most_visit DESC
LIMIT 1;


-- Who was Maisy Smith's first visit?
SELECT visits.animal_id, animals.name as animal_name, visits.vet_id, vets.name as vet_name, date_of_visit
FROM visits
JOIN vets
ON visits.vet_id = 2 AND visits.vet_id = vets.id
JOIN animals
ON animals.id = visits.animal_id
ORDER BY date_of_visit ASC
LIMIT 1;


-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT visits.animal_id, animals.name as animal_name, visits.vet_id, vets.name as vet_name, date_of_visit
FROM visits
JOIN vets
ON visits.vet_id = vets.id
JOIN animals
ON animals.id = visits.animal_id
ORDER BY date_of_visit DESC
LIMIT 1;


-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(date_of_visit) as num_visits, visits.vet_id, specializations.species_id as specialty
FROM specializations
RIGHT JOIN visits
ON specializations.vet_id = visits.vet_id
WHERE specializations.vet_id IS NULL
GROUP BY visits.vet_id, specialty;


-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT date_of_visit, visits.vet_id, vets.name, animals.species_id, species.name as species_name
FROM visits
JOIN animals
ON visits.animal_id = animals.id AND visits.vet_id = 2
JOIN vets
ON vets.id = visits.vet_id
JOIN species
ON species.id = animals.species_id
WHERE animals.species_id = 2;

