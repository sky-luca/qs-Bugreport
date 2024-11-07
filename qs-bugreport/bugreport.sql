-- Create the players table (if not already created)
CREATE TABLE IF NOT EXISTS players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create the bug_reports table with foreign key constraint
CREATE TABLE IF NOT EXISTS bug_reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    description TEXT NOT NULL,
    steps TEXT NOT NULL,
    category VARCHAR(50) NOT NULL,
    priority VARCHAR(20) NOT NULL,
    contact_info TEXT,
    reproduction_checklist TEXT,
    coords JSON NOT NULL,
    reported_at INT NOT NULL,
    status VARCHAR(50) DEFAULT 'New',
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE
);
