CREATE DATABASE belajar_mysql_notification;

CREATE TABLE user
(
    id   VARCHAR(100),
    name VARCHAR(100),
    primary key (id)
) ENGINE = innodb;

SHOW TABLES;

INSERT INTO user
VALUES ('ilham', 'Ilham adi Irawan');
INSERT INTO user
VALUES ('adi', 'adi Irawan');

SELECT *
from user;

-- Notification

CREATE TABLE notification
(
    id         INT          NOT NULL AUTO_INCREMENT,
    title      VARCHAR(100) NOT NULL,
    detail     TEXT         NOT NULL,
    created_at TIMESTAMP    NOT NULL,
    user_id    VARCHAR(100),
    PRIMARY KEY (id)
) ENGINE = innoDB;

SHOW TABLES;

ALTER TABLE notification
    ADD CONSTRAINT fk_notification_user
        FOREIGN KEY (user_id) REFERENCES user (id);

DESC notification;

INSERT INTO notification (title, detail, created_at, user_id)
VALUES ('Contoh Pesanan', 'Detail Pesanan', CURRENT_TIMESTAMP(), 'ilham');
INSERT INTO notification (title, detail, created_at, user_id)
VALUES ('Contoh Promo', 'Detail Promo', CURRENT_TIMESTAMP(), null);
INSERT INTO notification (title, detail, created_at, user_id)
VALUES ('Contoh Pembayaran', 'Detail Pembayaran', CURRENT_TIMESTAMP(), 'adi');

SELECT *
FROM notification;

SELECT *
FROM notification
WHERE (user_id = 'ilham' OR user_id IS NULL)
ORDER BY created_at DESC;
SELECT *
FROM notification
WHERE (user_id = 'adi' OR user_id IS NULL)
ORDER BY created_at DESC;

-- Category

CREATE TABLE category
(
    id   VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

SHOW TABLES;

ALTER TABLE notification
    ADD COLUMN category_id VARCHAR(100);

DESC notification;

ALTER TABLE notification
    ADD CONSTRAINT fk_notification_category
        FOREIGN KEY (category_id) REFERENCES category (id);

desc notification;

INSERT INTO category(id, name)
VALUES ('PROMO', 'Promo');
INSERT INTO category(id, name)
VALUES ('INFO', 'Info');

SELECT *
FROM category;

SELECT *
FROM notification;

UPDATE notification
SET notification.category_id ='INFO'
WHERE id = 1;
UPDATE notification
SET notification.category_id ='PROMO'
WHERE id = 2;
UPDATE notification
SET notification.category_id ='INFO'
WHERE id = 3;

SELECT *
FROM notification;

SELECT *
FROM notification
WHERE (user_id = 'adi' OR user_id IS NULL)
ORDER BY created_at DESC;
SELECT *
FROM notification
WHERE (user_id = 'ilham' OR user_id IS NULL)
ORDER BY created_at DESC;

-- filter
SELECT *
FROM notification n
         JOIN category c ON c.id = n.category_id
WHERE (n.user_id = 'adi' OR n.user_id IS NULL)
ORDER BY n.created_at DESC;

-- filter category
SELECT *
FROM notification n
         JOIN category c ON c.id = n.category_id
WHERE (n.user_id = 'ilham' OR n.user_id IS NULL)
  AND c.name = 'Info'
ORDER BY n.created_at DESC;

-- TODO create Table Notification Read
CREATE TABLE notification_read
(
    id              INT          NOT NULL AUTO_INCREMENT,
    is_read         BOOLEAN      NOT NULL,
    user_id         VARCHAR(100) NOT NULL,
    notification_id INT          NOT NULL,
    PRIMARY KEY (id)
) ENGINE = innodb;

SHOW TABLES;

ALTER TABLE notification_read
    ADD CONSTRAINT fk_notification_read_notification
        FOREIGN KEY (notification_id) REFERENCES notification (id);

ALTER TABLE notification_read
    ADD CONSTRAINT fk_notification_read_user
        FOREIGN KEY (user_id) REFERENCES user(id);

DESC notification_read;
