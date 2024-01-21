CREATE TABLE IF NOT EXISTS users (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name varchar(250),
    email varchar(254),
    CONSTRAINT UQ_EMAIL UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS categories (
    id Integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name varchar(50),
    CONSTRAINT UQ_NAME UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS locations (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    lat REAL NOT NULL,
    lon REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS events (
     id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     annotation VARCHAR(2000),
     category_id BIGINT REFERENCES categories (id) ON DELETE CASCADE,
     confirmed_requests BIGINT,
     created_on TIMESTAMP,
     description VARCHAR(7000),
     event_date TIMESTAMP WITHOUT TIME ZONE,
     initiator_id BIGINT REFERENCES users (id) ON DELETE CASCADE,
     location_id BIGINT REFERENCES locations (id),
     paid BOOLEAN,
     participant_limit BIGINT,
     published_on TIMESTAMP,
     request_moderation BOOLEAN,
     state VARCHAR(20) ,
     title VARCHAR(120)
);

CREATE INDEX IF NOT EXISTS get_events_public_admin ON events(state, category_id, event_date);

CREATE TABLE IF NOT EXISTS compilations (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    pinned BOOLEAN,
    title varchar
);

CREATE TABLE IF NOT EXISTS compilations_events (
    compilation_id BIGINT REFERENCES compilations (id) ON DELETE CASCADE,
    event_id BIGINT REFERENCES events (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS requests(
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    event_id BIGINT REFERENCES events (id) ON DELETE CASCADE,
    requester_id BIGINT REFERENCES users (id) ON DELETE CASCADE,
    status varchar,
    created timestamp WITHOUT TIME ZONE
);

CREATE INDEX IF NOT EXISTS status_event_id_index ON requests(status, event_id);

CREATE TABLE IF NOT EXISTS comments (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    text varchar,
    event_id BIGINT REFERENCES events (id) ON DELETE CASCADE,
    author_id BIGINT REFERENCES users (id) ON DELETE CASCADE,
    created timestamp WITHOUT TIME ZONE
);