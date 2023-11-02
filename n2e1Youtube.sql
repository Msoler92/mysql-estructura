DROP DATABASE IF EXISTS n2e1youtube;
CREATE DATABASE n2e1youtube CHARACTER SET utf8mb4;
USE n2e1youtube;

CREATE TABLE user_account (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(120) NOT NULL,
    user_password VARCHAR (60) NOT NULL,
    username VARCHAR(60) NOT NULL,
    birth_date DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    country VARCHAR(60),
    postal_code VARCHAR (15)
);

INSERT INTO user_account VALUES (1, 'example1@example.org', 'encryptedPassword1', 'username1', '1990-01-01', 'Female', 'CountryA', '08001');
INSERT INTO user_account VALUES (2, 'example2@example.org', 'encryptedPassword2', 'username2', '1990-01-02', 'Female', 'CountryA', '08002');
INSERT INTO user_account VALUES (3, 'example3@example.org', 'encryptedPassword3', 'username3', '1990-01-03', 'Male', 'CountryB', '08003');
INSERT INTO user_account VALUES (4, 'example4@example.org', 'encryptedPassword4', 'username4', '1990-01-04', 'Male', 'CountryB', '08004');
INSERT INTO user_account VALUES (5, 'example5@example.org', 'encryptedPassword5', 'username5', '1990-01-05', 'Other', 'CountryC', '08005');
INSERT INTO user_account VALUES (6, 'example6@example.org', 'encryptedPassword6', 'username6', '1990-01-06', 'Other', 'CountryC', '08006');
INSERT INTO user_account VALUES (7, 'example7@example.org', 'encryptedPassword7', 'username7', '1990-01-07', 'Female', 'CountryD', '08007');
INSERT INTO user_account VALUES (8, 'example8@example.org', 'encryptedPassword8', 'username8', '1990-01-08', 'Female', 'CountryD', '08008');

CREATE TABLE user_channel (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    channel_name VARCHAR (120) NOT NULL,
    channel_description TEXT,
    creation_date DATETIME,
    user_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user_account(id)
);

INSERT INTO user_channel VALUES (1, 'channelname1', 'channeldescription1', '2001-01-01 00:00:00', 1);
INSERT INTO user_channel VALUES (2, 'channelname2', 'channeldescription2', '2002-01-01 00:00:00', 1);
INSERT INTO user_channel VALUES (3, 'channelname3', 'channeldescription3', '2003-01-01 00:00:00', 1);
INSERT INTO user_channel VALUES (4, 'channelname4', 'channeldescription4', '2004-01-01 00:00:00', 2);
INSERT INTO user_channel VALUES (5, 'channelname5', 'channeldescription5', '2005-01-01 00:00:00', 3);
INSERT INTO user_channel VALUES (6, 'channelname6', 'channeldescription6', '2006-01-01 00:00:00', 3);

CREATE TABLE video (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR (254),
    video_description TEXT,
    size FLOAT,
    file_name VARCHAR (120),
    duration FLOAT,
    thumbnail BLOB,
    play_count BIGINT DEFAULT 0,
    like_count BIGINT DEFAULT 0,
    dislike_count BIGINT DEFAULT 0,
    video_status ENUM('Public', 'Hidden', 'Private'),
    upload_date DATETIME NOT NULL,
    channel_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (channel_id) REFERENCES user_channel(id)
);

INSERT INTO video VALUES (1, 'title1', 'description1', 1.1, 'filename1.avi', 10.0, NULL, 0, 0, 0, 'Public', '2011-01-01 00:00:00', 1);
INSERT INTO video VALUES (2, 'title2', 'description2', 2.1, 'filename2.avi', 20.0, NULL, 0, 0, 0, 'Public', '2012-01-01 00:00:00', 1);
INSERT INTO video VALUES (3, 'title3', 'description3', 3.1, 'filename3.avi', 30.0, NULL, 0, 0, 0, 'Public', '2013-01-01 00:00:00', 2);
INSERT INTO video VALUES (4, 'title4', 'description4', 4.1, 'filename4.avi', 40.0, NULL, 0, 0, 0, 'Public', '2014-01-01 00:00:00', 3);
INSERT INTO video VALUES (5, 'title5', 'description5', 5.1, 'filename5.avi', 50.0, NULL, 0, 0, 0, 'Public', '2015-01-01 00:00:00', 4);
INSERT INTO video VALUES (6, 'title6', 'description6', 6.1, 'filename6.avi', 60.0, NULL, 0, 0, 0, 'Public', '2016-01-01 00:00:00', 4);
INSERT INTO video VALUES (7, 'title7', 'description7', 7.1, 'filename7.avi', 70.0, NULL, 0, 0, 0, 'Public', '2017-01-01 00:00:00', 5);
INSERT INTO video VALUES (8, 'title8', 'description8', 8.1, 'filename8.avi', 80.0, NULL, 0, 0, 0, 'Public', '2018-01-01 00:00:00', 6);

CREATE TABLE label (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    label_name VARCHAR (60) NOT NULL
);

INSERT INTO label VALUES (1, 'Cats');
INSERT INTO label VALUES (2, 'Dogs');
INSERT INTO label VALUES (3, 'Fun');
INSERT INTO label VALUES (4, 'Boring');


CREATE TABLE video_label (
	video_id BIGINT UNSIGNED NOT NULL,
	label_id BIGINT UNSIGNED NOT NULL,
    UNIQUE KEY uk_video_label(video_id, label_id),
    FOREIGN KEY (video_id) REFERENCES video(id),
    FOREIGN KEY (label_id) REFERENCES label(id)
);

INSERT INTO video_label VALUES (1, 1);
INSERT INTO video_label VALUES (1, 3);
INSERT INTO video_label VALUES (2, 2);
INSERT INTO video_label VALUES (3, 1);
INSERT INTO video_label VALUES (3, 4);
INSERT INTO video_label VALUES (5, 3);
INSERT INTO video_label VALUES (6, 4);
INSERT INTO video_label VALUES (6, 2);

CREATE TABLE user_subscription (
	user_id BIGINT UNSIGNED NOT NULL,
    channel_id BIGINT UNSIGNED NOT NULL,
    UNIQUE KEY uk_user_subscription(user_id, channel_id),
    FOREIGN KEY (user_id) REFERENCES user_account(id),
    FOREIGN KEY (channel_id) REFERENCES user_channel(id)
);

INSERT INTO user_subscription VALUES (1, 4);
INSERT INTO user_subscription VALUES (1, 5);
INSERT INTO user_subscription VALUES (2, 1);
INSERT INTO user_subscription VALUES (2, 5);
INSERT INTO user_subscription VALUES (2, 6);
INSERT INTO user_subscription VALUES (3, 1);
INSERT INTO user_subscription VALUES (4, 1);
INSERT INTO user_subscription VALUES (5, 1);
INSERT INTO user_subscription VALUES (6, 1);
INSERT INTO user_subscription VALUES (7, 1);
INSERT INTO user_subscription VALUES (8, 1);

CREATE TABLE users_likes_dislikes (
	user_id BIGINT UNSIGNED NOT NULL,
    video_id BIGINT UNSIGNED NOT NULL,
    like_dislike ENUM('1', '-1'),
    UNIQUE KEY uk_user_likes_dislikes (user_id, video_id),
    FOREIGN KEY (user_id) REFERENCES user_account(id),
    FOREIGN KEY (video_id) REFERENCES video(id)
);

INSERT INTO users_likes_dislikes VALUES (1, 5, '1');
INSERT INTO users_likes_dislikes VALUES (1, 6, '-1');
INSERT INTO users_likes_dislikes VALUES (3, 5, '1');
INSERT INTO users_likes_dislikes VALUES (3, 1, '1');

CREATE TABLE playlist (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    playlist_name VARCHAR (120),
    creation_date DATE,
    playlist_status ENUM('Public', 'Private'),
    FOREIGN KEY (user_id) REFERENCES user_account(id)
);

INSERT INTO playlist VALUES (1, 1, 'playlist1', '2011-01-01', 'Private');
INSERT INTO playlist VALUES (2, 7, 'playlist2', '2012-01-01', 'Public');

CREATE TABLE playlist_video (
	playlist_id BIGINT UNSIGNED NOT NULL,
    video_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (playlist_id) REFERENCES playlist(id),
    FOREIGN KEY (video_id) REFERENCES video(id)
);

INSERT INTO playlist_video VALUES (1, 1);
INSERT INTO playlist_video VALUES (1, 3);
INSERT INTO playlist_video VALUES (1, 1);
INSERT INTO playlist_video VALUES (1, 5);
INSERT INTO playlist_video VALUES (2, 1);
INSERT INTO playlist_video VALUES (2, 2);
INSERT INTO playlist_video VALUES (2, 3);
INSERT INTO playlist_video VALUES (2, 4);

CREATE TABLE video_comment (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    comment_body TEXT,
    date_time DATETIME,
    user_id BIGINT UNSIGNED NOT NULL,
    video_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user_account(id),
    FOREIGN KEY (video_id) REFERENCES video(id)
);

INSERT INTO video_comment VALUES (1, 'comment1', '2020-01-01 00:01:00', 1, 4);
INSERT INTO video_comment VALUES (2, 'comment2', '2020-01-01 00:01:00', 1, 5);
INSERT INTO video_comment VALUES (3, 'comment3', '2020-01-01 00:01:00', 2, 1);
INSERT INTO video_comment VALUES (4, 'comment4', '2020-01-01 00:01:00', 3, 1);
INSERT INTO video_comment VALUES (5, 'comment5', '2020-01-01 00:01:00', 4, 1);

