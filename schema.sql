CREATE TABLE IF NOT EXISTS services (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    url TEXT NOT NULL,
    timeout_seconds REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS checks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    service_id INTEGER NOT NULL,
    checked_at TEXT NOT NULL,
    http_status INTEGER,
    latency_ms INTEGER,
    status TEXT NOT NULL,
    error_message TEXT,
    FOREIGN KEY (service_id) REFERENCES services(id)
);

CREATE TABLE IF NOT EXISTS current_status (
    service_id INTEGER PRIMARY KEY,
    status TEXT NOT NULL,
    last_checked_at TEXT NOT NULL,
    last_change_at TEXT NOT NULL,
    last_latency_ms INTEGER,
    last_http_status INTEGER,
    last_error_message TEXT,
    FOREIGN KEY (service_id) REFERENCES services(id)
);

CREATE TABLE IF NOT EXISTS incidents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    service_id INTEGER NOT NULL,
    started_at TEXT NOT NULL,
    resolved_at TEXT,
    start_status TEXT NOT NULL,
    end_status TEXT,
    summary TEXT,
    FOREIGN KEY (service_id) REFERENCES services(id)
);