-- A
-- add constraint
ALTER TABLE trainhalts
ADD CONSTRAINT `timein_less_timeout`
CHECK (cast(timein as float) < cast(timeout as float));
-- check
SELECT *
FROM information_schema.table_constraints
WHERE table_name = "trainhalts";

-- add constraint
ALTER TABLE trainhalts
ADD CONSTRAINT `trainhalts_fk`
FOREIGN KEY (id) REFERENCES train(id) ON DELETE CASCADE;
-- check
SELECT *
FROM information_schema.table_constraints
WHERE table_name = "trainhalts";

-- validate the constraints
INSERT INTO trainhalts
VALUES ("KP11", "10", "KYN", "22.12", "12.51");
INSERT INTO trainhalts
VALUES ("KP11", "10", "KYN", "10.22", "12.51");

SELECT *
FROM trainhalts;
DELETE FROM train
WHERE id = "KP11";
SELECT *
FROM trainhalts;

