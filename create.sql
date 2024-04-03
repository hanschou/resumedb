DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS reference;
DROP TABLE IF EXISTS ikeywords;
DROP TABLE IF EXISTS interests;
DROP TABLE IF EXISTS languages;
DROP TABLE IF EXISTS keywords;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS publications;
DROP TABLE IF EXISTS certificates;
DROP TABLE IF EXISTS awards;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS education;
DROP TABLE IF EXISTS volunteer;
DROP TABLE IF EXISTS highlights;
DROP TABLE IF EXISTS work;
DROP TABLE IF EXISTS profiles;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS basics;

CREATE TABLE basics (
	bid serial PRIMARY KEY,
	name text NOT NULL,
	label text,
	image text,
	email text,
	phone text,
	url text,
	summary text
);

COMMENT ON TABLE basics IS 'Persons basic data';
COMMENT ON COLUMN basics.bid IS 'Basics unique identifier';
COMMENT ON COLUMN basics.name IS 'Full name';
COMMENT ON COLUMN basics.label IS 'e.g. Web Developer';
COMMENT ON COLUMN basics.image IS 'URL (as per RFC 3986) to a image in JPEG or PNG format';
COMMENT ON COLUMN basics.email IS 'e.g. thomas@gmail.com';
COMMENT ON COLUMN basics.phone IS 'Phone numbers are stored as strings so use any format you like, e.g. 712-117-2923';
COMMENT ON COLUMN basics.url IS 'URL (as per RFC 3986) to your website, e.g. personal homepage';
COMMENT ON COLUMN basics.summary IS 'Write a short 2-3 sentence biography about yourself';

CREATE TABLE location (
	bid integer REFERENCES basics,
	address text,
	postalcode text,
	city text,
	countrycode char(2) CHECK (countrycode ~ '[A-Z]{2}'),
	region text
);

COMMENT ON COLUMN location.bid IS 'Reference to basics.bid';
COMMENT ON COLUMN location.address IS 'To add multiple address lines, use \n. For example, 1234 Glücklichkeit Straße\nHinterhaus 5. Etage li.';
COMMENT ON COLUMN location.postalCode IS 'Postal code';
COMMENT ON COLUMN location.city IS 'City name';
COMMENT ON COLUMN location.countryCode IS 'code as per ISO-3166-1 ALPHA-2, e.g. US, AU, IN';
COMMENT ON COLUMN location.region IS 'The general region where you live. Can be a US state, or a province, for instance.';

CREATE TABLE profiles(
	bid integer REFERENCES basics,
	network text,
	username text,
	url text
);

COMMENT ON COLUMN profiles.bid IS 'Reference to basics.bid';
COMMENT ON COLUMN profiles.network IS 'e.g. Facebook or Twitter';
COMMENT ON COLUMN profiles.username IS 'e.g. neutralthoughts';
COMMENT ON COLUMN profiles.url IS 'e.g. http://twitter.example.com/neutralthoughts';

CREATE TABLE work(
	bid integer REFERENCES basics,
	wid serial PRIMARY KEY,
	name text,
	location text,
	description text,
	position text,
	url text,
	startDate date,
	endDate date,
	summary text
);

COMMENT ON COLUMN work.bid IS 'Reference to basics.bid';
COMMENT ON COLUMN work.wid IS 'Unique identifier';
COMMENT ON COLUMN work.name IS 'e.g. Facebook';
COMMENT ON COLUMN work.location IS 'e.g. Menlo Park, CA';
COMMENT ON COLUMN work.description IS 'e.g. Social Media Company';
COMMENT ON COLUMN work.position IS 'e.g. Software Engineer';
COMMENT ON COLUMN work.url IS 'e.g. http://facebook.example.com';
COMMENT ON COLUMN work.startDate IS '#/definitions/iso8601';
COMMENT ON COLUMN work.endDate IS '#/definitions/iso8601';
COMMENT ON COLUMN work.summary IS 'Give an overview of your responsibilities at the company';

CREATE TABLE highlights(
	wid integer REFERENCES work,
	items text
);

COMMENT ON TABLE highlights IS 'Specify multiple accomplishments';
COMMENT ON COLUMN highlights.wid IS 'Reference to work.wid';
COMMENT ON COLUMN highlights.items IS 'e.g. Increased profits by 20% from 2011-2012 through viral advertising';

CREATE TABLE volunteer(
	bid integer REFERENCES basics,
	vid serial PRIMARY KEY,
	organization text,
	position text,
	url text,
	startDate date,
	endDate date,
	summary text
);

CREATE TABLE education (
	bid integer REFERENCES basics,
	eid serial PRIMARY KEY,
	institution text,
	url text,
	area text,
	studyType text,
	startDate date,
	endDate date,
	score text
);

CREATE TABLE courses (
	eid integer REFERENCES education,
	description text
);

CREATE TABLE awards (
	bid integer REFERENCES basics,
	title text,
	adate date,
	awarder text,
	summary text
);

CREATE TABLE certificates (
	bid integer REFERENCES basics,
	name text,
	cdate date,
	url text,
	cissuer text
);

CREATE TABLE publications (
	bid integer REFERENCES basics,
	name text,
	publisher text,
	releaseDate date,
	url text,
	summary text
);

CREATE TABLE skills (
	bid integer REFERENCES basics,
	sid serial PRIMARY KEY,
	name text,
	slevel text
);

CREATE TABLE keywords(
	sid integer REFERENCES skills,
	items text
);

CREATE TABLE languages(
	bid integer REFERENCES basics,
	language text,
	fluency text
);

CREATE TABLE interests(
	bid integer REFERENCES basics,
	iid serial PRIMARY KEY,
	name text
);

CREATE TABLE ikeywords(
	iid integer REFERENCES interests,
	items text
);

CREATE TABLE reference(
	bid integer REFERENCES basics,
	name text,
	reference text
);

CREATE TABLE projects(
	bid integer REFERENCES basics,
	pid serial PRIMARY KEY,
	name text,
	description text
);
