
/* #region Queries */

/* #region Get all kindergartens */

SELECT * FROM kindergartens;

/* #endregion */

/* #region Get all facilities */

SELECT * FROM facilities;

/* #endregion */

/* #region Get all kindergarten facilities */

SELECT * FROM kindergarten_facilities;

/* #endregion */

/* #region Get all kindergartens with facilities */

SELECT kindergartens.id, 
        kindergartens.name, 
        kindergarten_facilities.facility_id, 
        facilities.facility_name, 
        kindergarten_facilities.is_available
FROM kindergartens
JOIN kindergarten_facilities ON kindergartens.id = kindergarten_facilities.kindergarten_id
JOIN facilities ON kindergarten_facilities.facility_id = facilities.id;

-- same thing, but simplified to avoid confusion
SELECT
    k.id,
    k.name,
    kf.facility_id,
    f.facility_name,
    kf.is_available
FROM kindergartens k
JOIN kindergarten_facilities kf ON k.id = kf.kindergarten_id
JOIN facilities f ON kf.facility_id = f.id;
-- basically k.id is the same as kindergartens.id, 
-- due to the fact that we aliased kindergartens as k, where we state "from kindergartens k"
-- same goes for facilities and kindergarten_facilities
-- this is done to avoid confusion when we have multiple tables with the same column names
-- and should help with readability


/* #endregion */

/* #region example queries */

SELECT DISTINCT k.*
FROM kindergartens k
JOIN kindergarten_activities ka ON k.id = ka.kindergarten_id
JOIN activities a ON ka.activity_id = a.id
JOIN kindergarten_facilities kf ON k.id = kf.kindergarten_id
JOIN facilities f ON kf.facility_id = f.id
WHERE k.city = 'Reykjavík' AND k.postal_code = '101'
  AND a.activity_name = 'Slide' AND ka.is_available = TRUE
  AND f.facility_name = 'Parking' AND kf.is_available = TRUE;


--
SELECT * FROM kindergartens
WHERE name ILIKE '%borg%';

--
SELECT *
FROM kindergartens
WHERE '08:00' BETWEEN SUBSTRING(opening_hours FROM 1 FOR 5) AND SUBSTRING(opening_hours FROM 9 FOR 5);

--
SELECT k.*
FROM kindergartens k
JOIN kindergarten_activities ka ON k.id = ka.kindergarten_id AND ka.is_available = TRUE
JOIN activities a ON ka.activity_id = a.id
WHERE a.activity_name IN ('Slide', 'Sandbox', 'Climbing-Frame')
GROUP BY k.id
HAVING COUNT(DISTINCT a.activity_name) = 3;

-- query generated by chat gpt after asking it how to query distance
-- with geolocation, after setting up the extension "PostGIS" and
-- creating a column "geog" with the type "geography(Point, 4326)"

/* #region Geolocation query NOT IMPLEMENTED YET! */
-- Enable PostGIS extension
CREATE EXTENSION IF NOT EXISTS postgis;

-- Add a geography column for spatial data
ALTER TABLE kindergartens
  ADD COLUMN geog geography(Point, 4326);

-- Update the geography column with latitude and longitude
UPDATE kindergartens
SET geog = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);


SELECT k.*
FROM kindergartens k
WHERE ST_DWithin(
    k.geog,
    ST_SetSRID(ST_MakePoint(-21.902, 64.139), 4326),
    5000  -- Distance in meters
);

/* #endregion */

--
SELECT
    k.name,
    STRING_AGG(DISTINCT a.activity_name, ', ') AS activities,
    STRING_AGG(DISTINCT f.facility_name, ', ') AS facilities
FROM kindergartens k
LEFT JOIN kindergarten_activities ka ON k.id = ka.kindergarten_id AND ka.is_available = TRUE
LEFT JOIN activities a ON ka.activity_id = a.id
LEFT JOIN kindergarten_facilities kf ON k.id = kf.kindergarten_id AND kf.is_available = TRUE
LEFT JOIN facilities f ON kf.facility_id = f.id
GROUP BY k.name;

--
SELECT k.*
FROM kindergartens k
WHERE k.id NOT IN (
    SELECT ka.kindergarten_id
    FROM kindergarten_activities ka
    JOIN activities a ON ka.activity_id = a.id
    WHERE a.activity_name = 'Painted-Road' AND ka.is_available = TRUE
);

--
SELECT COUNT(DISTINCT k.id) AS num_kindergartens
FROM kindergartens k
JOIN kindergarten_activities ka ON k.id = ka.kindergarten_id
JOIN activities a ON ka.activity_id = a.id
WHERE a.activity_name = 'Slide' AND ka.is_available = TRUE;

--
SELECT a.activity_name
FROM kindergartens k
JOIN kindergarten_activities ka ON k.id = ka.kindergarten_id
JOIN activities a ON ka.activity_id = a.id
WHERE k.name = 'Austurborg' AND ka.is_available = TRUE;

--
SELECT * FROM kindergartens
WHERE minimum_age <= 2;


--
SELECT DISTINCT k.*
FROM kindergartens k
JOIN kindergarten_activities ka ON k.id = ka.kindergarten_id
JOIN activities a ON ka.activity_id = a.id
JOIN kindergarten_facilities kf ON k.id = kf.kindergarten_id
JOIN facilities f ON kf.facility_id = f.id
WHERE k.city = 'Reykjavík' AND k.postal_code = '101'
  AND a.activity_name = 'Slide' AND ka.is_available = TRUE
  AND f.facility_name = 'Parking' AND kf.is_available = TRUE;


--
SELECT * FROM kindergartens
WHERE city = 'Reykjavík' AND postal_code = '101';


--
SELECT k.*
FROM kindergartens k
WHERE k.id IN (
    SELECT ka1.kindergarten_id
    FROM kindergarten_activities ka1
    JOIN activities a1 ON ka1.activity_id = a1.id
    WHERE a1.activity_name = 'Slide' AND ka1.is_available = TRUE
)
AND k.id IN (
    SELECT ka2.kindergarten_id
    FROM kindergarten_activities ka2
    JOIN activities a2 ON ka2.activity_id = a2.id
    WHERE a2.activity_name = 'Sandbox' AND ka2.is_available = TRUE
);


--
SELECT k.*
FROM kindergartens k
JOIN kindergarten_facilities kf ON k.id = kf.kindergarten_id
JOIN facilities f ON kf.facility_id = f.id
WHERE f.facility_name = 'Parking' AND kf.is_available = TRUE;


--
SELECT k.*
FROM kindergartens k
JOIN kindergarten_activities ka ON k.id = ka.kindergarten_id
JOIN activities a ON ka.activity_id = a.id
WHERE a.activity_name = 'Slide' AND ka.is_available = TRUE;


--



/* #endregion */

/* #endregion */