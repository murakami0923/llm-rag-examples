CREATE EXTENSION IF NOT EXISTS vector;
 
CREATE TABLE IF NOT EXISTS items (
  id SERIAL PRIMARY KEY,
  embedding VECTOR(3),
  description TEXT
);
 
TRUNCATE items;
 
-- INSERT INTO items (embedding, description) VALUES
-- ('[0.8549,-0.4251,0.2981]', '正の感情を持つテキスト'),
-- ('[-0.7403,0.2845,0.6079]', '負の感情を持つテキスト'),
-- ('[0.1257,0.9124,-0.3891]', '中立的なテキスト');
 
-- SELECT * FROM items;