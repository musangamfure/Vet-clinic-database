/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Agumon', '2020-02-03', 0, TRUE, 10.23),
('Gabumon', '2018-11-15', 2, TRUE, 8),
('Pikachu', '2021-01-07', 1, FALSE, 15.04),
('Devimon', '2017-05-12', 5, TRUE, 11);

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Charmander', '2020-02-08', 0, FALSE, -11),
('Plantmon', '2021-11-15', 2, TRUE, -5.70),
('Squirtle', '1993-04-02', 3, FALSE, -12.13),
('Angemon', '2005-06-12', 1, TRUE, -45),
('Boarmon', '2005-06-07', 7, TRUE, 20.40),
('Blossom', '1998-10-13', 3, TRUE, 17),
('Ditto', '2022-05-14', 4, TRUE, 22);




-- Insert data into owners table
INSERT INTO owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

-- Insert data into species table
INSERT INTO species (name)
VALUES ('Pokemon'), ('Digimon');

-- Modify animals to include species_id and owner_id
UPDATE animals
SET species_id = CASE
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END;

UPDATE animals
SET owner_id = CASE
        WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
        WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
        WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
        WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
        WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
    END;



-- vets data

INSERT INTO vets (id,name,age, date_of_graduation) VALUES (1,'William Tatcher',45,'2000-04-23');
INSERT INTO vets (id,name,age, date_of_graduation) VALUES (2,'Maisy Smith',26,'2019-01-17');
INSERT INTO vets (id,name,age, date_of_graduation) VALUES (3,'Stephanie Mendez',64,'1981-05-04');
INSERT INTO vets (id,name,age, date_of_graduation) VALUES (4,'Jack Harkness',38,'2008-06-08');

-- specialities data

INSERT INTO specializations (species_id, vets_id) VALUES (1, 1);
INSERT INTO specializations (species_id, vets_id) VALUES (2, 3);
INSERT INTO specializations (species_id, vets_id) VALUES (1, 3);
INSERT INTO specializations (species_id, vets_id) VALUES (2, 4);

-- -- visits data
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (1, 1, '2020-05-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (1, 3, '2020-07-22');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (2, 4, '2021-02-02');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3, 2, '2020-01-05');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3, 2, '2020-03-08');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3, 2, '2020-05-14');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (4, 3, '2021-05-04');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (5, 4, '2021-02-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6, 2, '2019-12-21');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6, 1, '2020-08-10');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6, 2, '2021-04-07');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (7, 3, '2021-09-29');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (8, 4, '2020-10-03');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (8, 4, '2020-11-04');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, '2019-01-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, '2019-05-15');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, '2020-02-27');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, '2020-08-03');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (10, 3, '2020-05-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (10, 1, '2021-01-11');


