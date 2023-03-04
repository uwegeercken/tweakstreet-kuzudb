
match(n:Geoname) return count(n) as total_nodes_geonames;
match(n:AdminDivision) return count(n) as total_nodes_admindivisions;
match(n:Country) return count(n) as total_nodes_countries;
match(n:Feature) return count(n) as total_nodes_features;
match()-[r:belongsTo]->() return count(r) as total_relations_belongsTo;
match()-[r:isPartOf]->() return count(r) as total_relations_isPartOf;
match()-[r:isTypeOf]->() return count(r) as total_relations_isTypeOf;

