
create table Movies (
	Code Integer Primary key NOT NULL,
	Title Varchar(25) NOT NULL,
	Rating Varchar(25),
);

create table MovieTheatres (
	Code Integer Primary Key NOT NULL,
	Name Varchar(25) NOT NULL,
	Movie Integer,
	Constraint fk_Movies_Code Foreign key(Movie) References Movies(Code) -- fk_Movies_Code is the name for our condition
);


INSERT INTO Movies(Code,Title,Rating) VALUES(9,'Citizen King','G');
INSERT INTO Movies(Code,Title,Rating) VALUES(1,'Citizen Kane','PG');
INSERT INTO Movies(Code,Title,Rating) VALUES(2,'Singin'' in the Rain','G');
INSERT INTO Movies(Code,Title,Rating) VALUES(3,'The Wizard of Oz','G');
INSERT INTO Movies(Code,Title,Rating) VALUES(4,'The Quiet Man',NULL);
INSERT INTO Movies(Code,Title,Rating) VALUES(5,'North by Northwest',NULL);
INSERT INTO Movies(Code,Title,Rating) VALUES(6,'The Last Tango in Paris','NC-17');
INSERT INTO Movies(Code,Title,Rating) VALUES(7,'Some Like it Hot','PG-13');
INSERT INTO Movies(Code,Title,Rating) VALUES(8,'A Night at the Opera',NULL);

INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(1,'Odeon',5);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(2,'Imperial',1);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(3,'Majestic',NULL);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(4,'Royale',6);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(5,'Paraiso',3);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(6,'Nickelodeon',NULL);


-- 1. Select the title of all movies. 
		select Title from Movies;

-- 2. Show all the distinct ratings in the database. 
		select distinct(Rating) from Movies;

-- 3. Show all unrated movies.
		select * from Movies where Rating is NULL;

-- 4. Select all movie theaters that are not currently showing a movie. 
		select * from MovieTheaters where Movie is NULL;

-- 5. Select all data from all movie theaters and, 
-- additionally, the data from the movie that is being shown in the theater (if one is being shown). 
		select * from 
		MovieTheaters Left join Movies
		on MovieTheaters.Movie = Movies.Code;

-- 6. Select all data from all movies and, 
-- if that movie is being shown in a theater, show the data from the theater. 
		select * from 
		Movies Left Join MovieTheaters
		on Movies.Code = MovieTheaters.Movie;

-- 7. Show the titles of movies not currently being shown in any theaters.
		select Title from Movies
		where Code not in (
				select Movie 
				from MovieTheaters
				where Movie is not NULL
			);

-- 8. Add the unrated movie "One, Two, Three". 
		insert into Movies(Code, Title, Rating) values (9, "One, Two, Three", NULL);

-- 9. Set the rating of all unrated movies to "G".
		update Movies
			set Rating = "G"
			where Rating is NULL;

-- 10. Remove movie theaters projecting movies rated "NC-17". 
		delete from MovieTheaters
			where Movie in (
				select Code 
				from Movies 
				where Rating = "NC-17"
				)