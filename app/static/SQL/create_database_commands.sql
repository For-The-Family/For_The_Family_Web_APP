/* #region Test data */

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
/* #endregion */


/* #region Data Table Creations */

-- Main table for kindergartens
CREATE TABLE kindergartens (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    street_address VARCHAR(255),
    city VARCHAR(255),
    postal_code VARCHAR(10),
    latitude DECIMAL(8, 5),
    longitude DECIMAL(8, 5),
    opening_hours VARCHAR(50),
    minimum_age INT,
    image_path VARCHAR(255)
);

-- Table for activities
CREATE TABLE activities (
    id SERIAL PRIMARY KEY,
    activity_name VARCHAR(50) UNIQUE NOT NULL
);

-- Join table for kindergarten activities
CREATE TABLE kindergarten_activities (
    kindergarten_id INT REFERENCES kindergartens(id) ON DELETE CASCADE,
    activity_id INT REFERENCES activities(id) ON DELETE CASCADE,
    is_available BOOLEAN NOT NULL,
    PRIMARY KEY (kindergarten_id, activity_id)
);

-- Table for facilities
CREATE TABLE facilities (
    id SERIAL PRIMARY KEY,
    facility_name VARCHAR(50) UNIQUE NOT NULL
);

-- Join table for kindergarten facilities
CREATE TABLE kindergarten_facilities (
    kindergarten_id INT REFERENCES kindergartens(id) ON DELETE CASCADE,
    facility_id INT REFERENCES facilities(id) ON DELETE CASCADE,
    is_available BOOLEAN NOT NULL,
    PRIMARY KEY (kindergarten_id, facility_id)
);

/* #endregion */

/* #region Data Insertions */


/* #region kindergartens activities names */

-- activities
INSERT INTO activities (id, activity_name) VALUES
(1, 'Ballance-Swings'),
(2, 'Big-Basket-Swings'),
(3, 'Castle'),
(4, 'Climbing-Frame'),
(5, 'Infant-Swings'),
(6, 'Painted-Road'),
(7, 'Sandbox'),
(8, 'Slide'),
(9, 'Tire-Swings');

/* #endregion */

/* #region kindergartens facilities names */

-- Facilities
INSERT INTO facilities (id, facility_name) VALUES
(1, 'Food & Drinks'),
(2, 'Parking'),
(3, 'Toilets');


/* #endregion */

/* #region Kindergartens data */

INSERT INTO kindergartens (id, name, street_address, city, postal_code, latitude, longitude, opening_hours, minimum_age, image_path) VALUES
(1, 'Austurborg', 'Háaleitisbraut 70', 'Reykjavík', '103', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Austurborg.jpg'),
(2, 'Askja', 'Nauthólsvegur 87', 'Reykjavík', '102', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/placeholder.jpg'),
(3, 'Álftaborg', 'Safamýri 30', 'Reykjavík', '108', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Alftaborg.jpg'),
(4, 'Árborg', 'Hlaðbær 17', 'Reykjavík', '110', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Arborg.jpg'),
(5, 'Ártúnsskóli', 'Árkvörn 4', 'Reykjavík', '110', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Artunsskoli.jpg'),
(6, 'Bakkaborg', 'Blöndubakki 2-4', 'Reykjavík', '109', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Bakkaborg.jpg'),
(7, 'Bjartahlíð', 'Grænahlíð 24 / Stakkahlíð 19', 'Reykjavík', '105', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Bjartahlid.jpg'),
(8, 'Berg', 'Kollagrund 6', 'Reykjavík', '116', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Berg.jpg'),
(9, 'Bakkakot', 'Bakkastaðir 77', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Bakkakot.jpg'),
(10, 'Blásalir', 'Brekknás 4', 'Reykjavík', '110', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Blasalir.jpg'),
(11, 'Borg', 'Maríubakki 1 / Fálkabakki 9', 'Reykjavík', '109', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/placeholder.jpg'),
(12, 'Brákarborg', '', 'Reykjavík', '104', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Brakarborg.jpg'),
(13, 'Drafnarsteinn', 'Drafnarstígur 4 / Seljavegur 12', 'Reykjavík', '101', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Drafnarsteinn.jpg'),
(14, 'Dalskóli', 'Úlfarsbraut 118–122', 'Reykjavík', '113', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Dalskoli.jpg'),
(15, 'Brekkuborg', 'Hlíðarhús 1', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Brekkuborg.jpg'),
(16, 'Engjaborg', 'Reyrengi 11', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Engjaborg.jpg'),
(17, 'Fífuborg', 'Fífurimi 13', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Fifuborg.jpg'),
(18, 'Fossakot', 'Fossaleynir 4', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Fosskot.jpg'),
(19, 'Geislabaugur', 'Kristnibraut 26', 'Reykjavík', '113', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Geislabaugur.jpg'),
(20, 'Furuskógur', 'Áland / Efstaland 28', 'Reykjavík', '108', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Furuskogur.jpg'),
(21, 'Funaborg', 'Funafold 42', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Funaborg.jpg'),
(22, 'Grandaborg', 'Boðagrandi 9 / Fornhagi 8', 'Reykjavík', '107', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Grandaborg.jpg'),
(23, 'Grænaborg', 'Eiríksgata 2', 'Reykjavík', '101', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Graenaborg.jpg'),
(24, 'Gullborg', 'Rekagrandi 14', 'Reykjavík', '107', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Gullborg.jpg'),
(25, 'Hálsaskógur', 'Hálsasel 27-29', 'Reykjavík', '109', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Halsaskogur.jpg'),
(26, 'Hamrar', 'Hamravík 12', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/placeholder.jpg'),
(27, 'Hagaborg', 'Fornhagi 8', 'Reykjavík', '107', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Hagaborg.jpg'),
(28, 'Heiðarborg', 'Selásbraut 56', 'Reykjavík', '110', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Heidarborg.jpg'),
(29, 'Hlíð', 'Engihlíð 6-8 / Eskihlíð 17', 'Reykjavík', '105', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/placeholder.jpg'),
(30, 'Hof', 'Gullteigur 19', 'Reykjavík', '105', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Hof.jpg'),
(31, 'Hraunborg', 'Hraunberg 10', 'Reykjavík', '111', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Hraunborg.jpg'),
(32, 'Hólaborg', 'Suðurhólar 21', 'Reykjavík', '111', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Holaborg.jpg'),
(33, 'Holt', 'Völvufell 7 & 9', 'Reykjavík', '111', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Holt.jpg'),
(34, 'Hulduheimar', 'Vættaborgir 11', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Hulduheimar.jpg'),
(35, 'Jöklaborg', 'Jöklasel 4', 'Reykjavík', '109', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Joklaborg.jpg'),
(36, 'Jörfi', 'Hæðargarður 27a', 'Reykjavík', '108', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Jorfi.jpg'),
(37, 'Korpukot', 'Fossaleynir 12', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Korpukot.jpg'),
(38, 'Klettaborg', 'Dyrhamrar 5', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Klettaborg.jpg'),
(39, 'Klambrar', 'Háteigsvegur 33', 'Reykjavík', '105', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Klambrar.jpg'),
(40, 'Krílasel', 'Rangársel 8', 'Reykjavík', '109', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Krilasel.jpg'),
(41, 'Kvistaborg', 'Kvistaland 26', 'Reykjavík', '108', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Kvistaborg.jpg'),
(42, 'Langholt', 'Sólheimar 19 og 21', 'Reykjavík', '104', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Langholt.jpg'),
(43, 'Laugasól', 'Leirulækur 4-6', 'Reykjavík', '105', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/placeholder.jpg'),
(44, 'Laufskálar', 'Laufrimi 9', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Laufskalar.jpg'),
(45, 'Laufásborg', 'Laufásvegur 53-55', 'Reykjavík', '101', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Laufsborg.jpg'),
(46, 'Lundur', 'Kleppsgarðar 2', 'Reykjavík', '104', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Lundur.jpg'),
(47, 'Lyngheimar', 'Mururimi 2', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Lyngheimar.jpg'),
(48, 'Maríuborg', 'Maríubaugur 3', 'Reykjavík', '113', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Mariuborg.jpg'),
(49, 'Múlaborg - Litli Múli', 'Ármúli 8a', 'Reykjavík', '108', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Litlimuli.jpg'),
(50, 'Múlaborg - Stóri Múli', 'Ármúli 8a', 'Reykjavík', '108', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Storimuli.jpg'),
(51, 'Miðborg', 'Lindargata 26 / Njálsgata 70', 'Reykjavík', '101', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Midborg.jpg'),
(52, 'Mánagarður', 'Eggertsgata 30–34', 'Reykjavík', '101', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Managardur.jpg'),
(53, 'Nóaborg', 'Stangarholt 11', 'Reykjavík', '105', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/placeholder.jpg'),
(54, 'Ós - Nýr', 'Skerplugata 1', 'Reykjavík', '101', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Osnyr.jpg'),
(55, 'Rauðaborg', 'Viðarás 9', 'Reykjavík', '110', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Raudaborg.jpg'),
(56, 'Reynisholt', 'Gvendargeisli 13', 'Reykjavík', '113', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Reynisholt.jpg'),
(57, 'Regnboginn', 'Bleikjukvísl 10', 'Reykjavík', '110', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Regnboginn.jpg'),
(58, 'Rauðhóll', 'Sandavað 7 - Árvað 3 - Elliðabraut 26', 'Reykjavík', '110', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Raudholl.jpg'),
(59, 'Seljakot', 'Rangársel 15', 'Reykjavík', '109', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Seljakot.jpg'),
(60, 'Seljaborg', 'Tungusel 2', 'Reykjavík', '109', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Seljaborg.jpg'),
(61, 'Rofaborg', 'Skólabær 2', 'Reykjavík', '110', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Rofaborg.jpg'),
(62, 'Skerjagarður', 'Bauganes 13', 'Reykjavík', '101', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Skerjagardur.jpg'),
(63, 'Sólborg', 'Vesturhlíð 1', 'Reykjavík', '105', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Solborg.jpg'),
(64, 'Sólgarður', 'Eggertsgata 8', 'Reykjavík', '101', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Solgardur.jpg'),
(65, 'Suðurborg', 'Suðurhólar 19', 'Reykjavík', '111', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Sudurborg.jpg'),
(66, 'Steinahlíð', 'Við Suðurlandsbraut', 'Reykjavík', '108', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Steinahlid.jpg'),
(67, 'Stakkaborg', 'Bólstaðarhlíð 38', 'Reykjavík', '105', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Stakkaborg.jpg'),
(68, 'Sæborg', 'Starhagi 11', 'Reykjavík', '107', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Saeborg.jpg'),
(69, 'Sunnufold', 'Frostafold 33 / Logafold 18', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Sunnufold.jpg'),
(70, 'Sunnuás', 'Dyngjuvegur 18', 'Reykjavík', '104', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Sunnuas.jpg'),
(71, 'Sælukot', 'Þorragata 1', 'Reykjavík', '101', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Saelukot.jpg'),
(72, 'Tjörn', 'Öldugötu 19, Tjarnargötu 33', 'Reykjavík', '101', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/placeholder.jpg'),
(73, 'Ársól', 'Völundarhús 1', 'Reykjavík', '112', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/placeholder.jpg'),
(74, 'Vesturborg', 'Hagamelur 55', 'Reykjavík', '107', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Vesturborg.jpg'),
(75, 'Ungbarnaleikskólinn við Hallgerðargötu - Bríetartún', 'Hallgerðargata 11B', 'Reykjavík', '105', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/placeholder.jpg'),
(76, 'Ungbarnaleikskólinn við Bríetartún', 'Bríetartún 11', 'Reykjavík', '105', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/placeholder.jpg'),
(77, 'Vinaminni', 'Asparfell 10', 'Reykjavík', '111', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Vinaminni.jpg'),
(78, 'Vinagerði', 'Langagerði 1', 'Reykjavík', '108', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Vinagerdi.jpg'),
(79, 'Vinagarður - Leikskóli Kristnifélagsins', 'Holtavegur 28', 'Reykjavík', '104', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Vinagardur.jpg'),
(80, 'Waldorfleikskólinn Sólstafir', 'Sóltún 6', 'Reykjavík', '105', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/placeholder.jpg'),
(81, 'Ægisborg', 'Ægisíða 104', 'Reykjavík', '107', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Aegisborg.jpg'),
(82, 'Ævintýraborg í Vogabyggð', 'Naustavogur 13', 'Reykjavík', '104', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Aevyntiraborg1.jpg'),
(83, 'Ösp', 'Iðufell 16', 'Reykjavík', '111', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Osp.jpg'),
(84, 'Ævintýraborg við Nauthólsveg', 'Nauthólsvegur 81', 'Reykjavík', '102', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Aevyntiraborg2.jpg'),
(85, 'Ævintýraborg við Eggertsgötu', 'Eggertsgata 35', 'Reykjavík', '102', 64.139, -21.902, '07:45 - 16:30', 0, 'images/reykjavik/Aevyntiraborg3.jpg');

/* #endregion */

/* #region Kindergarten Activities */

INSERT INTO kindergarten_activities (kindergarten_id, activity_id, is_available) VALUES
(1, 5, TRUE),
(1, 9, TRUE),
(1, 1, TRUE),
(1, 2, TRUE),
(1, 8, TRUE),
(1, 7, TRUE),
(1, 4, TRUE),
(1, 3, TRUE),
(1, 6, FALSE),
(2, 5, TRUE),
(2, 9, TRUE),
(2, 1, TRUE),
(2, 2, TRUE),
(2, 8, TRUE),
(2, 7, TRUE),
(2, 4, TRUE),
(2, 3, TRUE),
(2, 6, FALSE),
(3, 5, TRUE),
(3, 9, TRUE),
(3, 1, TRUE),
(3, 2, TRUE),
(3, 8, TRUE),
(3, 7, TRUE),
(3, 4, TRUE),
(3, 3, TRUE),
(3, 6, FALSE),
(4, 5, TRUE),
(4, 9, TRUE),
(4, 1, TRUE),
(4, 2, TRUE),
(4, 8, TRUE),
(4, 7, TRUE),
(4, 4, TRUE),
(4, 3, TRUE),
(4, 6, FALSE),
(5, 5, TRUE),
(5, 9, TRUE),
(5, 1, TRUE),
(5, 2, TRUE),
(5, 8, TRUE),
(5, 7, TRUE),
(5, 4, TRUE),
(5, 3, TRUE),
(5, 6, FALSE),
(6, 5, TRUE),
(6, 9, TRUE),
(6, 1, TRUE),
(6, 2, TRUE),
(6, 8, TRUE),
(6, 7, TRUE),
(6, 4, TRUE),
(6, 3, TRUE),
(6, 6, FALSE),
(7, 5, TRUE),
(7, 9, TRUE),
(7, 1, TRUE),
(7, 2, TRUE),
(7, 8, TRUE),
(7, 7, TRUE),
(7, 4, TRUE),
(7, 3, TRUE),
(7, 6, FALSE),
(8, 5, TRUE),
(8, 9, TRUE),
(8, 1, TRUE),
(8, 2, TRUE),
(8, 8, TRUE),
(8, 7, TRUE),
(8, 4, TRUE),
(8, 3, TRUE),
(8, 6, FALSE),
(9, 5, TRUE),
(9, 9, TRUE),
(9, 1, TRUE),
(9, 2, TRUE),
(9, 8, TRUE),
(9, 7, TRUE),
(9, 4, TRUE),
(9, 3, TRUE),
(9, 6, FALSE),
(10, 5, TRUE),
(10, 9, TRUE),
(10, 1, TRUE),
(10, 2, TRUE),
(10, 8, TRUE),
(10, 7, TRUE),
(10, 4, TRUE),
(10, 3, TRUE),
(10, 6, FALSE),
(11, 5, TRUE),
(11, 9, TRUE),
(11, 1, TRUE),
(11, 2, TRUE),
(11, 8, TRUE),
(11, 7, TRUE),
(11, 4, TRUE),
(11, 3, TRUE),
(11, 6, FALSE),
(12, 5, TRUE),
(12, 9, TRUE),
(12, 1, TRUE),
(12, 2, TRUE),
(12, 8, TRUE),
(12, 7, TRUE),
(12, 4, TRUE),
(12, 3, TRUE),
(12, 6, FALSE),
(13, 5, TRUE),
(13, 9, TRUE),
(13, 1, TRUE),
(13, 2, TRUE),
(13, 8, TRUE),
(13, 7, TRUE),
(13, 4, TRUE),
(13, 3, TRUE),
(13, 6, FALSE),
(14, 5, TRUE),
(14, 9, TRUE),
(14, 1, TRUE),
(14, 2, TRUE),
(14, 8, TRUE),
(14, 7, TRUE),
(14, 4, TRUE),
(14, 3, TRUE),
(14, 6, FALSE),
(15, 5, TRUE),
(15, 9, TRUE),
(15, 1, TRUE),
(15, 2, TRUE),
(15, 8, TRUE),
(15, 7, TRUE),
(15, 4, TRUE),
(15, 3, TRUE),
(15, 6, FALSE),
(16, 5, TRUE),
(16, 9, TRUE),
(16, 1, TRUE),
(16, 2, TRUE),
(16, 8, TRUE),
(16, 7, TRUE),
(16, 4, TRUE),
(16, 3, TRUE),
(16, 6, FALSE),
(17, 5, TRUE),
(17, 9, TRUE),
(17, 1, TRUE),
(17, 2, TRUE),
(17, 8, TRUE),
(17, 7, TRUE),
(17, 4, TRUE),
(17, 3, TRUE),
(17, 6, FALSE),
(18, 5, TRUE),
(18, 9, TRUE),
(18, 1, TRUE),
(18, 2, TRUE),
(18, 8, TRUE),
(18, 7, TRUE),
(18, 4, TRUE),
(18, 3, TRUE),
(18, 6, FALSE),
(19, 5, TRUE),
(19, 9, TRUE),
(19, 1, TRUE),
(19, 2, TRUE),
(19, 8, TRUE),
(19, 7, TRUE),
(19, 4, TRUE),
(19, 3, TRUE),
(19, 6, FALSE),
(20, 5, TRUE),
(20, 9, TRUE),
(20, 1, TRUE),
(20, 2, TRUE),
(20, 8, TRUE),
(20, 7, TRUE),
(20, 4, TRUE),
(20, 3, TRUE),
(20, 6, FALSE),
(21, 5, TRUE),
(21, 9, TRUE),
(21, 1, TRUE),
(21, 2, TRUE),
(21, 8, TRUE),
(21, 7, TRUE),
(21, 4, TRUE),
(21, 3, TRUE),
(21, 6, FALSE),
(22, 5, TRUE),
(22, 9, TRUE),
(22, 1, TRUE),
(22, 2, TRUE),
(22, 8, TRUE),
(22, 7, TRUE),
(22, 4, TRUE),
(22, 3, TRUE),
(22, 6, FALSE),
(23, 5, TRUE),
(23, 9, TRUE),
(23, 1, TRUE),
(23, 2, TRUE),
(23, 8, TRUE),
(23, 7, TRUE),
(23, 4, TRUE),
(23, 3, TRUE),
(23, 6, FALSE),
(24, 5, TRUE),
(24, 9, TRUE),
(24, 1, TRUE),
(24, 2, TRUE),
(24, 8, TRUE),
(24, 7, TRUE),
(24, 4, TRUE),
(24, 3, TRUE),
(24, 6, FALSE),
(25, 5, TRUE),
(25, 9, TRUE),
(25, 1, TRUE),
(25, 2, TRUE),
(25, 8, TRUE),
(25, 7, TRUE),
(25, 4, TRUE),
(25, 3, TRUE),
(25, 6, FALSE),
(26, 5, TRUE),
(26, 9, TRUE),
(26, 1, TRUE),
(26, 2, TRUE),
(26, 8, TRUE),
(26, 7, TRUE),
(26, 4, TRUE),
(26, 3, TRUE),
(26, 6, FALSE),
(27, 5, TRUE),
(27, 9, TRUE),
(27, 1, TRUE),
(27, 2, TRUE),
(27, 8, TRUE),
(27, 7, TRUE),
(27, 4, TRUE),
(27, 3, TRUE),
(27, 6, FALSE),
(28, 5, TRUE),
(28, 9, TRUE),
(28, 1, TRUE),
(28, 2, TRUE),
(28, 8, TRUE),
(28, 7, TRUE),
(28, 4, TRUE),
(28, 3, TRUE),
(28, 6, FALSE),
(29, 5, TRUE),
(29, 9, TRUE),
(29, 1, TRUE),
(29, 2, TRUE),
(29, 8, TRUE),
(29, 7, TRUE),
(29, 4, TRUE),
(29, 3, TRUE),
(29, 6, FALSE),
(30, 5, TRUE),
(30, 9, TRUE),
(30, 1, TRUE),
(30, 2, TRUE),
(30, 8, TRUE),
(30, 7, TRUE),
(30, 4, TRUE),
(30, 3, TRUE),
(30, 6, FALSE),
(31, 5, TRUE),
(31, 9, TRUE),
(31, 1, TRUE),
(31, 2, TRUE),
(31, 8, TRUE),
(31, 7, TRUE),
(31, 4, TRUE),
(31, 3, TRUE),
(31, 6, FALSE),
(32, 5, TRUE),
(32, 9, TRUE),
(32, 1, TRUE),
(32, 2, TRUE),
(32, 8, TRUE),
(32, 7, TRUE),
(32, 4, TRUE),
(32, 3, TRUE),
(32, 6, FALSE),
(33, 5, TRUE),
(33, 9, TRUE),
(33, 1, TRUE),
(33, 2, TRUE),
(33, 8, TRUE),
(33, 7, TRUE),
(33, 4, TRUE),
(33, 3, TRUE),
(33, 6, FALSE),
(34, 5, TRUE),
(34, 9, TRUE),
(34, 1, TRUE),
(34, 2, TRUE),
(34, 8, TRUE),
(34, 7, TRUE),
(34, 4, TRUE),
(34, 3, TRUE),
(34, 6, FALSE),
(35, 5, TRUE),
(35, 9, TRUE),
(35, 1, TRUE),
(35, 2, TRUE),
(35, 8, TRUE),
(35, 7, TRUE),
(35, 4, TRUE),
(35, 3, TRUE),
(35, 6, FALSE),
(36, 5, TRUE),
(36, 9, TRUE),
(36, 1, TRUE),
(36, 2, TRUE),
(36, 8, TRUE),
(36, 7, TRUE),
(36, 4, TRUE),
(36, 3, TRUE),
(36, 6, FALSE),
(37, 5, TRUE),
(37, 9, TRUE),
(37, 1, TRUE),
(37, 2, TRUE),
(37, 8, TRUE),
(37, 7, TRUE),
(37, 4, TRUE),
(37, 3, TRUE),
(37, 6, FALSE),
(38, 5, TRUE),
(38, 9, TRUE),
(38, 1, TRUE),
(38, 2, TRUE),
(38, 8, TRUE),
(38, 7, TRUE),
(38, 4, TRUE),
(38, 3, TRUE),
(38, 6, FALSE),
(39, 5, TRUE),
(39, 9, TRUE),
(39, 1, TRUE),
(39, 2, TRUE),
(39, 8, TRUE),
(39, 7, TRUE),
(39, 4, TRUE),
(39, 3, TRUE),
(39, 6, FALSE),
(40, 5, TRUE),
(40, 9, TRUE),
(40, 1, TRUE),
(40, 2, TRUE),
(40, 8, TRUE),
(40, 7, TRUE),
(40, 4, TRUE),
(40, 3, TRUE),
(40, 6, FALSE),
(41, 5, TRUE),
(41, 9, TRUE),
(41, 1, TRUE),
(41, 2, TRUE),
(41, 8, TRUE),
(41, 7, TRUE),
(41, 4, TRUE),
(41, 3, TRUE),
(41, 6, FALSE),
(42, 5, TRUE),
(42, 9, TRUE),
(42, 1, TRUE),
(42, 2, TRUE),
(42, 8, TRUE),
(42, 7, TRUE),
(42, 4, TRUE),
(42, 3, TRUE),
(42, 6, FALSE),
(43, 5, TRUE),
(43, 9, TRUE),
(43, 1, TRUE),
(43, 2, TRUE),
(43, 8, TRUE),
(43, 7, TRUE),
(43, 4, TRUE),
(43, 3, TRUE),
(43, 6, FALSE),
(44, 5, TRUE),
(44, 9, TRUE),
(44, 1, TRUE),
(44, 2, TRUE),
(44, 8, TRUE),
(44, 7, TRUE),
(44, 4, TRUE),
(44, 3, TRUE),
(44, 6, FALSE),
(45, 5, TRUE),
(45, 9, TRUE),
(45, 1, TRUE),
(45, 2, TRUE),
(45, 8, TRUE),
(45, 7, TRUE),
(45, 4, TRUE),
(45, 3, TRUE),
(45, 6, FALSE),
(46, 5, TRUE),
(46, 9, TRUE),
(46, 1, TRUE),
(46, 2, TRUE),
(46, 8, TRUE),
(46, 7, TRUE),
(46, 4, TRUE),
(46, 3, TRUE),
(46, 6, FALSE),
(47, 5, TRUE),
(47, 9, TRUE),
(47, 1, TRUE),
(47, 2, TRUE),
(47, 8, TRUE),
(47, 7, TRUE),
(47, 4, TRUE),
(47, 3, TRUE),
(47, 6, FALSE),
(48, 5, TRUE),
(48, 9, TRUE),
(48, 1, TRUE),
(48, 2, TRUE),
(48, 8, TRUE),
(48, 7, TRUE),
(48, 4, TRUE),
(48, 3, TRUE),
(48, 6, FALSE),
(49, 5, TRUE),
(49, 9, TRUE),
(49, 1, TRUE),
(49, 2, TRUE),
(49, 8, TRUE),
(49, 7, TRUE),
(49, 4, TRUE),
(49, 3, TRUE),
(49, 6, FALSE),
(50, 5, TRUE),
(50, 9, TRUE),
(50, 1, TRUE),
(50, 2, TRUE),
(50, 8, TRUE),
(50, 7, TRUE),
(50, 4, TRUE),
(50, 3, TRUE),
(50, 6, FALSE),
(51, 5, TRUE),
(51, 9, TRUE),
(51, 1, TRUE),
(51, 2, TRUE),
(51, 8, TRUE),
(51, 7, TRUE),
(51, 4, TRUE),
(51, 3, TRUE),
(51, 6, FALSE),
(52, 5, TRUE),
(52, 9, TRUE),
(52, 1, TRUE),
(52, 2, TRUE),
(52, 8, TRUE),
(52, 7, TRUE),
(52, 4, TRUE),
(52, 3, TRUE),
(52, 6, FALSE),
(53, 5, TRUE),
(53, 9, TRUE),
(53, 1, TRUE),
(53, 2, TRUE),
(53, 8, TRUE),
(53, 7, TRUE),
(53, 4, TRUE),
(53, 3, TRUE),
(53, 6, FALSE),
(54, 5, TRUE),
(54, 9, TRUE),
(54, 1, TRUE),
(54, 2, TRUE),
(54, 8, TRUE),
(54, 7, TRUE),
(54, 4, TRUE),
(54, 3, TRUE),
(54, 6, FALSE),
(55, 5, TRUE),
(55, 9, TRUE),
(55, 1, TRUE),
(55, 2, TRUE),
(55, 8, TRUE),
(55, 7, TRUE),
(55, 4, TRUE),
(55, 3, TRUE),
(55, 6, FALSE),
(56, 5, TRUE),
(56, 9, TRUE),
(56, 1, TRUE),
(56, 2, TRUE),
(56, 8, TRUE),
(56, 7, TRUE),
(56, 4, TRUE),
(56, 3, TRUE),
(56, 6, FALSE),
(57, 5, TRUE),
(57, 9, TRUE),
(57, 1, TRUE),
(57, 2, TRUE),
(57, 8, TRUE),
(57, 7, TRUE),
(57, 4, TRUE),
(57, 3, TRUE),
(57, 6, FALSE),
(58, 5, TRUE),
(58, 9, TRUE),
(58, 1, TRUE),
(58, 2, TRUE),
(58, 8, TRUE),
(58, 7, TRUE),
(58, 4, TRUE),
(58, 3, TRUE),
(58, 6, FALSE),
(59, 5, TRUE),
(59, 9, TRUE),
(59, 1, TRUE),
(59, 2, TRUE),
(59, 8, TRUE),
(59, 7, TRUE),
(59, 4, TRUE),
(59, 3, TRUE),
(59, 6, FALSE),
(60, 5, TRUE),
(60, 9, TRUE),
(60, 1, TRUE),
(60, 2, TRUE),
(60, 8, TRUE),
(60, 7, TRUE),
(60, 4, TRUE),
(60, 3, TRUE),
(60, 6, FALSE),
(61, 5, TRUE),
(61, 9, TRUE),
(61, 1, TRUE),
(61, 2, TRUE),
(61, 8, TRUE),
(61, 7, TRUE),
(61, 4, TRUE),
(61, 3, TRUE),
(61, 6, FALSE),
(62, 5, TRUE),
(62, 9, TRUE),
(62, 1, TRUE),
(62, 2, TRUE),
(62, 8, TRUE),
(62, 7, TRUE),
(62, 4, TRUE),
(62, 3, TRUE),
(62, 6, FALSE),
(63, 5, TRUE),
(63, 9, TRUE),
(63, 1, TRUE),
(63, 2, TRUE),
(63, 8, TRUE),
(63, 7, TRUE),
(63, 4, TRUE),
(63, 3, TRUE),
(63, 6, FALSE),
(64, 5, TRUE),
(64, 9, TRUE),
(64, 1, TRUE),
(64, 2, TRUE),
(64, 8, TRUE),
(64, 7, TRUE),
(64, 4, TRUE),
(64, 3, TRUE),
(64, 6, FALSE),
(65, 5, TRUE),
(65, 9, TRUE),
(65, 1, TRUE),
(65, 2, TRUE),
(65, 8, TRUE),
(65, 7, TRUE),
(65, 4, TRUE),
(65, 3, TRUE),
(65, 6, FALSE),
(66, 5, TRUE),
(66, 9, TRUE),
(66, 1, TRUE),
(66, 2, TRUE),
(66, 8, TRUE),
(66, 7, TRUE),
(66, 4, TRUE),
(66, 3, TRUE),
(66, 6, FALSE),
(67, 5, TRUE),
(67, 9, TRUE),
(67, 1, TRUE),
(67, 2, TRUE),
(67, 8, TRUE),
(67, 7, TRUE),
(67, 4, TRUE),
(67, 3, TRUE),
(67, 6, FALSE),
(68, 5, TRUE),
(68, 9, TRUE),
(68, 1, TRUE),
(68, 2, TRUE),
(68, 8, TRUE),
(68, 7, TRUE),
(68, 4, TRUE),
(68, 3, TRUE),
(68, 6, FALSE),
(69, 5, TRUE),
(69, 9, TRUE),
(69, 1, TRUE),
(69, 2, TRUE),
(69, 8, TRUE),
(69, 7, TRUE),
(69, 4, TRUE),
(69, 3, TRUE),
(69, 6, FALSE),
(70, 5, TRUE),
(70, 9, TRUE),
(70, 1, TRUE),
(70, 2, TRUE),
(70, 8, TRUE),
(70, 7, TRUE),
(70, 4, TRUE),
(70, 3, TRUE),
(70, 6, FALSE),
(71, 5, TRUE),
(71, 9, TRUE),
(71, 1, TRUE),
(71, 2, TRUE),
(71, 8, TRUE),
(71, 7, TRUE),
(71, 4, TRUE),
(71, 3, TRUE),
(71, 6, FALSE),
(72, 5, TRUE),
(72, 9, TRUE),
(72, 1, TRUE),
(72, 2, TRUE),
(72, 8, TRUE),
(72, 7, TRUE),
(72, 4, TRUE),
(72, 3, TRUE),
(72, 6, FALSE),
(73, 5, TRUE),
(73, 9, TRUE),
(73, 1, TRUE),
(73, 2, TRUE),
(73, 8, TRUE),
(73, 7, TRUE),
(73, 4, TRUE),
(73, 3, TRUE),
(73, 6, FALSE),
(74, 5, TRUE),
(74, 9, TRUE),
(74, 1, TRUE),
(74, 2, TRUE),
(74, 8, TRUE),
(74, 7, TRUE),
(74, 4, TRUE),
(74, 3, TRUE),
(74, 6, FALSE),
(75, 5, TRUE),
(75, 9, TRUE),
(75, 1, TRUE),
(75, 2, TRUE),
(75, 8, TRUE),
(75, 7, TRUE),
(75, 4, TRUE),
(75, 3, TRUE),
(75, 6, FALSE),
(76, 5, TRUE),
(76, 9, TRUE),
(76, 1, TRUE),
(76, 2, TRUE),
(76, 8, TRUE),
(76, 7, TRUE),
(76, 4, TRUE),
(76, 3, TRUE),
(76, 6, FALSE),
(77, 5, TRUE),
(77, 9, TRUE),
(77, 1, TRUE),
(77, 2, TRUE),
(77, 8, TRUE),
(77, 7, TRUE),
(77, 4, TRUE),
(77, 3, TRUE),
(77, 6, FALSE),
(78, 5, TRUE),
(78, 9, TRUE),
(78, 1, TRUE),
(78, 2, TRUE),
(78, 8, TRUE),
(78, 7, TRUE),
(78, 4, TRUE),
(78, 3, TRUE),
(78, 6, FALSE),
(79, 5, TRUE),
(79, 9, TRUE),
(79, 1, TRUE),
(79, 2, TRUE),
(79, 8, TRUE),
(79, 7, TRUE),
(79, 4, TRUE),
(79, 3, TRUE),
(79, 6, FALSE),
(80, 5, TRUE),
(80, 9, TRUE),
(80, 1, TRUE),
(80, 2, TRUE),
(80, 8, TRUE),
(80, 7, TRUE),
(80, 4, TRUE),
(80, 3, TRUE),
(80, 6, FALSE),
(81, 5, TRUE),
(81, 9, TRUE),
(81, 1, TRUE),
(81, 2, TRUE),
(81, 8, TRUE),
(81, 7, TRUE),
(81, 4, TRUE),
(81, 3, TRUE),
(81, 6, FALSE),
(82, 5, TRUE),
(82, 9, TRUE),
(82, 1, TRUE),
(82, 2, TRUE),
(82, 8, TRUE),
(82, 7, TRUE),
(82, 4, TRUE),
(82, 3, TRUE),
(82, 6, FALSE),
(83, 5, TRUE),
(83, 9, TRUE),
(83, 1, TRUE),
(83, 2, TRUE),
(83, 8, TRUE),
(83, 7, TRUE),
(83, 4, TRUE),
(83, 3, TRUE),
(83, 6, FALSE),
(84, 5, TRUE),
(84, 9, TRUE),
(84, 1, TRUE),
(84, 2, TRUE),
(84, 8, TRUE),
(84, 7, TRUE),
(84, 4, TRUE),
(84, 3, TRUE),
(84, 6, FALSE),
(85, 5, TRUE),
(85, 9, TRUE),
(85, 1, TRUE),
(85, 2, TRUE),
(85, 8, TRUE),
(85, 7, TRUE),
(85, 4, TRUE),
(85, 3, TRUE),
(85, 6, FALSE);

/* #endregion */

/* #region Kindergarten facilities */


INSERT INTO kindergarten_facilities (kindergarten_id, facility_id, is_available) VALUES
(1, 2, TRUE),
(1, 3, TRUE),
(1, 1, TRUE),
(2, 2, TRUE),
(2, 3, TRUE),
(2, 1, TRUE),
(3, 2, TRUE),
(3, 3, TRUE),
(3, 1, TRUE),
(4, 2, TRUE),
(4, 3, TRUE),
(4, 1, TRUE),
(5, 2, TRUE),
(5, 3, TRUE),
(5, 1, TRUE),
(6, 2, TRUE),
(6, 3, TRUE),
(6, 1, TRUE),
(7, 2, TRUE),
(7, 3, TRUE),
(7, 1, TRUE),
(8, 2, TRUE),
(8, 3, TRUE),
(8, 1, TRUE),
(9, 2, TRUE),
(9, 3, TRUE),
(9, 1, TRUE),
(10, 2, TRUE),
(10, 3, TRUE),
(10, 1, TRUE),
(11, 2, TRUE),
(11, 3, TRUE),
(11, 1, TRUE),
(12, 2, TRUE),
(12, 3, TRUE),
(12, 1, TRUE),
(13, 2, TRUE),
(13, 3, TRUE),
(13, 1, TRUE),
(14, 2, TRUE),
(14, 3, TRUE),
(14, 1, TRUE),
(15, 2, TRUE),
(15, 3, TRUE),
(15, 1, TRUE),
(16, 2, TRUE),
(16, 3, TRUE),
(16, 1, TRUE),
(17, 2, TRUE),
(17, 3, TRUE),
(17, 1, TRUE),
(18, 2, TRUE),
(18, 3, TRUE),
(18, 1, TRUE),
(19, 2, TRUE),
(19, 3, TRUE),
(19, 1, TRUE),
(20, 2, TRUE),
(20, 3, TRUE),
(20, 1, TRUE),
(21, 2, TRUE),
(21, 3, TRUE),
(21, 1, TRUE),
(22, 2, TRUE),
(22, 3, TRUE),
(22, 1, TRUE),
(23, 2, TRUE),
(23, 3, TRUE),
(23, 1, TRUE),
(24, 2, TRUE),
(24, 3, TRUE),
(24, 1, TRUE),
(25, 2, TRUE),
(25, 3, TRUE),
(25, 1, TRUE),
(26, 2, TRUE),
(26, 3, TRUE),
(26, 1, TRUE),
(27, 2, TRUE),
(27, 3, TRUE),
(27, 1, TRUE),
(28, 2, TRUE),
(28, 3, TRUE),
(28, 1, TRUE),
(29, 2, TRUE),
(29, 3, TRUE),
(29, 1, TRUE),
(30, 2, TRUE),
(30, 3, TRUE),
(30, 1, TRUE),
(31, 2, TRUE),
(31, 3, TRUE),
(31, 1, TRUE),
(32, 2, TRUE),
(32, 3, TRUE),
(32, 1, TRUE),
(33, 2, TRUE),
(33, 3, TRUE),
(33, 1, TRUE),
(34, 2, TRUE),
(34, 3, TRUE),
(34, 1, TRUE),
(35, 2, TRUE),
(35, 3, TRUE),
(35, 1, TRUE),
(36, 2, TRUE),
(36, 3, TRUE),
(36, 1, TRUE),
(37, 2, TRUE),
(37, 3, TRUE),
(37, 1, TRUE),
(38, 2, TRUE),
(38, 3, TRUE),
(38, 1, TRUE),
(39, 2, TRUE),
(39, 3, TRUE),
(39, 1, TRUE),
(40, 2, TRUE),
(40, 3, TRUE),
(40, 1, TRUE),
(41, 2, TRUE),
(41, 3, TRUE),
(41, 1, TRUE),
(42, 2, TRUE),
(42, 3, TRUE),
(42, 1, TRUE),
(43, 2, TRUE),
(43, 3, TRUE),
(43, 1, TRUE),
(44, 2, TRUE),
(44, 3, TRUE),
(44, 1, TRUE),
(45, 2, TRUE),
(45, 3, TRUE),
(45, 1, TRUE),
(46, 2, TRUE),
(46, 3, TRUE),
(46, 1, TRUE),
(47, 2, TRUE),
(47, 3, TRUE),
(47, 1, TRUE),
(48, 2, TRUE),
(48, 3, TRUE),
(48, 1, TRUE),
(49, 2, TRUE),
(49, 3, TRUE),
(49, 1, TRUE),
(50, 2, TRUE),
(50, 3, TRUE),
(50, 1, TRUE),
(51, 2, TRUE),
(51, 3, TRUE),
(51, 1, TRUE),
(52, 2, TRUE),
(52, 3, TRUE),
(52, 1, TRUE),
(53, 2, TRUE),
(53, 3, TRUE),
(53, 1, TRUE),
(54, 2, TRUE),
(54, 3, TRUE),
(54, 1, TRUE),
(55, 2, TRUE),
(55, 3, TRUE),
(55, 1, TRUE),
(56, 2, TRUE),
(56, 3, TRUE),
(56, 1, TRUE),
(57, 2, TRUE),
(57, 3, TRUE),
(57, 1, TRUE),
(58, 2, TRUE),
(58, 3, TRUE),
(58, 1, TRUE),
(59, 2, TRUE),
(59, 3, TRUE),
(59, 1, TRUE),
(60, 2, TRUE),
(60, 3, TRUE),
(60, 1, TRUE),
(61, 2, TRUE),
(61, 3, TRUE),
(61, 1, TRUE),
(62, 2, TRUE),
(62, 3, TRUE),
(62, 1, TRUE),
(63, 2, TRUE),
(63, 3, TRUE),
(63, 1, TRUE),
(64, 2, TRUE),
(64, 3, TRUE),
(64, 1, TRUE),
(65, 2, TRUE),
(65, 3, TRUE),
(65, 1, TRUE),
(66, 2, TRUE),
(66, 3, TRUE),
(66, 1, TRUE),
(67, 2, TRUE),
(67, 3, TRUE),
(67, 1, TRUE),
(68, 2, TRUE),
(68, 3, TRUE),
(68, 1, TRUE),
(69, 2, TRUE),
(69, 3, TRUE),
(69, 1, TRUE),
(70, 2, TRUE),
(70, 3, TRUE),
(70, 1, TRUE),
(71, 2, TRUE),
(71, 3, TRUE),
(71, 1, TRUE),
(72, 2, TRUE),
(72, 3, TRUE),
(72, 1, TRUE),
(73, 2, TRUE),
(73, 3, TRUE),
(73, 1, TRUE),
(74, 2, TRUE),
(74, 3, TRUE),
(74, 1, TRUE),
(75, 2, TRUE),
(75, 3, TRUE),
(75, 1, TRUE),
(76, 2, TRUE),
(76, 3, TRUE),
(76, 1, TRUE),
(77, 2, TRUE),
(77, 3, TRUE),
(77, 1, TRUE),
(78, 2, TRUE),
(78, 3, TRUE),
(78, 1, TRUE),
(79, 2, TRUE),
(79, 3, TRUE),
(79, 1, TRUE),
(80, 2, TRUE),
(80, 3, TRUE),
(80, 1, TRUE),
(81, 2, TRUE),
(81, 3, TRUE),
(81, 1, TRUE),
(82, 2, TRUE),
(82, 3, TRUE),
(82, 1, TRUE),
(83, 2, TRUE),
(83, 3, TRUE),
(83, 1, TRUE),
(84, 2, TRUE),
(84, 3, TRUE),
(84, 1, TRUE),
(85, 2, TRUE),
(85, 3, TRUE),
(85, 1, TRUE);

/* #endregion */

/* #endregion */





/* #region Update to tables or data */

Select image_path, id, name from kindergartens;


UPDATE kindergartens 
SET image_path = 'images/reykjavik/Laufasborg.jpg'
WHERE id = '45';

-- Before update:
SELECT * FROM kindergartens WHERE id = '45';

-- After update:
SELECT * FROM kindergartens WHERE id = '45';

/* #region Update activities */
--randomize activities #thankthemakersforpythonandpythonbeingstupidlysimple

UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 1 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 1 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 1 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 1 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 1 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 1 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 1 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 1 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 1 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 2 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 2 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 2 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 2 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 2 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 2 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 2 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 2 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 2 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 3 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 3 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 3 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 3 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 3 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 3 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 3 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 3 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 3 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 4 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 4 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 4 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 4 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 4 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 4 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 4 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 4 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 4 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 5 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 5 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 5 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 5 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 5 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 5 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 5 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 5 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 5 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 6 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 6 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 6 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 6 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 6 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 6 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 6 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 6 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 6 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 7 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 7 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 7 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 7 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 7 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 7 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 7 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 7 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 7 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 8 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 8 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 8 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 8 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 8 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 8 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 8 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 8 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 8 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 9 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 9 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 9 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 9 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 9 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 9 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 9 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 9 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 9 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 10 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 10 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 10 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 10 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 10 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 10 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 10 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 10 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 10 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 11 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 11 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 11 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 11 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 11 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 11 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 11 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 11 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 11 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 12 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 12 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 12 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 12 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 12 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 12 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 12 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 12 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 12 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 13 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 13 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 13 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 13 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 13 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 13 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 13 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 13 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 13 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 14 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 14 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 14 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 14 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 14 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 14 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 14 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 14 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 14 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 15 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 15 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 15 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 15 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 15 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 15 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 15 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 15 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 15 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 16 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 16 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 16 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 16 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 16 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 16 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 16 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 16 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 16 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 17 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 17 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 17 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 17 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 17 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 17 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 17 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 17 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 17 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 18 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 18 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 18 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 18 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 18 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 18 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 18 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 18 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 18 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 19 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 19 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 19 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 19 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 19 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 19 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 19 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 19 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 19 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 20 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 20 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 20 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 20 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 20 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 20 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 20 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 20 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 20 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 21 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 21 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 21 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 21 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 21 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 21 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 21 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 21 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 21 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 22 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 22 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 22 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 22 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 22 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 22 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 22 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 22 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 22 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 23 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 23 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 23 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 23 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 23 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 23 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 23 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 23 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 23 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 24 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 24 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 24 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 24 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 24 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 24 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 24 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 24 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 24 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 25 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 25 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 25 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 25 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 25 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 25 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 25 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 25 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 25 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 26 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 26 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 26 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 26 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 26 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 26 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 26 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 26 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 26 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 27 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 27 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 27 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 27 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 27 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 27 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 27 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 27 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 27 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 28 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 28 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 28 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 28 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 28 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 28 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 28 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 28 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 28 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 29 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 29 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 29 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 29 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 29 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 29 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 29 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 29 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 29 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 30 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 30 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 30 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 30 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 30 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 30 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 30 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 30 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 30 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 31 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 31 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 31 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 31 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 31 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 31 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 31 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 31 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 31 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 32 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 32 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 32 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 32 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 32 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 32 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 32 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 32 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 32 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 33 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 33 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 33 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 33 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 33 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 33 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 33 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 33 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 33 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 34 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 34 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 34 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 34 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 34 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 34 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 34 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 34 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 34 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 35 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 35 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 35 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 35 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 35 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 35 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 35 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 35 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 35 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 36 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 36 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 36 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 36 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 36 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 36 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 36 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 36 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 36 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 37 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 37 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 37 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 37 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 37 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 37 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 37 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 37 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 37 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 38 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 38 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 38 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 38 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 38 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 38 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 38 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 38 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 38 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 39 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 39 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 39 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 39 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 39 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 39 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 39 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 39 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 39 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 40 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 40 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 40 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 40 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 40 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 40 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 40 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 40 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 40 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 41 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 41 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 41 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 41 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 41 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 41 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 41 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 41 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 41 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 42 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 42 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 42 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 42 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 42 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 42 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 42 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 42 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 42 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 43 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 43 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 43 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 43 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 43 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 43 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 43 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 43 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 43 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 44 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 44 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 44 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 44 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 44 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 44 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 44 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 44 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 44 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 45 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 45 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 45 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 45 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 45 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 45 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 45 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 45 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 45 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 46 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 46 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 46 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 46 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 46 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 46 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 46 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 46 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 46 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 47 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 47 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 47 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 47 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 47 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 47 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 47 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 47 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 47 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 48 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 48 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 48 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 48 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 48 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 48 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 48 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 48 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 48 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 49 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 49 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 49 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 49 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 49 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 49 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 49 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 49 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 49 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 50 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 50 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 50 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 50 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 50 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 50 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 50 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 50 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 50 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 51 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 51 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 51 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 51 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 51 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 51 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 51 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 51 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 51 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 52 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 52 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 52 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 52 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 52 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 52 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 52 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 52 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 52 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 53 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 53 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 53 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 53 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 53 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 53 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 53 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 53 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 53 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 54 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 54 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 54 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 54 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 54 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 54 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 54 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 54 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 54 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 55 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 55 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 55 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 55 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 55 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 55 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 55 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 55 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 55 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 56 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 56 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 56 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 56 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 56 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 56 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 56 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 56 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 56 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 57 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 57 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 57 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 57 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 57 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 57 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 57 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 57 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 57 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 58 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 58 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 58 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 58 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 58 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 58 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 58 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 58 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 58 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 59 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 59 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 59 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 59 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 59 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 59 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 59 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 59 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 59 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 60 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 60 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 60 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 60 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 60 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 60 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 60 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 60 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 60 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 61 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 61 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 61 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 61 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 61 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 61 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 61 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 61 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 61 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 62 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 62 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 62 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 62 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 62 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 62 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 62 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 62 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 62 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 63 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 63 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 63 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 63 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 63 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 63 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 63 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 63 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 63 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 64 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 64 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 64 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 64 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 64 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 64 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 64 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 64 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 64 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 65 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 65 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 65 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 65 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 65 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 65 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 65 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 65 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 65 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 66 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 66 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 66 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 66 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 66 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 66 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 66 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 66 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 66 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 67 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 67 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 67 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 67 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 67 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 67 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 67 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 67 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 67 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 68 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 68 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 68 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 68 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 68 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 68 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 68 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 68 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 68 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 69 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 69 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 69 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 69 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 69 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 69 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 69 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 69 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 69 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 70 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 70 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 70 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 70 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 70 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 70 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 70 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 70 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 70 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 71 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 71 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 71 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 71 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 71 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 71 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 71 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 71 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 71 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 72 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 72 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 72 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 72 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 72 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 72 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 72 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 72 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 72 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 73 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 73 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 73 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 73 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 73 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 73 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 73 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 73 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 73 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 74 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 74 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 74 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 74 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 74 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 74 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 74 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 74 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 74 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 75 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 75 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 75 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 75 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 75 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 75 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 75 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 75 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 75 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 76 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 76 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 76 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 76 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 76 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 76 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 76 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 76 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 76 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 77 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 77 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 77 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 77 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 77 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 77 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 77 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 77 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 77 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 78 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 78 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 78 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 78 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 78 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 78 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 78 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 78 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 78 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 79 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 79 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 79 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 79 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 79 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 79 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 79 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 79 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 79 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 80 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 80 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 80 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 80 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 80 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 80 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 80 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 80 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 80 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 81 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 81 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 81 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 81 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 81 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 81 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 81 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 81 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 81 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 82 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 82 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 82 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 82 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 82 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 82 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 82 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 82 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 82 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 83 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 83 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 83 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 83 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 83 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 83 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 83 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 83 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 83 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 84 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 84 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 84 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 84 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 84 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 84 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 84 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 84 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 84 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 85 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 85 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 85 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 85 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 85 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 85 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 85 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 85 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 85 AND activity_id = 6;




UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 86 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 86 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 86 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 86 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 86 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 86 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 86 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 86 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 86 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 87 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 87 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 87 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 87 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 87 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 87 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 87 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 87 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 87 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 88 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 88 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 88 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 88 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 88 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 88 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 88 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 88 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 88 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 106 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 106 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 106 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 106 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 106 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 90 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 90 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 90 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 90 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 90 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 90 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 90 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 90 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 90 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 91 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 91 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 91 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 91 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 91 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 91 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 91 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 91 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 91 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 92 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 92 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 92 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 92 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 92 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 92 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 92 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 92 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 92 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 93 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 93 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 93 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 93 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 93 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 93 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 93 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 93 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 93 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 94 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 94 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 94 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 94 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 94 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 94 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 94 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 94 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 94 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 95 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 95 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 95 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 95 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 95 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 95 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 95 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 95 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 95 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 96 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 96 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 96 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 96 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 96 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 96 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 96 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 96 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 96 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 97 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 97 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 97 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 97 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 97 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 97 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 97 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 97 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 97 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 98 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 98 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 98 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 98 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 98 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 98 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 98 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 98 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 98 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 99 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 99 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 99 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 99 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 99 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 99 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 99 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 99 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 99 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 100 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 100 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 100 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 100 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 100 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 100 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 100 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 100 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 100 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 101 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 101 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 101 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 101 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 101 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 101 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 101 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 101 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 101 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 102 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 102 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 102 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 102 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 102 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 102 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 102 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 102 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 102 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 106 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 106 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 106 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 104 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 104 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 104 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 104 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 104 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 104 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 104 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 104 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 104 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 105 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 105 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 105 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 105 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 105 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 105 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 105 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 105 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 105 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 106 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 106 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 107 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 107 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 107 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 107 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 107 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 107 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 107 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 107 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 107 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 108 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 108 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 108 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 108 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 108 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 108 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 108 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 108 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 108 AND activity_id = 6;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 109 AND activity_id = 5;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 109 AND activity_id = 9;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 109 AND activity_id = 1;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 109 AND activity_id = 2;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 109 AND activity_id = 8;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 109 AND activity_id = 7;
UPDATE kindergarten_activities SET is_available = TRUE WHERE kindergarten_id = 109 AND activity_id = 4;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 109 AND activity_id = 3;
UPDATE kindergarten_activities SET is_available = FALSE WHERE kindergarten_id = 109 AND activity_id = 6;



UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 86 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 86 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 86 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 87 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 87 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 87 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 88 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 88 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 88 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 106 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 106 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 106 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 90 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 90 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 90 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 91 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 91 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 91 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 92 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 92 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 92 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 93 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 93 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 93 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 94 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 94 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 94 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 95 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 95 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 95 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 96 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 96 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 96 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 97 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 97 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 97 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 98 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 98 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 98 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 99 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 99 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 99 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 100 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 100 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 100 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 101 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 101 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 101 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 102 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 102 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 102 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 106 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 106 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 106 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 104 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 104 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 104 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 105 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 105 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 105 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 106 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 106 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 106 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 107 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 107 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 107 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 108 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 108 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 108 AND facility_id = 1;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 109 AND facility_id = 2;
UPDATE kindergarten_facilities SET is_available = TRUE WHERE kindergarten_id = 109 AND facility_id = 3;
UPDATE kindergarten_facilities SET is_available = FALSE WHERE kindergarten_id = 109 AND facility_id = 1;

INSERT INTO kindergarten_facilities (kindergarten_id, facility_id, is_available) VALUES 
(86, 2, TRUE),
(86, 3, FALSE),
(86, 1, TRUE),
(87, 2, TRUE),
(87, 3, TRUE),
(87, 1, FALSE),
(88, 2, TRUE),
(88, 3, FALSE),
(88, 1, FALSE),
(106, 2, TRUE),
(106, 3, FALSE),
(106, 1, TRUE),
(90, 2, TRUE),
(90, 3, TRUE),
(90, 1, TRUE),
(91, 2, FALSE),
(91, 3, TRUE),
(91, 1, TRUE),
(92, 2, TRUE),
(92, 3, TRUE),
(92, 1, TRUE),
(93, 2, FALSE),
(93, 3, FALSE),
(93, 1, FALSE),
(94, 2, TRUE),
(94, 3, FALSE),
(94, 1, FALSE),
(95, 2, TRUE),
(95, 3, FALSE),
(95, 1, FALSE),
(96, 2, FALSE),
(96, 3, TRUE),
(96, 1, FALSE),
(97, 2, FALSE),
(97, 3, FALSE),
(97, 1, TRUE),
(98, 2, TRUE),
(98, 3, FALSE),
(98, 1, TRUE),
(99, 2, TRUE),
(99, 3, FALSE),
(99, 1, TRUE),
(100, 2, TRUE),
(100, 3, TRUE),
(100, 1, TRUE),
(101, 2, FALSE),
(101, 3, TRUE),
(101, 1, FALSE),
(102, 2, FALSE),
(102, 3, TRUE),
(102, 1, TRUE),
(104, 2, TRUE),
(104, 3, FALSE),
(104, 1, FALSE),
(105, 2, FALSE),
(105, 3, TRUE),
(105, 1, TRUE),
(107, 2, TRUE),
(107, 3, FALSE),
(107, 1, TRUE),
(108, 2, FALSE),
(108, 3, TRUE),
(108, 1, FALSE),
(109, 2, TRUE),
(109, 3, TRUE),
(109, 1, FALSE)
ON CONFLICT (kindergarten_id, facility_id) 
DO UPDATE SET is_available = EXCLUDED.is_available;


INSERT INTO kindergarten_facilities (kindergarten_id, facility_id, is_available) VALUES 


INSERT INTO kindergarten_activities (kindergarten_id, activity_id, is_available) VALUES 
(86, 5, FALSE),
(86, 9, FALSE),
(86, 1, TRUE),
(86, 2, TRUE),
(86, 8, TRUE),
(86, 7, FALSE),
(86, 4, FALSE),
(86, 3, TRUE),
(86, 6, FALSE),
(87, 5, FALSE),
(87, 9, FALSE),
(87, 1, TRUE),
(87, 2, TRUE),
(87, 8, TRUE),
(87, 7, FALSE),
(87, 4, FALSE),
(87, 3, TRUE),
(87, 6, FALSE),
(88, 5, TRUE),
(88, 9, FALSE),
(88, 1, FALSE),
(88, 2, FALSE),
(88, 8, FALSE),
(88, 7, FALSE),
(88, 4, TRUE),
(88, 3, FALSE),
(88, 6, FALSE),
(106, 5, FALSE),
(106, 9, TRUE),
(106, 1, TRUE),
(106, 2, FALSE),
(106, 8, TRUE),
(106, 7, TRUE),
(106, 4, TRUE),
(106, 3, FALSE),
(106, 6, FALSE),
(90, 5, TRUE),
(90, 9, TRUE),
(90, 1, TRUE),
(90, 2, TRUE),
(90, 8, TRUE),
(90, 7, TRUE),
(90, 4, FALSE),
(90, 3, TRUE),
(90, 6, FALSE),
(91, 5, FALSE),
(91, 9, FALSE),
(91, 1, FALSE),
(91, 2, TRUE),
(91, 8, FALSE),
(91, 7, TRUE),
(91, 4, TRUE),
(91, 3, FALSE),
(91, 6, FALSE),
(92, 5, TRUE),
(92, 9, FALSE),
(92, 1, FALSE),
(92, 2, TRUE),
(92, 8, FALSE),
(92, 7, FALSE),
(92, 4, FALSE),
(92, 3, FALSE),
(92, 6, FALSE),
(93, 5, TRUE),
(93, 9, TRUE),
(93, 1, TRUE),
(93, 2, FALSE),
(93, 8, TRUE),
(93, 7, TRUE),
(93, 4, TRUE),
(93, 3, TRUE),
(93, 6, FALSE)
ON CONFLICT (kindergarten_id, activity_id) 
DO UPDATE SET is_available = EXCLUDED.is_available;

INSERT INTO kindergarten_activities (kindergarten_id, activity_id, is_available) VALUES 


SELECT * 
FROM kindergartens 
WHERE id IN (86, 87, 88, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 104, 105, 106, 107, 108, 109);


INSERT INTO kindergarten_facilities (kindergarten_id, facility_id, is_available) 
VALUES 
(86, 2, TRUE),
(86, 3, FALSE),
(86, 1, TRUE),
(87, 2, TRUE),
(87, 3, TRUE),
(87, 1, FALSE),
(88, 2, TRUE),
(88, 3, FALSE),
(88, 1, FALSE),
(106, 2, TRUE),
(106, 3, FALSE),
(106, 1, TRUE),
(90, 2, TRUE),
(90, 3, TRUE),
(90, 1, TRUE),
(91, 2, FALSE),
(91, 3, TRUE),
(91, 1, TRUE),
(92, 2, TRUE),
(92, 3, TRUE),
(92, 1, TRUE),
(93, 2, FALSE),
(93, 3, FALSE),
(93, 1, FALSE),
(94, 2, TRUE),
(94, 3, FALSE),
(94, 1, FALSE),
(95, 2, TRUE),
(95, 3, FALSE),
(95, 1, FALSE),
(96, 2, FALSE),
(96, 3, TRUE),
(96, 1, FALSE),
(97, 2, FALSE),
(97, 3, FALSE),
(97, 1, TRUE),
(98, 2, TRUE),
(98, 3, FALSE),
(98, 1, TRUE),
(99, 2, TRUE),
(99, 3, FALSE),
(99, 1, TRUE),
(100, 2, TRUE),
(100, 3, TRUE),
(100, 1, TRUE),
(101, 2, FALSE),
(101, 3, TRUE),
(101, 1, FALSE),
(102, 2, FALSE),
(102, 3, TRUE),
(102, 1, TRUE),
(104, 2, TRUE),
(104, 3, FALSE),
(104, 1, FALSE),
(105, 2, FALSE),
(105, 3, TRUE),
(105, 1, TRUE),
(107, 2, TRUE),
(107, 3, FALSE),
(107, 1, TRUE),
(108, 2, FALSE),
(108, 3, TRUE),
(108, 1, FALSE),
(109, 2, TRUE),
(109, 3, TRUE),
(109, 1, FALSE);





SELECT kindergarten_id
FROM kindergarten_activities
WHERE activity_id = 3 AND is_available = TRUE;

SELECT 
    kindergarten_activities.kindergarten_id,
    kindergarten_activities.activity_id,
    kindergarten_activities.is_available,
    activities.id AS activity_id_in_activities,
    activities.activity_name
FROM 
    kindergarten_activities
JOIN 
    activities ON kindergarten_activities.activity_id = activities.id


/* #endregion */

/* #endregion */