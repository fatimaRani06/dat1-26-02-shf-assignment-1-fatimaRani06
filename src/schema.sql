.open fittrackpro.db
.mode column
-- ============================
-- LOCATIONS
-- ============================
CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    opening_hours VARCHAR(50)
);

-- ============================
-- MEMBERS
-- ============================
CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    date_of_birth DATE,
    join_date DATE NOT NULL,
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20)
);

-- ============================
-- STAFF
-- ============================
CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    position VARCHAR(50) CHECK (position IN ('Trainer','Manager','Receptionist','Maintenance')),
    hire_date DATE NOT NULL,
    location_id INT REFERENCES locations(location_id)
);

-- ============================
-- EQUIPMENT
-- ============================
CREATE TABLE equipment (
    equipment_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) CHECK (type IN ('Cardio','Strength')),
    purchase_date DATE,
    last_maintenance_date DATE,
    next_maintenance_date DATE,
    location_id INT REFERENCES locations(location_id)
);

-- ============================
-- CLASSES
-- ============================
CREATE TABLE classes (
    class_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    capacity INT CHECK (capacity > 0),
    duration INT CHECK (duration > 0),
    location_id INT REFERENCES locations(location_id)
);

-- ============================
-- CLASS SCHEDULE
-- ============================
CREATE TABLE class_schedule (
    schedule_id SERIAL PRIMARY KEY,
    class_id INT REFERENCES classes(class_id),
    staff_id INT REFERENCES staff(staff_id),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL
);

-- ============================
-- MEMBERSHIPS
-- ============================
CREATE TABLE memberships (
    membership_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    type VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(20) CHECK (status IN ('Active','Inactive'))
);

-- ============================
-- ATTENDANCE
-- ============================
CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    location_id INT REFERENCES locations(location_id),
    check_in_time TIMESTAMP NOT NULL,
    check_out_time TIMESTAMP
);

-- ============================
-- CLASS ATTENDANCE
-- ============================
CREATE TABLE class_attendance (
    class_attendance_id SERIAL PRIMARY KEY,
    schedule_id INT REFERENCES class_schedule(schedule_id),
    member_id INT REFERENCES members(member_id),
    attendance_status VARCHAR(20) CHECK (attendance_status IN ('Registered','Attended','Unattended'))
);

-- ============================
-- PAYMENTS
-- ============================
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP NOT NULL,
    payment_method VARCHAR(50) CHECK (payment_method IN ('Credit Card','Bank Transfer','PayPal')),
    payment_type VARCHAR(100) CHECK (payment_type IN ('Monthly membership fee','Day pass'))
);

-- ============================
-- PERSONAL TRAINING SESSIONS
-- ============================
CREATE TABLE personal_training_sessions (
    session_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    staff_id INT REFERENCES staff(staff_id),
    session_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    notes TEXT
);

-- ============================
-- MEMBER HEALTH METRICS
-- ============================
CREATE TABLE member_health_metrics (
    metric_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    measurement_date DATE NOT NULL,
    weight DECIMAL(5,2),
    body_fat_percentage DECIMAL(5,2),
    muscle_mass DECIMAL(5,2),
    bmi DECIMAL(5,2)
);

-- ============================
-- EQUIPMENT MAINTENANCE LOG
-- ============================
CREATE TABLE equipment_maintenance_log (
    log_id SERIAL PRIMARY KEY,
    equipment_id INT REFERENCES equipment(equipment_id),
    maintenance_date DATE NOT NULL,
    description TEXT,
    staff_id INT REFERENCES staff(staff_id)
);