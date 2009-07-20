BEGIN;

CREATE TABLE source (
    file_id  SERIAL PRIMARY KEY,
    filename VARCHAR(255) NOT NULL,
    filesize INT NOT NULL,
    sha1     VARCHAR(255) NOT NULL
);

CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    source_id  INT NOT NULL
);

COMMIT;
