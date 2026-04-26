USE real_estate;

INSERT INTO Sales_Office (office_number, location, manager_id) VALUES
(1, 'Cairo, Nasr City',       NULL),
(2, 'Cairo, Maadi',           NULL),
(3, 'Alexandria, Sidi Gaber', NULL),
(4, 'Giza, 6th of October',   NULL),
(5, 'Cairo, Heliopolis',      NULL);
 
-- ── Employees ──────────────────────────────────────────────
INSERT INTO Employee (employee_id, employee_name, office_number) VALUES
(101, 'Ahmed Mostafa',     1),
(102, 'Sara Khalil',       1),
(103, 'Omar Hassan',       1),
(104, 'Nour El-Din',       1),
(105, 'Rana Adel',         1),
(106, 'Hossam Eid',        1),
(107, 'Ines Nader',        1),
(108, 'Mariam Youssef',    1),
(109, 'Youssef Gad',       1),
(110, 'Layla Ibrahim',     1),
(111, 'Bishoy Girgis',     1),
(112, 'Carine Adib',       1),
(113, 'Tarek Samir',       2),
(114, 'Dina Fawzy',        2),
(115, 'Kareem Nabil',      2),
(116, 'Rania Khalil',      2),
(117, 'Alaa Mahmoud',      2),
(118, 'Ghada Osama',       2),
(119, 'Fady Wadie',        2),
(120, 'Emad Ismail',       2),
(121, 'Mona Hassan',       3),
(122, 'Bassem Ramzy',      3),
(123, 'Amal Tawfiq',       3),
(124, 'Sherif Adel',       3),
(125, 'Heba Mostafa',      3),
(126, 'Wael Kamal',        4),
(127, 'Noha Samy',         4),
(128, 'Islam Farouk',      4),
(129, 'Samar Hossam',      5),
(130, 'Peter Medhat',      5);
 
-- Assign managers
UPDATE Sales_Office SET manager_id = 101 WHERE office_number = 1;
UPDATE Sales_Office SET manager_id = 113 WHERE office_number = 2;
UPDATE Sales_Office SET manager_id = 121 WHERE office_number = 3;
UPDATE Sales_Office SET manager_id = 126 WHERE office_number = 4;
UPDATE Sales_Office SET manager_id = 129 WHERE office_number = 5;
 
-- ── Owners ─────────────────────────────────────────────────
INSERT INTO Owner (owner_id, owner_name) VALUES
(201, 'Khaled Fahmy'),
(202, 'Samira Lotfy'),
(203, 'Hassan El-Sayed'),
(204, 'Reem Abdallah'),
(205, 'Mazen Naguib'),
(206, 'Dalia Karim'),
(207, 'Nabil Shawky'),
(208, 'Yasmine Fouad'),
(209, 'Amr Osman'),
(210, 'Mervat Salah'),
(211, 'Faris Adly'),
(212, 'Nadia Sobhi'),
(213, 'Taha El-Masry'),
(214, 'Riham Badr'),
(215, 'Samy Fouad');
 
-- ── Properties ───────────────────────────────────────────── 
INSERT INTO Property (property_id, address, city, state, zip_code, listing_date, price, office_number) VALUES
(301, '12 Al-Nasr St',          'Cairo',      'Cairo',       '11471', '2022-01-15',  3200000.00, 1),
(302, '5 Makram Ebeid Ave',     'Cairo',      'Cairo',       '11762', '2022-04-20',  2750000.00, 1),
(303, '88 Mostafa El-Nahas',    'Cairo',      'Cairo',       '11471', '2022-08-10',  1950000.00, 1),
(304, '17 Abbas El-Akkad',      'Cairo',      'Cairo',       '11371', '2022-11-05',  4100000.00, 1),
(305, '3 Al-Tayaran St',        'Cairo',      'Cairo',       '11341', '2023-02-18',  2300000.00, 1),
(306, '44 Salah Salem Rd',      'Cairo',      'Cairo',       '11321', '2023-05-30',  3750000.00, 1),
(307, '9 Merghany St',          'Cairo',      'Cairo',       '11341', '2023-09-14',  2100000.00, 1),
(308, '21 El-Hegaz St',         'Cairo',      'Cairo',       '11471', '2024-01-22',  5000000.00, 1),
(309, '6 Ibn Sina St',          'Cairo',      'Cairo',       '11341', '2024-04-07',  1800000.00, 1),
(310, '30 Nozha St',            'Cairo',      'Cairo',       '11843', '2024-07-19',  2950000.00, 1),
(311, '9 Road 9, Maadi',        'Cairo',      'Cairo',       '11431', '2022-03-08',  4500000.00, 2),
(312, '21 Road 250, Maadi',     'Cairo',      'Cairo',       '11431', '2022-07-25',  3900000.00, 2),
(313, '6 Corniche El-Maadi',    'Cairo',      'Cairo',       '11728', '2023-01-11',  6200000.00, 2),
(314, '14 Road 87, Maadi',      'Cairo',      'Cairo',       '11431', '2023-06-29',  3100000.00, 2),
(315, '33 Nile Corniche',       'Giza',       'Giza',        '12111', '2023-10-03',  2800000.00, 2),
(316, '7 Giza Square',          'Giza',       'Giza',        '12211', '2024-02-14',  1600000.00, 2),
(317, '2 Pyramids Rd',          'Giza',       'Giza',        '12556', '2024-06-01',  2200000.00, 2),
(318, '10 El-Gaish Rd',         'Alexandria', 'Alexandria',  '21111', '2022-05-17',  1400000.00, 3),
(319, '55 Horreya Ave',         'Alexandria', 'Alexandria',  '21519', '2023-03-22',  1750000.00, 3),
(320, '2 Smouha Square',        'Alexandria', 'Alexandria',  '21648', '2023-11-08',  2600000.00, 3),
(321, '8 Stanley Bridge Rd',    'Alexandria', 'Alexandria',  '21111', '2024-05-13',  3300000.00, 3),
(322, '19 Abu Qir St',          'Alexandria', 'Alexandria',  '21817', '2022-09-30',  1100000.00, 4),
(323, '44 Al-Ahrar St',         'Alexandria', 'Alexandria',  '21519', '2023-08-16',  1350000.00, 4),
(324, '15 Sheikh Zayed Blvd',   'Giza',       'Giza',        '12588', '2024-03-25',  3850000.00, 4),
(325, '3 Winter Palace Rd',     'Luxor',      'Luxor',       '85111', '2022-12-01',   950000.00, 5);
 
-- ── Property_Owner ─────────────────────────────────────────
INSERT INTO Property_Owner (property_id, owner_id, percent_owned) VALUES
(301, 201, 100.00),
(305, 201,  60.00),
(308, 201,  50.00),
(315, 201,  75.00),
(322, 201, 100.00),
(302, 202, 100.00),
(306, 202,  40.00),
(311, 202,  55.00),
(318, 202, 100.00),
(303, 203, 100.00),
(308, 203,  50.00),
(319, 203,  80.00),
(304, 204,  70.00),
(312, 204, 100.00),
(323, 204,  45.00),
(305, 205,  40.00),
(313, 205,  60.00),
(306, 206,  60.00),
(316, 206, 100.00),
(307, 207, 100.00),
(320, 207,  35.00),
(309, 208,  65.00),
(321, 208, 100.00),
(310, 209, 100.00),
(311, 210,  45.00),
(317, 211,  70.00),
(314, 212, 100.00),
(324, 213, 100.00),
(319, 214,  20.00),
(325, 215, 100.00),
(315, 211,  25.00),
(320, 213,  65.00),
(317, 206,  30.00),
(309, 212,  35.00),
(323, 205, 55.00);
 
 
 DELETE FROM Employee;
 DELETE FROM Sales_Office;
 DELETE FROM Owner;
 DELETE FROM Property;
 DELETE FROM Property_Owner;
 -- Step 1: Remove the manager references in Sales_Office first
UPDATE Sales_Office SET manager_id = NULL;

-- Step 2: Now delete Employee (FK reference is gone)
DELETE FROM Employee;

-- Step 3: Now delete Sales_Office
DELETE FROM Sales_Office;

-- 1. Which sales office manages the most properties?
--    Result: Nasr City=10, Maadi=7, Sidi Gaber=4, 6th October=3, Heliopolis=1
SELECT so.location, COUNT(p.property_id) AS total_properties
FROM Sales_Office so
JOIN Property p ON so.office_number = p.office_number
GROUP BY so.location
ORDER BY total_properties DESC;
 
-- 2. Which city has the most listed properties?
--    Result: Cairo=14, Alexandria=6, Giza=4, Luxor=1
SELECT city, COUNT(*) AS total_properties
FROM Property
GROUP BY city
ORDER BY total_properties DESC;
 
-- 3. Which owner holds the most properties?
SELECT o.owner_name, COUNT(DISTINCT po.property_id) AS properties_owned
FROM Owner o
JOIN Property_Owner po ON o.owner_id = po.owner_id
GROUP BY o.owner_name
ORDER BY properties_owned DESC;
 
-- 4. Which owner has the highest total percent owned?
SELECT o.owner_name, ROUND(SUM(po.percent_owned), 2) AS total_percent
FROM Owner o
JOIN Property_Owner po ON o.owner_id = po.owner_id
GROUP BY o.owner_name
ORDER BY total_percent DESC;
 
-- 5. Which properties have multiple co-owners?
SELECT p.address, p.city, COUNT(po.owner_id) AS num_owners
FROM Property p
JOIN Property_Owner po ON p.property_id = po.property_id
GROUP BY p.property_id, p.address, p.city
HAVING COUNT(po.owner_id) > 1
ORDER BY num_owners DESC;
 
-- 6. Which sales office has the most employees?
--    Result: Nasr City=12, Maadi=8, Sidi Gaber=5, 6th October=3, Heliopolis=2
SELECT so.location, COUNT(e.employee_id) AS total_employees
FROM Sales_Office so
JOIN Employee e ON so.office_number = e.office_number
GROUP BY so.location
ORDER BY total_employees DESC;
 
-- 7. Which manager oversees the highest total property value?
SELECT
    e.employee_name             AS manager,
    so.location                 AS office,
    COUNT(p.property_id)        AS total_properties,
    SUM(p.price)                AS total_portfolio_value,
    ROUND(AVG(p.price), 2)      AS avg_property_price
FROM Employee e
JOIN Sales_Office so ON e.employee_id    = so.manager_id
JOIN Property p      ON so.office_number = p.office_number
GROUP BY e.employee_name, so.location
ORDER BY total_portfolio_value DESC;
 
-- 8. How many properties were listed per year?  (time trend)
SELECT
    YEAR(listing_date)      AS listing_year,
    COUNT(*)                AS total_listed,
    SUM(price)              AS total_value
FROM Property
GROUP BY YEAR(listing_date)
ORDER BY listing_year;
 
-- 9. Average property price per city
SELECT
    city,
    COUNT(*)                    AS total_properties,
    ROUND(AVG(price), 2)        AS avg_price,
    MIN(price)                  AS cheapest,
    MAX(price)                  AS most_expensive
FROM Property
GROUP BY city
ORDER BY avg_price DESC;
 
-- 10. Most expensive properties (top 5)
SELECT TOP 5
    p.address,
    p.city,
    p.price,
    so.location     AS office,
    o.owner_name
FROM Property p
JOIN Sales_Office so   ON p.office_number = so.office_number
JOIN Property_Owner po ON p.property_id   = po.property_id
JOIN Owner o           ON po.owner_id     = o.owner_id
WHERE po.percent_owned = (
    SELECT MAX(po2.percent_owned)
    FROM Property_Owner po2
    WHERE po2.property_id = p.property_id
)
ORDER BY p.price DESC;
 
-- 11. Properties listed per quarter across all years  (Power BI line chart)
SELECT
    YEAR(listing_date)                              AS yr,
    DATEPART(QUARTER, listing_date)                 AS qtr,
    COUNT(*)                                        AS properties_listed,
    SUM(price)                                      AS total_value
FROM Property
GROUP BY YEAR(listing_date), DATEPART(QUARTER, listing_date)
ORDER BY yr, qtr;
 
-- 12. Total portfolio value per office
SELECT
    so.location,
    COUNT(p.property_id)        AS total_properties,
    SUM(p.price)                AS total_value,
    ROUND(AVG(p.price), 2)      AS avg_price
FROM Sales_Office so
JOIN Property p ON so.office_number = p.office_number
GROUP BY so.location
ORDER BY total_value DESC;

