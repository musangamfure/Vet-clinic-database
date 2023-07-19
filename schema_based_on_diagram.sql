
CREATE DATABASE clinic;
CREATE TABLE patients (
    id BIGSERIAL NOT NULL PRIMARY KEY, 
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL
);
CREATE TABLE treatments (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);
CREATE TABLE medical_histories (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT NOT NULL,
    status VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients (id)
);
CREATE TABLE treatment_medical_history (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    treatment_id INT NOT NULL,
    medical_history_id INT NOT NULL,
    FOREIGN KEY (treatment_id) REFERENCES treatments (id),
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id)
);
CREATE TABLE invoices (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP NOT NULL,
    payed_at TIMESTAMP NOT NULL,
    medical_history_id INT NOT NULL,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id)
)
CREATE TABLE invoice_items (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    unit_price DECIMAL NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL NOT NULL,
    invoice_id INT NOT NULL,
    treatment_id INT NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES invoices (id),
    FOREIGN KEY (treatment_id) REFERENCES treatments (id)
);


-- indexes

CREATE INDEX indx_medical_histories ON medical_histories (patient_id);
CREATE INDEX indx_treatment_medical_history ON treatment_medical_history (treatment_id, medical_history_id);
CREATE INDEX indx_invoices ON invoices (medical_history_id);
CREATE INDEX indx_invoices_items ON invoice_items (invoice_id, treatment_id);
