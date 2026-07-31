-- Initial schema for Home Improvement Tracker
-- This migration creates the base tables for the application

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS homes (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    year_built INTEGER,
    square_feet INTEGER,
    purchase_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS room_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS rooms (
    id SERIAL PRIMARY KEY,
    home_id INTEGER NOT NULL REFERENCES homes(id) ON DELETE CASCADE,
    room_type_id INTEGER REFERENCES room_types(id) ON DELETE SET NULL,
    name VARCHAR(255) NOT NULL,
    square_feet INTEGER,
    floor_level INTEGER,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS paint_colors (
    id SERIAL PRIMARY KEY,
    color_code VARCHAR(50) NOT NULL,
    brand VARCHAR(100),
    base_name VARCHAR(255),
    finish VARCHAR(50),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uc_paint_color_brand UNIQUE (color_code, brand)
);

CREATE TABLE IF NOT EXISTS painting_instructions (
    room_id INTEGER NOT NULL REFERENCES rooms(id) ON DELETE CASCADE,
    paint_color_id INTEGER NOT NULL REFERENCES paint_colors(id) ON DELETE CASCADE,
    notes TEXT,
    date_applied DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (room_id, paint_color_id)
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_homes_user_id ON homes(user_id);
CREATE INDEX IF NOT EXISTS idx_rooms_home_id ON rooms(home_id);
CREATE INDEX IF NOT EXISTS idx_rooms_room_type_id ON rooms(room_type_id);
CREATE INDEX IF NOT EXISTS idx_paint_colors_brand ON paint_colors(brand);
CREATE INDEX IF NOT EXISTS idx_painting_instructions_paint_color_id ON painting_instructions(paint_color_id);
