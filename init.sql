CREATE TABLE notes (
  id UUID PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  tags VARCHAR(255)[],
  published BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);

CREATE TABLE audit_events (
  id UUID PRIMARY KEY,
  note_id UUID NOT NULL,
  type VARCHAR(255) NOT NULL,
  at TIMESTAMP NOT NULL,
  meta JSONB NOT NULL
);

INSERT INTO notes (id, title, content, tags, published, created_at, updated_at)
VALUES (
  'c0a8012a-9f9c-4c3b-91a5-5d6a2d3c9c01',
  'Welcome note',
  'This is a seeded note for the Docker Compose demo.',
  ARRAY['demo','compose'],
  true,
  NOW(),
  NOW()
);

INSERT INTO audit_events (id, note_id, type, at, meta)
VALUES (
  'c0a8012a-9f9c-4c3b-91a5-5d6a2d3c9c02',
  'c0a8012a-9f9c-4c3b-91a5-5d6a2d3c9c01',
  'NOTE_PUBLISHED',
  NOW(),
  '{"source":"seed"}'
);