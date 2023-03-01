create node table Geoname(geonameid int64, name string, asciiname string, latitude double, longitude double, population int64, elevation int64, dem string, timezone string ,modification_date string, primary key(geonameid));

create node table Feature(class string, code string, name string, description string, primary key(code));

create rel table belongsTo(from Geoname to AdminDivision);
create rel table isTypeOf(from Geoname to Feature);