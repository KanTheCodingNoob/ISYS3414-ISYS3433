-- -*- mode: orsql; -*-

CREATE TABLE artist (
    their_name VARCHAR(17),
    birthplace SDO_GEO_ADDR,
    style_of_art CLOB,

    PRIMARY KEY (their_name)
);

CREATE TABLE artwork (
    artist VARCHAR(17),
    year_it_was_made NUMBER,
    unique_title VARCHAR(33),
    type_of_art VARCHAR(35),
    price NUMBER,
    
    PRIMARY KEY (unique_title),
    FOREIGN KEY (artist) REFERENCES artist (their_name)
    ON DELETE CASCADE,

    CONSTRAINT classified_into_various_kinds CHECK (type_of_art IN ('Poetess', 'Work of the 19th century still life', 'etc.'))
);

CREATE TABLE customer (
    unique_name VARCHAR(747),
    address SDO_GEO_ADDR,
    total_amount_of_money_they_spent_on_the_gallery NUMBER,
    likes_of_customers CLOB,

    PRIMARY KEY (unique_name)
);