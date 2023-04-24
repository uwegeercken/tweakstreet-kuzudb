# tweakstreet-kuzudb
Tweakstreet ETL to load geonames.org geographic data to Kuzudb.

## General
The main fokus is on loading data into Kuzudb using the command client. The Tweakstreet ETL tool - https://tweakstreet.io - is used to prepare the https://www.geonames.org data, so it can efficiently be imported into Kuzudb - https://kuzudb.com.

Additionally, there is a script available, which imports the same files and data into a Neo4j database. Import can be done using cypher (slow) or using the admin-client tool (fast) of Neo4j.

Additionally, the is an ETL Dataflow "transform4duckdb.dfl", which generates a csvfile, that can be imported into a duckdb database. The script "create_geonames_table.sql" in the "duckdb" folder creates the table structure and imports the data. This data is (almost) a 1-to-1 copy of the original data in the "allCountries.txt" file. Only some simple cleanup has been applied to be able to load the "alternatenames" column (which is an array of names) into duckdb. I use a duckdb database to compare the numbers I find in Kuzudb for quality reasons. 

From the goenames data following nodes are created:
- Geoname
- Country
- Continent
- Admin Division
- Feature

The feature codes represent type of entries such as e.g. river, populated area, mine, etc.

Data is processed into corresponding csv files for nodes and relations, which can then be loaded into Kuzudb.

All data originates from: http://download.geonames.org/export/dump

## Tweakstreet Data Pipeline
Tweakstreet is a very capable tool to process data. It is clean, fast and also specifically good for tree-like, nested data such as xml and json. You can design flows using the gui and run them or alternatively run them in the console or a docker container.

The processing of this data here is split into a main control flow and three data flows which represent different stages in the data processing.

The first part of the pipeline reads the allCountries.txt geonames file, filters the data by certain feature codes and stores the data in multiple tables in a local Sqlite database.

### Load data
Data from the following files:
- allCountries.txt
- feature_codes_en.txt
- feature_classes.txt
- adminCode5.txt
- countryInfo.txt

Note 1: The countryInfo.txt file has multiple lines of comments at the top. These need to be removed before processing (keep the header row).
Note 2: The adminCode5.txt is from the adminCode5.zip file and needs to be extracted before processing.

The data from the files is imported into Sqlite tables:
- admindivision
- continent
- country
- geoname
- feature

Data is devided during the ETL into following categories:
- Geoname entries of type "country" - for the country table
- Geoname entries of type "continent" - for the continent table
- Geoname entries of type "admin division" - for the admindivision table
- all other Geoname entries - for the geoname table

### Create node files
Data is read from the Sqlite tables and the relevant nodes files are generated:
- node_feature.csv
- node_admin_division.csv
- node_country.csv
- node_continent.csv
- node_geoname.csv

### Create relations files
The last part of the ETL pipeline prepares the data to produces the relations.
- data from the geoname and country table is used to output the relation of geonames to countries - for the relation_geoname_country.csv files
- data from the country and continent table is used to output the relation of countries to continents - for the relation_country_continent.csv files
- data from the geoname table is used to output the relation of geonames to features - for the relation_geoname_feature.csv file
- data from the geoname and admindivision table is used to output the relation of geonames to admin divisions - for the relation_geoname_admin_division.csv file

## Cypher
A cypher script is available which creates the schemas for the nodes and relations and them imports the data. There is an additional script to delete the structures in kuzudb.

There are two scripts for counting the nodes and relations and one with some query examples.

![grafik](https://user-images.githubusercontent.com/6207140/222886182-171b3715-64fb-4a0c-b92e-76cae5a75d43.png)

## Processing the data
First go to http://download.geonames.org/export/dump and download following files:
- allCountries.txt
- feature_classes.txt
- feature_codes_en.txt
- countryInfo.txt
- adminCode5.zip

Put the data into a folder of your choice. Unzip the adminCode5.zip file.

To run the flows, you first need to install tweakstreet - it is available for Linux, Mac and WIndows. Once done, open the controlflow "geonames2kuzu.cfl". Connect the module "module.tsm" (select "File" and then "Choose Config Module" from the menu). The module contains configuration details. Specifically you need to adjust the "rootFolder" variable to your needs. The "dataOutputFolder" variable defines where the resulting csv files will be generated.

![grafik](https://user-images.githubusercontent.com/6207140/222886105-5033ec86-59f6-41ef-a1eb-d4010a10d161.png)

To run the ETL process, in the Tweakstreet ETL tool right click the canvas and select 'Run...') and check both parameters 'clearAndLoadDatabase' and 'createCsvFiles' and click the "Run" button. Wait until it finishes - hopefully without issues.

At this point you can run the cypher script (adjust the path info according to your needs) to import the data like this:

```
./kuzu -i [database path] < create_nodes_and_relations.cyp
```

Some statictics (using the current files from geonames.org):
- Node table Geoname: 11842832
- Node Table Feature: 680
- Node table Country: 193
- Node table Continent: 7
- Node table AdminDivision: 515024
- Relation table isTypeOf: 11747765
- Relation table isPartOf: 11734891
- Relation table belongsTo: 21863415
- Relation table inContinent: 193

Let me know if you find bug but also if you want to participate in further extending the idea.

last update: uwe.geercken@web.de - 2023-04-01
