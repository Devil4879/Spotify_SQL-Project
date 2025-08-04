# 🎵 Spotify Data Analysis – Advanced SQL Project

## 📌 Project Overview

**Project Title**: Spotify Data Analysis and Query Optimization
**Level**: Intermediate – Advanced
**Database**: spotify\_db

This project showcases advanced SQL capabilities by analyzing a Spotify dataset containing detailed track, album, and artist information. The focus is on querying, optimizing, and deriving insights from the dataset while applying real-world database optimization techniques.

---

## 🎯 Objectives

* **Data Understanding**: Analyze musical and streaming attributes like danceability, energy, views, and streams.
* **Query Practice**: Strengthen SQL skills with categorized easy, medium, and advanced questions.
* **Query Optimization**: Demonstrate SQL performance tuning with indexing and EXPLAIN ANALYZE.
* **Insight Generation**: Derive data-driven insights from structured music data.

---

## 🗂 Project Structure

### 1. Database Setup

A single denormalized table called `spotify` is used.

```sql
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
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
```

---

## 🔢 SQL Practice Questions

### 🟢 Easy Level

1. Tracks with more than 1 billion streams
2. List all albums and their respective artists
3. Total comments on licensed tracks
4. Tracks in album type "single"
5. Count of tracks per artist

### 🟡 Medium Level

1. Average danceability by album
2. Top 5 tracks by energy
3. Tracks with `official_video = TRUE` including views and likes
4. Total views per album
5. Tracks streamed more on Spotify than YouTube

### 🔴 Advanced Level

1. Top 3 most-viewed tracks per artist using window functions
2. Tracks with liveness above the global average
3. Energy difference within albums using CTE:

```sql
WITH cte AS (
  SELECT album,
         MAX(energy) AS highest_energy,
         MIN(energy) AS lowest_energy
  FROM spotify
  GROUP BY album
)
SELECT album,
       highest_energy - lowest_energy AS energy_diff
FROM cte
ORDER BY energy_diff DESC;
```

4. Tracks with energy-to-liveness ratio > 1.2
5. Cumulative likes ordered by views using window functions

---

## ⚖️ Query Optimization

### 🔍 Before Optimization

* Query: `SELECT * FROM spotify WHERE artist = 'Drake';`
* Execution Time: **7.000 ms**
* Planning Time: **0.170 ms**

### ⚙️ Index Creation

```sql
CREATE INDEX idx_artist ON spotify(artist);
```

### ⚡ After Optimization

* Execution Time: **0.153 ms**
* Planning Time: **0.152 ms**
* Result: \~46x improvement in performance

---

## 🧪 How to Use

1. Install PostgreSQL and a SQL client (pgAdmin or any IDE).
2. Set up the database and import the table structure.
3. Load the dataset into the `spotify` table.
4. Run categorized SQL queries.
5. Apply indexing and use `EXPLAIN ANALYZE` for performance testing.

---

## 🛠️ Technology Stack

* **Database**: PostgreSQL
* **SQL**: Aggregations, Joins, Window Functions, Indexing
* **Tools**: PostgreSQL CLI, pgAdmin, or any SQL IDE

---

## 📊 Next Steps

* Create data visualizations in Tableau or Power BI
* Scale the dataset for more complex analysis
* Experiment with materialized views or query partitions

---

## 👨‍💼 Author

**Rahul Jangra**
This project is part of my data analyst portfolio to demonstrate advanced SQL, performance tuning, and analytics on real-world data.
