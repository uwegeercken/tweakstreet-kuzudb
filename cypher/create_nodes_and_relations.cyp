:thread 6
:logging_level info

create node table Geoname(geonameid int64, name string, asciiname string, latitude double, longitude double, population int64, elevation int64, dem string, timezone string, modification_date date, primary key(geonameid));
create node table Feature(generated_id int64, class_code string, class string, class_description string, code string, name string, description string, primary key(generated_id));
create node table AdminDivision(geonameid int64, name string, feature_class string, feature_code string, population int64, modification_date date, primary key(geonameid));
create node table Country(geonameid int64, name string, code string, population int64, modification_date date, primary key(geonameid));
create node table Continent(geonameid int64, name string, code string, population int64, modification_date date, primary key(geonameid));

create rel table belongsTo(from Geoname to AdminDivision, MANY_MANY);
create rel table isTypeOf(from Geoname to Feature, MANY_ONE);
create rel table isPartOf(from Geoname to Country, MANY_ONE);
create rel table inContinent(from Country to Continent, MANY_ONE);

copy Geoname from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_geoname.csv";
copy AdminDivision from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_admin_division.csv";
copy Feature from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_feature.csv";
copy Country from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_country.csv";
copy Continent from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_continent.csv";

copy belongsTo from "/home/uwe/development/git/tweakstreet-kuzudb/data/relation_geoname_admin_division.csv";
copy isPartOf from "/home/uwe/development/git/tweakstreet-kuzudb/data/relation_geoname_country.csv";
copy isTypeOf from "/home/uwe/development/git/tweakstreet-kuzudb/data/relation_geoname_feature.csv";
copy inContinent from "/home/uwe/development/git/tweakstreet-kuzudb/data/relation_country_continent.csv";

