CREATE DATABASE salon;
-- \c salon

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    phone VARCHAR(25) NOT NULL UNIQUE,
    name TEXT
);

CREATE TABLE appointments(
    appointment_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    service_id INT NOT NULL,
    time VARCHAR(25)
);

CREATE TABLE services(
    service_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

ALTER TABLE appointments
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE appointments
ADD FOREIGN KEY (service_id) REFERENCES services(service_id);

INSERT INTO services(name)
VALUES('cut'),
('color'),
('perm'),
('style'),
('trim');