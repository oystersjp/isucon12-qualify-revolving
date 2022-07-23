DROP TABLE IF EXISTS competition;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS player_score;

CREATE TABLE competition
(
    id          VARCHAR(255) NOT NULL PRIMARY KEY,
    tenant_id   BIGINT       NOT NULL,
    title       TEXT         NOT NULL,
    finished_at BIGINT NULL,
    created_at  BIGINT       NOT NULL,
    updated_at  BIGINT       NOT NULL
);

CREATE TABLE player
(
    id              VARCHAR(255) NOT NULL PRIMARY KEY,
    tenant_id       BIGINT       NOT NULL,
    display_name    TEXT         NOT NULL,
    is_disqualified BOOLEAN      NOT NULL,
    created_at      BIGINT       NOT NULL,
    updated_at      BIGINT       NOT NULL
);

CREATE TABLE player_score (
  id VARCHAR(255) NOT NULL PRIMARY KEY,
  tenant_id BIGINT NOT NULL,
  player_id VARCHAR(255) NOT NULL,
  competition_id VARCHAR(255) NOT NULL,
  score BIGINT NOT NULL,
  row_num BIGINT NOT NULL,
  created_at BIGINT NOT NULL,
  updated_at BIGINT NOT NULL
);

INSERT INTO competition
SELECT *
FROM old_competition;
INSERT INTO player
SELECT *
FROM old_player;

DROP INDEX idx_tenant_id_competition_id ON player_score;
DELETE FROM player_score;
INSERT INTO player_score SELECT * FROM insert_player_score;
CREATE INDEX idx_tenant_id_competition_id ON player_score (tenant_id);
