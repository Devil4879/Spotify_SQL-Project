-- Adavnce SQL Project 
-- Spotify Datasets
-- create table 
DROP TABLE IF EXISTS spotify;CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);
-- EDA
SELECT * FROM public.spotify
LIMIT 100
SELECT COUNT(*) FROM spotify;
SELECT COUNT (DISTINCT artist) FROM Spotify;
SELECT DISTINCT album_type FROM spotify;
SELECT duration_min FROM spotify;
SELECT duration_max FROM spotify;
SELECT MAX(duration_min) FROM spotify;
select * from spotify
where duration_min =0;
delete from spotify where duration_min=0;
select distinct channel from spotify;
select distinct most_played_on from spotify
--DATA ANALYSIS - EASY CATEGORY
-- Retrieve the names of all tracks that have more than 1 billionstreams.
select *from spotify
where stream>1000000000;
-- List all albums along with their respective artists.
select distinct album,artist
from spotify
group by 1;
select distinct album
from spotify
group by 1;

-- Get the total number of comments for tracks where licensed = TRUE.

select sum(comments)  as total_comments from spotify 
where licensed='true';
-- Find all tracks that belong to the album type single.
select  * from spotify
where album_type ='single'; 
-- Count the total number of tracks by each artist.
select artist ,
count(*) as total_no_songs
from spotify
group by artist
order by 2 desc;

-- Medium Level
-- Calculate the average danceability of tracks in each album.
select album,avg(danceability) as avg_danceability
from spotify
group by 1
order by 2 desc;
-- Find the top 5 tracks with the highest energy values.
select
track,
avg(energy)
from spotify
group by 1
order by 2 desc limit 5;
distinct track

-- List all tracks along with their views and likes where official_video = TRUE.
SELECT
  track,
  SUM(views) AS total_views,
  SUM(likes) AS total_likes
FROM spotify
WHERE official_video = 'true'
GROUP BY track
ORDER BY total_views DESC
LIMIT 5;

-- For each album, calculate the total views of all associated tracks.
select album,track,sum(views)
from spotify
group by 1,2
order by 3 desc;
-- Retrieve the track names that have been streamed on Spotify more than YouTube.
select 
track,
-- most_played_on,
SUM(CASE WHEN most_played_on = 'YouTube' THEN stream END) as streamed_on_youtube,
SUM(CASE WHEN most_played_on = 'spotify' THEN stream END) as streamed_on_spotify
from spotify
group by 1

-- Find the top 3 most-viewed tracks for each artist using window functions.
with ranking_artist
as
(select artist,track,sum(views)as total_views,
dense_rank()over(partition by artist order by sum(views)desc)as rank
from spotify
group by 1,2
order by 1,3 desc)
select * from ranking_artist
where rank<=3;

-- Write a query to find tracks where the liveness score is above the average.
-- Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
