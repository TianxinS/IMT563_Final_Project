/*--------------------- FETCHING STREAMING PLATFORMS----------------------*/

CREATE FUNCTION StreamPlat(@mov VARCHAR(100))
RETURNS TABLE AS
RETURN
	SELECT m.MovieTitle, sp.SPName
	FROM StreamingPlatform sp
	JOIN MovieStreamingPlatform msp
	ON sp.SPID = msp.SPID
	JOIN Movies m
	ON msp.MovieID = m.MovieID
	WHERE m.MovieTitle LIKE '%' + @mov + '%'


SELECT *
FROM StreamPlat('Finding Nemo');



/*---------------------RECOMMENDATION BASED ON A SINGLE MOVIE---------------------*/

CREATE FUNCTION SimMov (@sim VARCHAR(100))
RETURNS TABLE
AS
RETURN
SELECT m2.MovieTitle
FROM Movies m
JOIN Similar_Movie sm
ON m.MovieID = sm.MovieID
JOIN Movies m2
ON sm.SimilarMovieID = m2.MovieID
WHERE m.MovieTitle = @sim


SELECT *
FROM SimMov('Avengers: Endgame')



/*------------------RECOMMENDATION BASED ON TWO MOVIES---------------------*/

CREATE FUNCTION SimMov2 (@sim1 VARCHAR(100), @sim2 VARCHAR(100))
RETURNS TABLE
AS
RETURN
SELECT DISTINCT m2.MovieTitle
FROM Movies m
JOIN Similar_Movie sm
ON m.MovieID = sm.MovieID
JOIN Movies m2
ON sm.SimilarMovieID = m2.MovieID
WHERE m.MovieTitle = @sim1 OR m.MovieTitle = @sim2



/*-----------------------RECOMMENDATION BASED ON THREE MOVIES-----------------*/

CREATE FUNCTION SimMov3 (@sim1 VARCHAR(100), @sim2 VARCHAR(100), @sim3 VARCHAR(100))
RETURNS TABLE
AS
RETURN
SELECT DISTINCT m2.MovieTitle
FROM Movies m
JOIN Similar_Movie sm
ON m.MovieID = sm.MovieID
JOIN Movies m2
ON sm.SimilarMovieID = m2.MovieID
WHERE m.MovieTitle = @sim1 OR m.MovieTitle = @sim2 OR m.MovieTitle = @sim3


/*----------------------FETCHING MOVIE REVIEWS---------------------------*/

CREATE FUNCTION MovReview(@movr VARCHAR(100))
RETURNS TABLE
AS
RETURN
SELECT mr.MovieReviewDesc, mr.Author
FROM Movies m
JOIN MovieReviews mr
ON m.MovieID = mr.MovieID
WHERE m.MovieTitle = @movr


SELECT *
FROM MovReview ('The Avengers')

