# match one geoname, return all admin divisions
match(g:Geoname)-[r:belongsTo]->(ad:AdminDivision)
where g.geonameid=2900899
return g.name, ad.name, ad.feature_code;

# match one geoname, return country and continent
match(g:Geoname)-[r:isPartOf]->(c:Country)-[r2:inContinent]->(co:Continent)
where g.geonameid=2900899
return g.name, c.code, co.name;

# match one geoname, return country, geoname and feature
match(c:Country)<-[r2:isPartOf]-(g:Geoname)-[r:isTypeOf]->(f:Feature)
where g.name="Hohn"
return c.code, g.name, f.code, f.name;

# match geoname return the max elevation for one country
match(c:Country)<-[:isPartOf]-(g:Geoname)
where c.code='DE' 
return max(g.elevation);

# match top 5 populated places for the selected country
match(c:Country)<-[:isPartOf]-(g:Geoname)-[]->(f:Feature)
where c.code='DE' and f.code=~ 'PPL.'
return g.name, g.population, f.code, f.name
order by g.population desc limit 5;

# match feature of type Airport in country Germany, return number of airports
match(c:Country)<-[r2:isPartOf]-(g:Geoname)-[r:isTypeOf]->(f:Feature)
where c.code='DE' and f.code='AIRP'
return count(r) as numberOfAirports;

# match feature of type Airport, return number of airports per country where number is greater than 100
match(c:Country)<-[:isPartOf]-(:Geoname)-[r:isTypeOf]->(f:Feature)
where f.code='AIRP'
with c, count(r) as numberOfAirports
where numberOfAirports >100
return c.name as country, numberOfAirports;

# match feature of type Airport, then match the continents, return number of airports per continent
match(c:Country)<-[:isPartOf]-(:Geoname)-[r:isTypeOf]->(f:Feature) 
where f.code='AIRP'
with c,r
match (co:Continent)<-[:inContinent]-(c)
return co.name, count(r) as numberOfAirports;


