## Performance Details
Setup:
- Workstation: HP HP ProDesk 600 G5 MT
- RAM: 16,0 GiB
- CPU: Intel® Core™ i5-9500 × 6
- Graphics: Mesa Intel® UHD Graphics 630 (CFL GT2)
- Harddisk: Samsung SSD 970 EVO Plus 500GB (2B2QEXM7)
- Partition: Ext4 (Version 1.0)
- OS: Fedora Linux 37 (Workstation Edition)
- Type: 64-bit

### 2023-03-25

#### Tweakstreet ETL

Geonames data: allCountries.txt file, 2023-03-25, 12373097 lines
Time started: 2023-03-25 17:41:02
Time ended: 2023-03-25 17:50:57
Duration: 09:55 min

Nodes created:
- Geoname: 11.938.573
- AdminDivision: 434.324
- Feature: 680
- Country: 193
- Continent: 7
 
Relations created:
- Geoname to AdminDivision (belongsTo): 22.005.423
- Geoname to Country (isPartOf): 11.830.084
- Geoname to Feature (isTypeOf): 11.843.522
- Countries to Continent (inContinent): 193

#### Kuzu Data load
threads: 6
logging level: info

copy Geoname: 43720.56ms (executing)
copy AdminDivision: 1208.92ms (executing)
copy Feature: 61.79ms (executing)
copy Country: 48.12ms (executing)
copy Continent: 14.44ms (executing)

copy belongsTo: 29060.51ms (executing)
copy isPartOf: 20576.44ms (executing)
copy isTypeOf: 28328.69ms (executing)
copy inContinent: 57.87ms (executing)


