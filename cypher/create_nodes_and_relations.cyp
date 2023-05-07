:thread 6
:logging_level info

create node table Geoname(geonameid int64, name string, asciiname string, latitude double, longitude double, population int64, elevation int64, dem string, timezone string, modification_date date, primary key(geonameid));
create node table Feature(generated_id int64, class_code string, class string, class_description string, code string, name string, description string, primary key(generated_id));
create node table AdminDivision(geonameid int64, name string, feature_class string, feature_code string, population int64, modification_date date, primary key(geonameid));
create node table PoliticalEntity(geonameid int64, name string, code string, feature_class string, feature_code string, population int64, modification_date date, primary key(geonameid));
create node table Continent(geonameid int64, name string, code string, population int64, modification_date date, primary key(geonameid));

create rel table belongsTo(from Geoname to AdminDivision, MANY_MANY);
create rel table isTypeOf(from Geoname to Feature, MANY_ONE);
create rel table isPartOf(from Geoname to PoliticalEntity, MANY_ONE);
create rel table inContinent(from PoliticalEntity to Continent, MANY_ONE);

copy Geoname from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_geoname.csv";
copy AdminDivision from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_admin_division.csv";
copy Feature from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_feature.csv";
copy PoliticalEntity from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_politicalentity.csv";
copy Continent from "/home/uwe/development/git/tweakstreet-kuzudb/data/node_continent.csv";

copy belongsTo from "/home/uwe/development/git/tweakstreet-kuzudb/data/relation_geoname_admin_division.csv";
copy isPartOf from "/home/uwe/development/git/tweakstreet-kuzudb/data/relation_geoname_politicalentity.csv";
copy isTypeOf from "/home/uwe/development/git/tweakstreet-kuzudb/data/relation_geoname_feature.csv";
copy inContinent from "/home/uwe/development/git/tweakstreet-kuzudb/data/relation_politicalentity_continent.csv";
