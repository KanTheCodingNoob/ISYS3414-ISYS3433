-- -*- mode: orsql; -*-

create table visitor (
    name varchar(747),
    sex clob,
    phone_number varchar(15) check (regexp_like(phone_number, '^[0-9]+$') and length(phone_number) >= 7),
    bank_account number,
    birth_date date,

    primary key (bank_account)
);

create table artist (
    their_name varchar(17),
    birthplace sdo_geo_addr,
    style_of_art clob,

    primary key (their_name)
);

create table artwork (
    artist varchar(17),
    year_it_was_made number(38, 0),
    unique_title varchar(33),
    type_of_art varchar(35) not null,
    price number,
    
    primary key (unique_title),
    foreign key (artist) references artist (their_name)
    on delete set null,

    constraint classified_into_various_kinds check (type_of_art in ('Poetess', 'Work of the 19th century still life', 'etc.'))
);

create table customer (
    unique_name varchar(747),
    address sdo_geo_addr,
    total_amount_of_money_they_spent_on_the_gallery number,
    likes_of_customers clob,
    bank_account number,

    primary key (unique_name),
    foreign key (bank_account) references visitor (bank_account)
    on delete cascade
);

create table customers_who_buy_artworks (
    customer varchar(747),
    artwork varchar(33),

    primary key (customer, artwork),
    foreign key (customer) references customer (unique_name)
    on delete cascade,
    foreign key (artwork) references artwork (unique_title)
    on delete cascade
);

create table staff (
    staff_id varchar(5),
    name clob,
    position clob,
    salary number,

    primary key (staff_id)
);

create table exhibition (
    exhibition_id varchar(4),
    exhibition_name clob,
    start_date date,
    end_date date,

    primary key (exhibition_id)
);

create table ticket (
    ticket_id varchar(8),
    price number,
    exhibition_id varchar(4),
    purchase_date date,

    primary key (ticket_id),
    foreign key (exhibition_id) references exhibition (exhibition_id)
    on delete cascade
);

create table artworks_featured (
    artwork varchar(33),
    exhibition varchar(4),
    art_style clob,
    location_in_gallery clob,

    primary key (artwork, exhibition),
    foreign key (artwork) references artwork (unique_title)
    on delete cascade,
    foreign key (exhibition) references exhibition (exhibition_id)
    on delete cascade
);

create table visitor_bank_details (
    visitor_id varchar(8),
    bank_number number,
    bank clob,

    primary key (visitor_id),
    foreign key (bank_number) references visitor (bank_account)
    on delete cascade
);