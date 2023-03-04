# tweakstreet-kuzudb
Tweakstreet ETL to load data to Kuzudb.

## General
The main fokus is on loading data into Kuzudb using the command client. The Tweakstreet ETL tool - https://tweakstreet.io - is used to prepare the https://www.geonames.org data, so it can efficiently be imported into Kuzudb - https://kuzudb.com.

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

Sqlite Tables:
- admin
- continent
- country
- geonames

Data is devided into following categories:
- Geoname entries of type "country"
- Geoname entries of type "continent"
- Geoname entries of type "admin division"
- all other Geoname entries

The second part of the ETL pipeline prepares the data to produces node and relations information.
- Data from the feature class and feature code text file is converted into nodes
- Data from the admin table is converted into nodes
- Data from the geonames table is converted into nodes
- Data from the geonames table is matched against admin1 to admin4 divisions from the admin table to produce relations between geonames and admin divisions
- Data from the geonames tables is matched against the country table to produce relations between geonames and allCountries
- Data from the geonames tables is matched against the features table to produce relations between geonames and features

## Cypher
A cypher script is available which creates the schemas for the nodes and relations and them imports the data. There is an additional script to delete the structures in kuzudb.

last update: uwe.geercken@web.de - 2023-03-04
