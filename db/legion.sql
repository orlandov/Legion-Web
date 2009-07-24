BEGIN;

CREATE TABLE source (
    source_id SERIAL PRIMARY KEY,
    filename  VARCHAR(255) NOT NULL,
    filesize  INT NOT NULL,
    sha1      VARCHAR(255) NOT NULL
);

CREATE TABLE renderjob (
    renderjob_id SERIAL PRIMARY KEY,
    source_id    INT NOT NULL REFERENCES source ON DELETE RESTRICT
);

COMMIT;
