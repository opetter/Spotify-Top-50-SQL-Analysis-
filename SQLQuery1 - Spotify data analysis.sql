--Doing inital table analyis to understand the data and its ordering 
Select *
From Projects..SpotifyTopSongsByCountry
--the duration appears to have added a date infront of the duration time (which is measured in minutes)
--note: there is no date infront of duration in the raw excel data

--intial table analysis: all data consist of top 50 songs sorted by country, song title, song artists, the album the song is located on, and if the song contains explicit language (0=False, 1=True)
-- Note: Many titles/Artists do not translate properly into english from native languages so symbols do appear

--Looking at how popular each artist is on each country 
Select Country, Rank, Artists
From Projects..SpotifyTopSongsByCountry
Where Country != 'Global'


--Lets look at how often each artist makes the top 50 (across the whole data set)
Select COUNT(Artists) as ArtistsFrequency, Artists
From Projects..SpotifyTopSongsByCountry
Where Country != 'Global' 
Group By Artists
Order By COUNT(Artists) DESC
-- Note: Some artist columns show two artists, this is due to the associated song in the top 50 charts being produced by both artist

--Now lets look how often artists with solo songs make the top 50 (across the whole data set)
Select COUNT(Artists) as ArtistsFrequency, Artists
From Projects..SpotifyTopSongsByCountry
Where Country != 'Global' and Artists NOT LIKE '%,%'
Group By Artists
Order By COUNT(Artists) DESC

--Now lets do the same but for all artists collaborations 
Select COUNT(Artists) as ArtistsFrequency, Artists
From Projects..SpotifyTopSongsByCountry
Where Country != 'Global' and Artists LIKE '%,%'
Group By Artists
Order By COUNT(Artists) DESC

--Now lets explore the percentage of excplict/non-explicit songs that make it onto the top 50

Select SUM(Explicit)/3150 as PercentageOfExplicitSongs, 1-SUM(Explicit)/3150 as PercentageOfNonExplicitSongs
From Projects..SpotifyTopSongsByCountry
Where Country != 'Global' and Explicit = 1

--What is the percentage of explicit and non-explicit in each country?

Select SUM(Explicit)/50 as PercentageOfExplicitSongs, 1-SUM(Explicit)/50 as PercentageOfNonExplicitSongs, Country
From Projects..SpotifyTopSongsByCountry
Where Country != 'Global' and Explicit = 1
Group By Country 
--This gives us good insight into how each country prefers their music in regards to songs thats have explicit lyrics in them

--Lets investigate song duration 
Select (Cast (Duration as time))
From Projects..SpotifyTopSongsByCountry
Where Country != 'Global'

Select MAX(Cast (Duration as time)) as LongestSong, MIN(Cast (Duration as Time)) as ShortestSong, Country 
From Projects..SpotifyTopSongsByCountry
Where Country != 'Global'
Group By Country
Order By Country

-- Majority of countries shortest songs fall around 2 minutes and their longest songs around 5 minutes (with outliers)

-- For my final intial analysis I want to see how ofetn artist make the top 50 in each country 

Select COUNT(Artists) as ArtistFrequncyInCountry, Country, Artists  
From Projects..SpotifyTopSongsByCountry
Where Country != 'Global' and Artists NOT LIKE '%,%'
Group By Country, Artists
Order By Country, COUNT(Artists) DESC




