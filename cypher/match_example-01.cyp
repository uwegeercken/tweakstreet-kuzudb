

# match one geoname, return all admin divisions
match(g:Geoname)-[r:belongsTo]->(ad:AdminDivision) where g.geonameid=2900899 return g.name, ad.name, ad.feature_code;

# match one geoname, return country and continent
match(g:Geoname)-[r:isPartOf]->(c:Country)-[r2:inContinent]->(co:Continent) where g.geonameid=2900899 return g.name, c.code, co.name;

# match one geoname, return 
match(c:Country)<-[r2:isPartOf]-(g:Geoname)-[r:isTypeOf]->(f:Feature) where g.name="Hohn" return c.code, g.name, f.code, f.name;

macth feature Airport in country Germany, return number of airports
match(c:Country)<-[r2:isPartOf]-(g:Geoname)-[r:isTypeOf]->(f:Feature) where c.code='DE' and f.code='AIRP' return count(r) as numberOfAirports;

