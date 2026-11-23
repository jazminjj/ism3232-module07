CREATE TABLE IF NOT EXISTS donors (
    donor_id   TEXT PRIMARY KEY,
    name       TEXT NOT NULL,
    donor_type TEXT NOT NULL,
    status     TEXT NOT NULL
);

INSERT OR IGNORE INTO donors (donor_id, name, donor_type, status) VALUES
    ('D100', 'Sample Foundation',        'foundation', 'active'),
    ('D101', 'Bayview Community Fund',   'foundation', 'active'),
    ('D102', 'Tech Forward Corp',        'corporate',  'active'),
    ('D103', 'Maria Alvarez',            'individual', 'active'),
    ('D104', 'Greenway Credit Union',    'corporate',  'lapsed'),
    ('D105', 'Robert Chen',              'individual', 'active');

CREATE TABLE IF NOT EXISTS donations (
    donation_id TEXT PRIMARY KEY,
    donor_id    TEXT NOT NULL,
    amount      REAL NOT NULL,
    gift_date   TEXT NOT NULL,
    gift_type   TEXT NOT NULL
);

INSERT OR IGNORE INTO donations (donation_id, donor_id, amount, gift_date, gift_type) VALUES
    ('G1001', 'D100', 25000.00, '2026-10-15', 'grant'),
    ('G1002', 'D101', 10000.00, '2026-10-03', 'grant'),
    ('G1003', 'D102',  5000.00, '2026-09-20', 'sponsorship'),
    ('G1004', 'D103',   250.00, '2026-10-28', 'individual'),
    ('G1005', 'D104',  1500.00, '2025-12-12', 'sponsorship'),
    ('G1006', 'D105',   100.00, '2026-11-05', 'individual'),
    ('G1007', 'D100', 15000.00, '2026-03-10', 'grant');

CREATE TABLE IF NOT EXISTS schools (
    school_id       TEXT PRIMARY KEY,
    name            TEXT NOT NULL,
    district        TEXT NOT NULL,
    status          TEXT NOT NULL,
    students_served INTEGER NOT NULL
);

INSERT OR IGNORE INTO schools (school_id, name, district, status, students_served) VALUES
    ('S100', 'Sample Elementary',    'Sample District',  'active',   60),
    ('S101', 'Lincoln Middle',       'Hillsborough',     'active',   85),
    ('S102', 'Riverside Elementary', 'Hillsborough',     'active',   45),
    ('S103', 'Oakwood Academy',      'Pinellas',         'paused',   30),
    ('S104', 'Harbor High',          'Pinellas',         'pipeline', 0),
    ('S105', 'Magnolia Elementary',  'Pasco',            'pipeline', 0);
    
CREATE TABLE IF NOT EXISTS quiz_results (
    result_id       TEXT PRIMARY KEY,
    school_id       TEXT NOT NULL,
    lab_name        TEXT NOT NULL,
    quiz_type       TEXT NOT NULL,
    avg_score       REAL NOT NULL,
    students_tested INTEGER NOT NULL
);

INSERT OR IGNORE INTO quiz_results (result_id, school_id, lab_name, quiz_type, avg_score, students_tested) VALUES
    ('Q1', 'S100', 'Intro to Coding', 'pre',  48.0, 28),
    ('Q2', 'S100', 'Intro to Coding', 'post', 71.5, 27),
    ('Q3', 'S101', 'Robotics Basics', 'pre',  52.3, 30),
    ('Q4', 'S101', 'Robotics Basics', 'post', 74.8, 29),
    ('Q5', 'S102', 'Intro to Coding', 'pre',  44.6, 22),
    ('Q6', 'S102', 'Intro to Coding', 'post', 66.1, 21);

CREATE TABLE IF NOT EXISTS change_requests (
    number    INTEGER PRIMARY KEY AUTOINCREMENT,
    school_id TEXT NOT NULL,
    new_value TEXT NOT NULL,
    status    TEXT NOT NULL DEFAULT 'waiting'
);
