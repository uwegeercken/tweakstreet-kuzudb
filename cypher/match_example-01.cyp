
match(g:Geoname)-[r:belongsTo]->(d:AdminDivision {feature_code:"ADM1",name: "Schleswig-Holstein"}), (g)-[r2:isTypeOf]->(f:Feature {code: "P.PPLA4"}), (g)-[r3:belongsTo]->(d2:AdminDivision) where g.name="Hohn" return g.name, d2.name, d2.feature_code;


