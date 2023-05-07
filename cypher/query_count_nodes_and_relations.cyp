match(n:Geoname) return label(n), count(n) as total
union
match(n:AdminDivision) return label(n), count(n) as total
union
match(n:PoliticalEntity) return label(n), count(n) as total
union
match(n:Continent) return label(n), count(n) as total
union
match(n:Feature) return label(n), count(n) as total;


match()-[r:belongsTo]->() return label(r), count(r) as total
union
match()-[r:isPartOf]->() return label(r), count(r) as total
union
match()-[r:isTypeOf]->() return label(r), count(r) as total
union
match()-[r:inContinent]->() return label(r), count(r) as total;
