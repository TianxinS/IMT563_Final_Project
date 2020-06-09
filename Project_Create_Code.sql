/*-------------CREATING STREAMING PLATFORMS TABLE------------------*/

CREATE TABLE StreamingPlatform
(
	SPID INT NOT NULL PRIMARY KEY,
	SPName VARCHAR(100)
)

/*----------------HARDCODED INSERT FOR STREAMING PLATFORMS---------------------*/
INSERT INTO StreamingPlatform
VALUES
(1, 'Amazon Prime Video'),
(2, 'Disney+'),
(3, 'Netflix'),
(4, 'Hulu')


/*

CREATE TABLE MovieStreamingPlatform
(
	MSPID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	SPID INT NOT NULL FOREIGN KEY REFERENCES StreamingPlatform(SPID),
	MovieID INT FOREIGN KEY REFERENCES Movies(MovieID)
)


Instead of creating the table directly like above, I created the MovieStreamingPlatform table by importing
manually entered data from the CSV file on Google Sheets while simultaneously creating a table,
and then made the following modifications to add constraints/references

*/


ALTER TABLE MovieStreamingPlatform
ALTER COLUMN SPID INT;

ALTER TABLE MovieStreamingPlatform
ALTER COLUMN MovieID INT;

ALTER TABLE MovieStreamingPlatform
ADD MSPID INT IDENTITY(1,1) PRIMARY KEY NOT NULL;

ALTER TABLE MovieStreamingPlatform
ADD CONSTRAINT Fk_SPID FOREIGN KEY (SPID) REFERENCES StreamingPlatform(SPID);

ALTER TABLE MovieStreamingPlatform
ADD CONSTRAINT Fk_MovieID FOREIGN KEY (MovieID) REFERENCES Movies(MovieID);

ALTER TABLE MovieStreamingPlatform
ALTER COLUMN MovieID INT NOT NULL;

ALTER TABLE MovieStreamingPlatform
ALTER COLUMN SPID INT NOT NULL;
