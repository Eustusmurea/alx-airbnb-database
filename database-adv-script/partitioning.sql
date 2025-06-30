-- Step 1: Rename original bookings table to keep data
ALTER TABLE bookings RENAME TO bookings_old;

-- Step 2: Create new partitioned bookings table
CREATE TABLE bookings (
    booking_id UUID NOT NULL,
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    total_price NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (property_id) REFERENCES properties(property_id)
) PARTITION BY RANGE (start_date);

-- Step 3: Create partitions by year
CREATE TABLE bookings_2022 PARTITION OF bookings
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE bookings_2023 PARTITION OF bookings
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_future PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2100-01-01');

-- Step 4: Insert old data into partitions
INSERT INTO bookings
SELECT * FROM bookings_old;
