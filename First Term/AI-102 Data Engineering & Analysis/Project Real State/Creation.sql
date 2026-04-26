DROP DATABASE real_estate;
CREATE DATABASE real_estate;
USE real_estate;
CREATE TABLE Sales_Office (
    office_number  INT           PRIMARY KEY,
    location       VARCHAR(100)  NOT NULL,
    manager_id     INT
);
 
CREATE TABLE Employee (
    employee_id    INT           PRIMARY KEY,
    employee_name  VARCHAR(100)  NOT NULL,
    office_number  INT,
    FOREIGN KEY (office_number) REFERENCES Sales_Office(office_number)
);
 
ALTER TABLE Sales_Office
    ADD CONSTRAINT fk_manager
    FOREIGN KEY (manager_id) REFERENCES Employee(employee_id);
 
CREATE TABLE Property (
    property_id    INT             PRIMARY KEY,
    address        VARCHAR(150)    NOT NULL,
    city           VARCHAR(60)     NOT NULL,
    state          VARCHAR(50)     NOT NULL,
    zip_code       VARCHAR(10)     NOT NULL,
    listing_date   DATE            NOT NULL,
    price          DECIMAL(12,2)   NOT NULL,
    office_number  INT,
    FOREIGN KEY (office_number) REFERENCES Sales_Office(office_number)
);
 
CREATE TABLE Owner (
    owner_id    INT           PRIMARY KEY,
    owner_name  VARCHAR(100)  NOT NULL
);
 
 
CREATE TABLE Property_Owner (
    property_id    INT            NOT NULL,
    owner_id       INT            NOT NULL,
    percent_owned  DECIMAL(5,2)   NOT NULL,
    PRIMARY KEY (property_id, owner_id),
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (owner_id)    REFERENCES Owner(owner_id)
);
 