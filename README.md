# tweakstreet-kuzudb
Tweakstreet ETL to load data to Kuzudb

## General
The main fokus is on loading data into Kuzudb using the command client. The Tweakstreet ETL tool - https://tweakstreet.io - is used to prepare the https://www.geonames.org data, so it can efficiently be loaded into Kuzudb - https://kuzudb.com.

From the goenames data following nodes are created:
- Geoname
- Country
- Continent
- Admin Division
- Feature

Data is processed into corresponding csv files, which can then be loaded into Kuzudb.

All data originates from: http://download.geonames.org/export/dump

## Tweakstreet Data Pipeline
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

The second part prepares the data to produces node and relations information.
- Data from the feature class and feature code text file is converted into nodes
- Data from the admin table is converted into nodes
- Data from the geonames table is converted into nodes
- Data from the geonames table is matched against Admin1 to Admin4 divisions from the admin table to produce relations between geonames and aadmin divisions
- Data from the geonames tables is matched against the country table to produce relations between geonames and allCountries
- Data from the geonames tables is matched against the country table to produce relations between geonames and features

## Cypher
A cypher script is available which creates the schemas for the nodes and relations.

last update: uwe.geercken@web.de - 2023-03-01
