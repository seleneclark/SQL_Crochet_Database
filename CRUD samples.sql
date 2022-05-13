-- use crochet_dev;

-- website ----------------------------------------------------------------
-- C 
INSERT INTO `website`
(`web_address`,
`author`)
VALUES
('www.crochetdesigns.org'
	, 'Jen Hunter')
;
INSERT INTO `website`
(`web_address`,
`author`)
VALUES
('www.morecrochetdesigns.org'
	, 'Heidi Gates');
INSERT INTO `website`
(`web_address`,
`author`)
VALUES
('www.starwarscrochet.org'
	, 'Disney Co');
-- R
SELECT `idwebsite`
FROM `website`
WHERE web_address = 'www.starwarscrochet.org' ;

-- U
UPDATE `website`
SET
`author` = 'Jennifer Hunter'
WHERE `idwebsite` = 1;
-- D
DELETE FROM `website`
WHERE `idwebsite` = 2;


-- book ----------------------------------------------------------------
-- C 
INSERT INTO `book`
(`title`,
`author`,
`publisher`)
VALUES
('Adorable Crochet Animals',
'Phoenix McGinty',
'Randomhouse');
INSERT INTO `book`
(`title`,
`author`,
`publisher`)
VALUES
('Tiny Crachet Animals',
'Lois McGinty',
'O\'Reilly');
INSERT INTO `book`
(`title`,
`author`,
`publisher`)
VALUES
('Amigurumi',
'Jenny Coad',
'Sitepoint');
-- R
SELECT `idbook`
FROM `book`
WHERE title = 'Adorable Crochet Animals';
-- U
UPDATE `book`
SET
`title` = 'Tiny Crochet Animals'
WHERE `idbook` = 2;
-- D
DELETE FROM `book`
WHERE idbook = 1;


-- source ----------------------------------------------------------------
-- source.C.1 
INSERT INTO `source`
(`website_idwebsite`)
VALUES
((SELECT `idwebsite`
FROM `website`
WHERE web_address = 'www.starwarscrochet.org' ));

INSERT INTO `source`
(`website_idwebsite`)
VALUES
((SELECT `idwebsite`
FROM `website`
WHERE web_address = 'www.crochetdesigns.org' ));
INSERT INTO `source`
(`website_idwebsite`)
VALUES
((SELECT `idwebsite`
FROM `website`
WHERE web_address = 'www.morecrochetdesigns.org' ));
INSERT INTO `source`
(`book_idbook`)
VALUES
((SELECT `idbook` FROM `book` WHERE title = 'Adorable Crochet Animals'));
INSERT INTO `source`
(`book_idbook`)
VALUES
((SELECT `idbook` FROM `book` WHERE title = 'Tiny Crochet Animals'));
INSERT INTO `source`
(`book_idbook`)
VALUES
((SELECT `idbook` FROM `book` WHERE title = 'Amigurumi'));

-- R
SELECT * 
FROM source;

-- U
UPDATE `source`
SET
`book_idbook` = 3
WHERE `idsource` = 3;

-- D
DELETE FROM `source`
WHERE idsource = 1;



-- pattern ----------------------------------------------------------------
-- pattern.C.1 
INSERT INTO `pattern`
(`instructions`,
`size`,
`source_idsource`,
`name`)
VALUES
('1. Magic circle of 6 stiches. 2. crochet around 3. SC, inc',
5,
(SELECT idsource FROM source WHERE idsource = 2),
'Yoda');
INSERT INTO `pattern`
(`instructions`,
`size`,
`source_idsource`,
`name`)
VALUES
('1. Magic circle of 6 stiches. 2. crochet around 3. SC, inc',
5,
(SELECT idsource FROM source WHERE idsource = 2),
'Lando');
INSERT INTO `pattern`
(`instructions`,
`size`,
`source_idsource`,
`name`)
VALUES
('1. Magic circle of 6 stiches. 2. crochet around 3. SC, inc',
8,
(SELECT idsource FROM source WHERE idsource = 3),
'Darth Vader');
-- R
SELECT * FROM pattern;
-- U
UPDATE `pattern`
SET
`genre` = 'Star Wars'
WHERE `idpattern` = 1 AND `source_idsource` = 2;

-- D
DELETE FROM `pattern`
WHERE `source_idsource` = 3;

-- hook ----------------------------------------------------------------
-- C 
INSERT INTO `hook`
(`size`,
`material`)
VALUES
('E',
'steel');
INSERT INTO `hook`
(`size`,
`material`)
VALUES
('G',
'steel');
INSERT INTO `hook`
(`size`,
`material`)
VALUES
('F',
'steel');
-- R
SELECT * from hook;
-- U
UPDATE `hook`
SET
`material` = 'wood'
WHERE `idhook` = 3;

-- D
DELETE FROM `hook`
WHERE `idhook` = 1;


-- pattern hook ----------------------------------------------------------------
-- C.1 
INSERT INTO `pattern hook`
(`hook_idhook`,
`pattern_idpattern`)
VALUES
(2,
1),
(3,
1);
-- R
select * from `pattern hook`;
-- U
UPDATE `pattern hook`
SET
`pattern_idpattern` = 2
WHERE `idpattern_hook` = 1;
-- D
DELETE FROM `pattern hook`
WHERE `idpattern_hook` = 1;

-- yarn ----------------------------------------------------------------
-- C 
INSERT INTO `yarn`
(`color`,
`weight`,
`material`)
VALUES
('green',
3,
'wool'),
('light green',
3,
'wool');
INSERT INTO `yarn`
(`color`,
`weight`,
`material`)
VALUES
('beige',
4,
'cotton');
INSERT INTO `yarn`
(`color`,
`weight`,
`material`)
VALUES
('black',
4,
'acrylic');
-- R
SELECT * FROM `yarn`;
-- U
UPDATE yarn
SET
`material` = 'acrylic'
WHERE `idyarn` = 2;
-- D
DELETE FROM `crochet_dev`.`yarn`
WHERE `idyarn` = 1;

-- ship ----------------------------------------------------------------
-- C 
INSERT INTO `ship`
(`shipping_company`,
`cost`,
`date`)
VALUES
('USPS',
'4.35',
curdate() ),
('UPS',
'13.28',
curdate() ),
('FEDEX',
'17.28',
curdate() );
-- R
select * from `ship`;

-- U
UPDATE `ship`
SET
`cost` = '1.35'
WHERE `idship` = 1;
-- D
DELETE FROM `ship`
WHERE `idship` = 2;


-- customer ----------------------------------------------------------------
-- C 
INSERT INTO customer
(`first_name`,
`last_name`,
`phone`,
`email`,
`street_address`,
`city`,
`state`,
`zip_code`)
VALUES
('John',
'Jingleheimer',
'9852',
'john@jingleheimer.com',
'123 E Main Street',
'Johnsonville',
'Illinois',
'30325'),
(
'Mary',
'Jingleheimer',
'9852',
'mary@jingleheimer.com',
'123 E Main Street',
'Johnsonville',
'Illinois',
'30325'),
(
'Phillipa',
'Gatsby',
'4578',
'Phillipa@Gatsby.com',
'87 E Front St',
'Sierra Madre',
'Nevada',
'21589');
-- R
select * from customer;
-- U
UPDATE customer
SET
`phone` = '58585',
`street_address` = '34 W State Street',
`city` = 'Jacksonville'
WHERE `idcustomer` = 1;
-- D
DELETE FROM `customer`
WHERE `idcustomer` = 2;

-- sale ----------------------------------------------------------------
-- C 
INSERT INTO `sale`
(`customer_idcustomer`,
`ship_idship`)
VALUES
( (SELECT idcustomer from customer where email = 'Phillipa@Gatsby.com'),
1 );
INSERT INTO `sale`
(`customer_idcustomer`,
`ship_idship`)
VALUES
( (SELECT idcustomer from customer where email = 'john@jingleheimer.com'),
3 );
-- R
select * from sale;
-- U
UPDATE `sale`
SET
`ship_idship` = 3
WHERE `idsale` = 1 ;
-- D
DELETE FROM `sale`
WHERE idsale = '1';



-- plush ----------------------------------------------------------------
-- plush.C.1
INSERT INTO `plush`
(`name`,
`pattern_idpattern`,
`price`)
VALUES
('Blue Yoda',
(SELECT idpattern FROM pattern WHERE name = 'Yoda'),
'35.00');
INSERT INTO `plush`
(`name`,
`pattern_idpattern`)
VALUES
('Yoda',
(SELECT idpattern FROM pattern WHERE name = 'Yoda'));
INSERT INTO `plush`
(`name`,
`pattern_idpattern`)
VALUES
('Grey Yoda',
(SELECT idpattern FROM pattern WHERE name = 'Yoda'));
-- R
select * from plush;
-- U
UPDATE `plush`
SET
`price` = 30
WHERE `idplush` = 1 ;
-- D
DELETE FROM `plush`
WHERE idplush = 2;

-- plush yarn ----------------------------------------------------------------
-- C 
INSERT INTO `plush yarn`
(`plush_idplush`,
`yarn_idyarn`)
VALUES
(1,
(select idyarn from yarn where color = 'black')),
(1,
(select idyarn from yarn where color = 'beige'));
INSERT INTO `plush yarn`
(`plush_idplush`,
`yarn_idyarn`)
VALUES
(3,
(select idyarn from yarn where color = 'light green'));
-- R
select * from `plush yarn`;
-- U
UPDATE `plush yarn`
SET
`yarn_idyarn` = 4
WHERE `idplush_yarn` = 2 ;
-- D
DELETE FROM `plush yarn`
WHERE idplush_yarn = 1;



