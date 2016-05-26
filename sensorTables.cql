//
//  Three representative sensor tables with different primary key structures
//

create table if not exists bootcamp.sensor_a (
	day_year varchar,
	sensor_id UUID,
	sensor_type int,
	reading_timestamp timestamp,
	temperature float,
	pressure float,
	primary key (sensor_id, day_year, reading_timestamp )
	);
	
create table if not exists bootcamp.sensor_b (
	day_year varchar,
	sensor_id UUID,
	sensor_type int,
	reading_timestamp timestamp,
	temperature float,
	pressure float,
	primary key (day_year, sensor_id, reading_timestamp )
	);	
	
create table if not exists bootcamp.sensor_c (
	day_year varchar,
	sensor_id UUID,
	sensor_type int,
	reading_timestamp timestamp,
	temperature float,
	pressure float,
	primary key ((day_year, sensor_id), reading_timestamp )
	);
	
