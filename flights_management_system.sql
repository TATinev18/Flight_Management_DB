CREATE DATABASE flights_managements_system;
USE flights_managements_system;

CREATE TABLE Flights(
	flight_id INT PRIMARY KEY AUTO_INCREMENT,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    duration TIME NOT NULL,
    origin_airport VARCHAR(10) NOT NULL,
    destination_airport VARCHAR(10) NOT NULL,
    plane_id INT NOT NULL,
    status_id INT NOT NULL
);
    
CREATE TABLE Planes(
	plane_id INT PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(250) NOT NULL,
    capacity SMALLINT NOT NULL
);

CREATE TABLE Airports(
	airport_code VARCHAR(10) PRIMARY KEY,
    airport_name VARCHAR(250) NOT NULL,
    city VARCHAR(250) NOT NULL,
    country VARCHAR(250) NOT NULL
);

CREATE TABLE CrewMembers(
	crew_id INT PRIMARY KEY AUTO_INCREMENT,
    crew_name VARCHAR(250) NOT NULL,
    role ENUM('Pilot', 'First Officer', 'Steward', 'Stewardess', 'Engineer') NOT NULL
);

CREATE TABLE Food(
	food_id INT PRIMARY KEY AUTO_INCREMENT,
    food_description VARCHAR(250) NOT NULL 
);

CREATE TABLE FlightStatus (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name ENUM('Scheduled', 'Boarding', 'Departed', 'Delayed', 'Cancelled', 'Landed') NOT NULL
);

CREATE TABLE FlightCrew (
    flight_id INT NOT NULL,
    crew_id INT NOT NULL,
    role ENUM('Pilot', 'First Officer', 'Steward', 'Stewardess', 'Engineer') NOT NULL,
    
    PRIMARY KEY (flight_id, crew_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE,
    FOREIGN KEY (crew_id) REFERENCES CrewMembers(crew_id) ON DELETE CASCADE
);

CREATE TABLE FlightFood (
    flight_id INT NOT NULL,
    food_id INT NOT NULL,

    PRIMARY KEY (flight_id, food_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE,
    FOREIGN KEY (food_id) REFERENCES Food(food_id) ON DELETE CASCADE
);

CREATE TABLE CrewReplacement (
    crew_id INT NOT NULL,
    replacement_id INT NOT NULL,

    PRIMARY KEY (crew_id, replacement_id),
    FOREIGN KEY (crew_id) REFERENCES CrewMembers(crew_id) ON DELETE CASCADE,
    FOREIGN KEY (replacement_id) REFERENCES CrewMembers(crew_id) ON DELETE CASCADE
);

ALTER TABLE Flights 
ADD CONSTRAINT fk_flight_origin FOREIGN KEY (origin_airport) REFERENCES Airports(airport_code) ON DELETE CASCADE;

ALTER TABLE Flights 
ADD CONSTRAINT fk_flight_destination FOREIGN KEY (destination_airport) REFERENCES Airports(airport_code) ON DELETE CASCADE;

ALTER TABLE Flights 
ADD CONSTRAINT fk_flight_plane FOREIGN KEY (plane_id) REFERENCES Planes(plane_id) ON DELETE CASCADE;

ALTER TABLE Flights 
ADD CONSTRAINT fk_flight_status FOREIGN KEY (status_id) REFERENCES FlightStatus(status_id) ON DELETE CASCADE;


