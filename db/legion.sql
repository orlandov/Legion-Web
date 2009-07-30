BEGIN;

CREATE TABLE source (
    source_id SERIAL PRIMARY KEY,
    filename  VARCHAR(255) NOT NULL,
    filesize  INT NOT NULL,
    sha1      VARCHAR(255) NOT NULL
);

CREATE TABLE renderjob (
    renderjob_id SERIAL PRIMARY KEY,
    source_id    INT NOT NULL REFERENCES source ON DELETE RESTRICT,
    status       VARCHAR(255) NOT NULL
);

CREATE TABLE frame (
    frame_id       SERIAL PRIMARY KEY,
    frame_number   INT NOT NULL,
    renderjob_id   INT NOT NULL REFERENCES renderjob ON DELETE CASCADE,
    sha1           VARCHAR(255),
    render_elapsed FLOAT,
    status         VARCHAR(255)
);

COMMIT;
