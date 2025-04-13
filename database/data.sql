-- Insertar usuarios
INSERT INTO users (name, last_name, email) VALUES
('Juan', 'Pérez', 'juan.perez@example.com'),
('María', 'Gómez', 'maria.gomez@example.com'),
('Carlos', 'López', 'carlos.lopez@example.com'),
('Ana', 'Martínez', 'ana.martinez@example.com'),
('Pedro', 'Rodríguez', 'pedro.rodriguez@example.com'),
('Laura', 'Sánchez', 'laura.sanchez@example.com'),
('Miguel', 'Fernández', 'miguel.fernandez@example.com'),
('Sofía', 'Díaz', 'sofia.diaz@example.com'),
('David', 'Hernández', 'david.hernandez@example.com'),
('Elena', 'Ruiz', 'elena.ruiz@example.com');

-- Insertar eventos
INSERT INTO events (name, date, location, description) VALUES
('Concierto de Rock Internacional', '2023-12-15', 'Estadio Nacional', 'El mejor concierto del año con bandas internacionales de rock'),
('Teatro Clásico: Hamlet', '2023-11-20', 'Teatro Municipal', 'Obra clásica de Shakespeare con actores reconocidos'),
('Festival de Jazz', '2023-10-05', 'Plaza Central', 'Tres días de jazz con artistas nacionales e internacionales');

-- Insertar asientos para el concierto (evento 1)
INSERT INTO seats (number, category, price, status) VALUES
-- Asientos VIP
('VIP-101', 'VIP', 500.00, 'Disponible'),
('VIP-102', 'VIP', 500.00, 'Disponible'),
('VIP-103', 'VIP', 500.00, 'Disponible'),
('VIP-104', 'VIP', 500.00, 'Disponible'),
('VIP-105', 'VIP', 500.00, 'Disponible'),
('VIP-106', 'VIP', 500.00, 'Disponible'),
('VIP-107', 'VIP', 500.00, 'Disponible'),
('VIP-108', 'VIP', 500.00, 'Disponible'),
('VIP-109', 'VIP', 500.00, 'Disponible'),
('VIP-110', 'VIP', 500.00, 'Disponible'),

-- Asientos Preferenciales
('PREF-201', 'Preferencial', 300.00, 'Disponible'),
('PREF-202', 'Preferencial', 300.00, 'Disponible'),
('PREF-203', 'Preferencial', 300.00, 'Disponible'),
('PREF-204', 'Preferencial', 300.00, 'Disponible'),
('PREF-205', 'Preferencial', 300.00, 'Disponible'),
('PREF-206', 'Preferencial', 300.00, 'Disponible'),
('PREF-207', 'Preferencial', 300.00, 'Disponible'),
('PREF-208', 'Preferencial', 300.00, 'Disponible'),
('PREF-209', 'Preferencial', 300.00, 'Disponible'),
('PREF-210', 'Preferencial', 300.00, 'Disponible'),
('PREF-211', 'Preferencial', 300.00, 'Disponible'),
('PREF-212', 'Preferencial', 300.00, 'Disponible'),
('PREF-213', 'Preferencial', 300.00, 'Disponible'),
('PREF-214', 'Preferencial', 300.00, 'Disponible'),
('PREF-215', 'Preferencial', 300.00, 'Disponible'),
('PREF-216', 'Preferencial', 300.00, 'Disponible'),
('PREF-217', 'Preferencial', 300.00, 'Disponible'),
('PREF-218', 'Preferencial', 300.00, 'Disponible'),
('PREF-219', 'Preferencial', 300.00, 'Disponible'),
('PREF-220', 'Preferencial', 300.00, 'Disponible'),

-- Asientos Generales
('GEN-301', 'General', 150.00, 'Disponible'),
('GEN-302', 'General', 150.00, 'Disponible'),
('GEN-303', 'General', 150.00, 'Disponible'),
('GEN-304', 'General', 150.00, 'Disponible'),
('GEN-305', 'General', 150.00, 'Disponible'),
('GEN-306', 'General', 150.00, 'Disponible'),
('GEN-307', 'General', 150.00, 'Disponible'),
('GEN-308', 'General', 150.00, 'Disponible'),
('GEN-309', 'General', 150.00, 'Disponible'),
('GEN-310', 'General', 150.00, 'Disponible'),
('GEN-311', 'General', 150.00, 'Disponible'),
('GEN-312', 'General', 150.00, 'Disponible'),
('GEN-313', 'General', 150.00, 'Disponible'),
('GEN-314', 'General', 150.00, 'Disponible'),
('GEN-315', 'General', 150.00, 'Disponible'),
('GEN-316', 'General', 150.00, 'Disponible'),
('GEN-317', 'General', 150.00, 'Disponible'),
('GEN-318', 'General', 150.00, 'Disponible'),
('GEN-319', 'General', 150.00, 'Disponible'),
('GEN-320', 'General', 150.00, 'Disponible'),
('GEN-321', 'General', 150.00, 'Disponible'),
('GEN-322', 'General', 150.00, 'Disponible'),
('GEN-323', 'General', 150.00, 'Disponible'),
('GEN-324', 'General', 150.00, 'Disponible'),
('GEN-325', 'General', 150.00, 'Disponible'),
('GEN-326', 'General', 150.00, 'Disponible'),
('GEN-327', 'General', 150.00, 'Disponible'),
('GEN-328', 'General', 150.00, 'Disponible'),
('GEN-329', 'General', 150.00, 'Disponible'),
('GEN-330', 'General', 150.00, 'Disponible');

-- Insertar reservas para el concierto
INSERT INTO reservations (seat_id, event_id, user_id) VALUES
-- Reservas VIP
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),

-- Reservas Preferenciales
(11, 1, 4),
(12, 1, 5),
(13, 1, 6),
(14, 1, 7),

-- Reservas Generales
(21, 1, 8),
(22, 1, 9),
(23, 1, 10),
(24, 1, 1),
(25, 1, 2);

-- Actualizar el estado de los asientos reservados
UPDATE seats SET status = 'Reservado' WHERE id IN (1, 2, 3, 11, 12, 13, 14, 21, 22, 23, 24, 25);

-- Insertar pagos para las reservas
INSERT INTO payments (reservation_id, payment_method) VALUES
(1, 'Tarjeta'),
(2, 'Transferencia'),
(3, 'Efectivo'),
(4, 'Tarjeta'),
(5, 'Tarjeta'),
(6, 'Transferencia'),
(7, 'Efectivo'),
(8, 'Tarjeta'),
(9, 'Transferencia'),
(10, 'Efectivo'),
(11, 'Tarjeta'),
(12, 'Transferencia');