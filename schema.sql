/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    name VARCHAR(50), 
    date_of_birth DATE, 
    escape_attempts INTEGER, 
    neutered BOOLEAN, 
    weight_kg DECIMAL
    );

ALTER TABLE animals
ADD COLUMN species VARCHAR(20);


-- Create owners table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INTEGER
);

-- Create species table
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

ALTER TABLE animals
    DROP COLUMN species,
    ADD COLUMN species_id INTEGER,
    ADD COLUMN owner_id INTEGER;

-- Add FOREIGN KEY constraints
ALTER TABLE animals
    ADD CONSTRAINT fk_species
    FOREIGN KEY (species_id)
    REFERENCES species(id);

ALTER TABLE animals
    ADD CONSTRAINT fk_owner
    FOREIGN KEY (owner_id)
    REFERENCES owners(id);