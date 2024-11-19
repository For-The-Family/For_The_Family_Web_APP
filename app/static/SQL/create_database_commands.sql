CREATE TABLE test_database(
    /* creates a nice index */
    id serial PRIMARY KEY,
    /* having name lets us use "sort by name, ascending/descending" */
    kindergarten_name VARCHAR(255) UNIQUE NOT NULL,
    /* street address to filter based on street name if wanted, unsure */
    street_address VARCHAR(255),
    /* having the postcode lets us easily filter by specific locations in areas */
    post_code INT,
    /* geo_location stores long/lat, unsure if varchat is best for this
    but it will have to do for this test code, idea, using "POINT" or "GEOMETRY"*/
    geo_location VARCHAR(255) UNIQUE,
    /* city is kind of silly to use as filtering,
    kópavogur is not really a separate city from reykjavík
    so unless we change it to something like 
    "broad_neighbourhood*/
    city VARCHAR(255)
);

INSERT INTO test_database (kindergarten_name, street_address, post_code, geo_location, city)
VALUES ('leikskóli_a', 'leikskólagata 27', 111, '64.1053, -21.9106', 'Kópavogur');



SELECT * 
FROM test_database;

SELECT kindergarten_name 
FROM test_database
WHERE kindergarten_name 
LIKE '%óli_a%';


SELECT * 
FROM test_database
WHERE kindergarten_name 
LIKE '%óli_a%';

SELECT *
FROM test_database
WHERE street_address LIKE '%27%';


DROP TABLE test_database;