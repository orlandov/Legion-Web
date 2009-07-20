BEGIN;

CREATE TABLE "Source" (
    file_id  SERIAL,
    sha1     VARCHAR(255) NOT NULL,
    filename VARCHAR(255) NOT NULL,

    UNIQUE(filename)
);

CREATE TABLE "Project" (
    renderjob_id SERIAL,
    user_id      INT NOT NULL,
    file_id      INT NOT NULL
);

CREATE TABLE "User" (
    user_id SERIAL,
    email   VARCHAR(255) NOT NULL
);

COMMIT;
