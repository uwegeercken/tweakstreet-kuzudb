:thread 24;
:logging_level debug;

create node table Geoname(geonameid int64, name string, asciiname string, latitude double, longitude double, population int64, elevation int64, dem string, timezone string, modification_date date, primary key(geonameid));
create node table Feature(class_code string, class string, class_description string, code string, name string, description string, primary key(class_code));
create node table AdminDivision(geonameid int64, name string, feature_class string, feature_code string, population int64, modification_date date, primary key(geonameid));
create node table Country(geonameid int64, name string, code string, population int64, modification_date date, primary key(geonameid));
create node table Continent(geonameid int64, name string, code string, population int64, modification_date date, primary key(geonameid));
create rel table belongsTo(from Geoname to AdminDivision);
create rel table isTypeOf(from Geoname to Feature);
create rel table isPartOf(from Geoname to Country);
create rel table inContinent(from Country to Continent);

copy AdminDivision from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_admin_division.csv";
copy Country from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_country.csv";
copy Continent from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_continent.csv";
copy Feature from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_feature.csv";
copy Geoname from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_geoname.csv";

copy belongsTo from "/home/uwe/development/git/tweakstreet-kuzudb/data/relation_geoname_admin_division.csv";
copy isPartOf from "/home/uwe/development/git/tweakstreet-kuzudb/data/relation_geoname_country.csv";
copy isTypeOf from "/home/uwe/development/git/tweakstreet-kuzudb/data/relation_geoname_feature.csv";
copy inContinent from "/home/uwe/development/git/tweakstreet-kuzudb/data/relation_country_continent.csv";
