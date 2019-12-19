-- 1
SELECT stcode1, stcode2
FROM track
WHERE distance < 20;

-- 2
SELECT trainhalts.id
FROM trainhalts, station
WHERE station.name = "Thane"
      AND trainhalts.stcode = station.stcode;

-- 3
SELECT DISTINCT train.name
FROM train, trainhalts, station
WHERE station.name = "Mumbai" AND
      station.stcode = trainhalts.stcode AND
      trainhalts.id = train.id;

-- 4
SELECT station.name
FROM station, trainhalts, train
WHERE train.name = "CST-AMR_LOCAL" AND
      train.id = trainhalts.id AND
      trainhalts.stcode = station.stcode;
