# match one geoname, return all admin divisions
match(g:Geoname)-[r:belongsTo]->(ad:AdminDivision)
where g.geonameid=2900899
return g.name, ad.name, ad.feature_code;

# match one geoname, return politicalentity and continent
match(g:Geoname)-[r:isPartOf]->(c:PoliticalEntity)-[r2:inContinent]->(co:Continent)
where g.geonameid=2900899
return g.name, c.code, co.name;

# match one geoname, return politicalentity, geoname and feature
match(c:PoliticalEntity)<-[r2:isPartOf]-(g:Geoname)-[r:isTypeOf]->(f:Feature)
where g.name="Hohn"
return c.code, g.name, f.code, f.name;

# match geoname return the max elevation for one politicalentity
match(c:PoliticalEntity)<-[:isPartOf]-(g:Geoname)
where c.code='DE'
return max(g.elevation);

# get the highest modification dates
match(g:Geoname)
return max(g.modification_date);

# match top 5 populated places for the selected politicalentity
match(c:PoliticalEntity)<-[:isPartOf]-(g:Geoname)-[]->(f:Feature)
where c.code='DE' and f.code=~ 'PPL.'
return g.name, g.population, f.code, f.name
order by g.population desc limit 5;

# match feature of type Airport in politicalentity Germany, return number of airports
match(c:PoliticalEntity)<-[r2:isPartOf]-(g:Geoname)-[r:isTypeOf]->(f:Feature)
where c.code='DE' and f.code='AIRP'
return count(r) as numberOfAirports;

# match feature of type Airport, return number of airports per politicalentity where number is greater than 100
match(c:PoliticalEntity)<-[:isPartOf]-(:Geoname)-[r:isTypeOf]->(f:Feature)
where f.code='AIRP'
with c, count(r) as numberOfAirports
where numberOfAirports >100
return c.name as politicalentity, numberOfAirports;

# match feature of type Airport and match the continents, return number of airports per continent
match(co:Continent)<-[r3:inContinent]-(c:PoliticalEntity)<-[r2:isPartOf]-(g:Geoname)-[r:isTypeOf]->(f:Feature)
where f.code='AIRP'
with co,count(r) as numberOfAirports
return co.name, numberOfAirports
order by co.name;

# match top 10 features in a politicalentity
match(c:PoliticalEntity)<-[:isPartOf]-(:Geoname)-[isTypeOf]->(f:Feature)
where c.code='DE'
return f.class_code, f.description, count(f) as total
order by total desc limit 10;

# match continents and politicalentities, return continent and number fo countries
match(c:PoliticalEntity)-[]->(co:Continent)
return co.name as continent, len(collect(c.code)) as numberOfPoliticalEntities;
