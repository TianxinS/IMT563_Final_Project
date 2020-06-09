
SELECT * FROM Movies


/*-----------------------I-------------------------*/

------------FOR STREAMING PLATFORMS--------------

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


------------------PSEUDOCODE--------------------

/* 
	INPUT Movie that user has entered
	PASS Movie ==> @mov
	RUN the function retrieve Streaming Platforms
*/

------------WEBSITE FUNCTIONING--------------------
SELECT *
FROM StreamPlat(@mov);


------------EXAMPLE FOR DEMO------------------------
SELECT *
FROM StreamPlat('Finding Nemo');

SELECT *
FROM StreamPlat('Avengers: Infinity War');



/*--------------------------------II-------------------------------------------*/


---------FOR MOVIE RECOMMENDATIONS--------

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


------------------PSEUDOCODE--------------------

/* 
	INPUT Movie that user has entered
	PASS Movie ==> @sim
	RUN the function to retrieve Movie Recommendations
*/


------------------WEBSITE FUNCTIONING------------
SELECT * 
FROM SimMov(@sim)


-----------------EXAMPLE FOR DEMO-----------------
SELECT * 
FROM SimMov('The Avengers')



---------------IN CASE OF RECOMMENDATION BASED ON MULTIPLE MOVIES (MAX 3)---------------

---------PSEUDOCODE---------

/*
	IF Movies entered by User = 1, 
		RUN SimMov (@sim)

	IF Movies entered by User = 2,
		RUN SimMov2 (@sim1, @sim2)

	IF Movies entered by User = 3,
		RUN SimMov3 (@sim1, @sim2, @sim3)
*/




/*------------------------------III--------------------------*/

--------FOR MOVIE REVIEWS--------------
CREATE FUNCTION MovReview(@movr VARCHAR(100))
RETURNS TABLE
AS
RETURN
SELECT mr.MovieReviewDesc, mr.Author
FROM Movies m
JOIN MovieReviews mr
ON m.MovieID = mr.MovieID
WHERE m.MovieTitle = @movr


------------------PSEUDOCODE--------------------

/* 
	INPUT Movie that user has entered
	PASS Movie ==> @movr
	RUN the function to retrieve Movie Reviews and their Author
*/



----------------WEBSITE FUNCTIONING-----------
SELECT *
FROM MovReview(@movr)



----------------EXAMPLE FOR DEMO-----------
SELECT *
FROM MovReview('The Avengers')

