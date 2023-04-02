LOAD CSV with headers FROM 'file:///node_country.csv' AS row fieldterminator ','
merge(c:Country {geonameid: row.geonameid})
set
    c.name = row.name,
    c.code = row.code,
    c.population = row.population,
    c.modification_date = row.modification_date
;

LOAD CSV with headers FROM 'file:///node_continent.csv' AS row fieldterminator ','
merge(co:Continent {geonameid: row.geonameid})
set
    co.name = row.name,
    co.code = row.code,
    co.population = row.population,
    co.modification_date = row.modification_date
;

LOAD CSV with headers FROM 'file:///node_feature.csv' AS row fieldterminator ','
merge(f:Feature {generated_id: row.generated_id})
set
    f.class_code = row.class_code,
    f.name = row.name,
    f.description = row.description,
    f.class = row.class,
    f.class_description = row.class_description,
    f.code = row.code
;

:auto LOAD CSV with headers FROM 'file:///node_admin_division.csv' AS row fieldterminator ','
CALL {
    with row
    merge(ad:AdminDivision {geonameid: row.geonameid})
    set
        ad.name = row.name,
        ad.feature_class = row.feature_class,
        ad.feature_code = row.feature_code,
        ad.population = row.population,
        ad.modification_date = row.modification_date
    } IN TRANSACTIONS OF 5000 ROWS 
;

:auto LOAD CSV FROM 'file:///node_geoname.csv' AS row fieldterminator ','
CALL {
    with row
    merge(g:geoname {geonameid: row[0]})
    set
        g.name = row[1],
        g.asciiname = row[2],
        g.latitude = row[3],
        g.longitude = row[4],
        g.population = row[5],
        g.elevation = row[6],
        g.dem = row[7],
        g.timezone = row[8],
        g.modification_date = row[9]
    } IN TRANSACTIONS OF 5000 ROWS    
;

LOAD CSV FROM 'file:///relation_country_continent.csv' AS row fieldterminator ','
match(c:Country {geonameid: row[0]})
match(co:Continent {geonameid: row[1]})
merge(c)-[:inContinent]->(co)
;

:auto LOAD CSV FROM 'file:///relation_geoname_country.csv' AS row fieldterminator ','
CALL {
    with row
    match(g:Geoname {geonameid: row[0]})
    match(c:Country {geonameid: row[1]})
    merge(g)-[:isPartOf]->(c)
    } IN TRANSACTIONS OF 5000 ROWS
;

:auto LOAD CSV FROM 'file:///relation_geoname_feature.csv' AS row fieldterminator ','
CALL {
    with row
    match(g:Geoname {geonameid: row[0]})
    match(f:Feature {generated_id: row[1]})
    merge(g)-[:isTypeOf]->(f)
    } IN TRANSACTIONS OF 5000 ROWS
;

:auto LOAD CSV FROM 'file:///relation_geoname_admin_division.csv' AS row fieldterminator ','
CALL {
    with row
    match(g:Geoname {geonameid: row[0]})
    match(ad:AdminDivision {geonameid: row[1]})
    merge(g)-[:belongsTo]->(ad)
    } IN TRANSACTIONS OF 5000 ROWS
;

