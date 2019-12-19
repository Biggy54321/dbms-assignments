-- DROP DATABASE IF EXISTS `Events`;
-- CREATE DATABASE `Events`;
-- USE `Events`;

-- DROP TABLE IF EXISTS remotecentre;
-- DROP TABLE IF EXISTS person;
-- DROP TABLE IF EXISTS programme;
-- DROP TABLE IF EXISTS coordinator;
-- DROP TABLE IF EXISTS participant;

CREATE TABLE remotecentre (
       `centreId` CHAR(7),
       `college`  VARCHAR(32),
       `town`     VARCHAR(32),
       `state`    VARCHAR(32),
       CONSTRAINT `remotecentre_pk_fmt`
       CHECK (centreId REGEXP "^CTR-[0-9]{3}$"),
       CONSTRAINT `remotecentre_pk`
       PRIMARY KEY (centreId)
);

CREATE TABLE person (
       `ID`    CHAR(7),
       `name`  VARCHAR(64),
       `email` VARCHAR(128),
       CONSTRAINT `person_pk_fmt`
       CHECK (ID REGEXP "^PER-[0-9]{3}$"),
       CONSTRAINT `person_email_fmt`
       CHECK (email REGEXP "^([a-zA-Z0-9]+\.[a-zA-Z0-9]+|[a-zA-Z0-9]+)@[a-zA-Z0-9]+\.[a-zA-Z.]+$"),
       CONSTRAINT `person_pk`
       PRIMARY KEY (ID)
);

CREATE TABLE programme (
       `progId`   CHAR(8),
       `title`    VARCHAR(64),
       `fromdate` DATE,
       `todate`   DATE,
       CONSTRAINT `programme_pk_fmt`
       CHECK (progId REGEXP "^PROG-[0-9]{3}$"),
       CONSTRAINT `programme_pk`
       PRIMARY KEY (progId)
);

CREATE TABLE coordinator (
       `ID`       CHAR(7),
       `progId`   CHAR(8),
       `centreId` CHAR(7),
       CONSTRAINT `coordinator_pk`
       PRIMARY KEY (ID, progId, centreId),
       CONSTRAINT `coordinator_fk1`
       FOREIGN KEY (ID) REFERENCES person (ID) ON DELETE CASCADE,
       CONSTRAINT `coordinator_fk2`
       FOREIGN KEY (progId) REFERENCES programme (progId) ON DELETE CASCADE,
       CONSTRAINT `coordinator_fk3`
       FOREIGN KEY (centreId) REFERENCES remotecentre (centreId) ON DELETE CASCADE
);

CREATE TABLE participant (
       `ID`       CHAR(7),
       `progId`   CHAR(8),
       `centreId` CHAR(7),
       CONSTRAINT `participant_pk`
       PRIMARY KEY (ID, progId, centreId),
       CONSTRAINT `participant_fk1`
       FOREIGN KEY (ID) REFERENCES person (ID) ON DELETE CASCADE,
       CONSTRAINT `participant_fk2`
       FOREIGN KEY (progId) REFERENCES programme (progId) ON DELETE CASCADE,
       CONSTRAINT `participant_fk3`
       FOREIGN KEY (centreId) REFERENCES remotecentre (centreId) ON DELETE CASCADE
);
