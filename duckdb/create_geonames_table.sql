create table geonames (geonameid long, name varchar, asciiname varchar, alternatenames varchar[], latitude double, longitude double, feature_class varchar, feature_code varchar, country_code varchar, cc2 varchar, admin1_code varchar, admin2_code varchar, admin3_code varchar, admin4_code varchar, admin5_code varchar, population long, elevation int, dem varchar, timezone varchar, modification_date date, primary key(geonameid));

copy geonames from '/home/uwe/development/git/tweakstreet-kuzudb/data/allCountries4duckdb.csv' (delimiter '\t', quote '');
