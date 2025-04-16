CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    last_name VARCHAR,
    email VARCHAR NOT NULL
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    date DATE NOT NULL,
    location VARCHAR,
    description TEXT
);

CREATE TYPE seat_category AS ENUM ('General', 'Preferencial', 'VIP');
CREATE TYPE seat_status AS ENUM ('Disponible', 'Reservado');

CREATE TABLE seats (
    id SERIAL PRIMARY KEY,
    number VARCHAR NOT NULL,
    category seat_category NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    status seat_status NOT NULL
);

CREATE TABLE reservations (
    id SERIAL PRIMARY KEY,
    seat_id INTEGER NOT NULL,
    event_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    reservation_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (seat_id) REFERENCES seats(id),
    FOREIGN KEY (event_id) REFERENCES events(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TYPE payment_method AS ENUM ('Tarjeta', 'Efectivo', 'Transferencia');

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    reservation_id INTEGER NOT NULL,
    payment_method payment_method NOT NULL,
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reservation_id) REFERENCES reservations(id)
);