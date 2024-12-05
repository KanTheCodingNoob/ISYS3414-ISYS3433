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
    age number(3, 0),
    style_of_art clob,
    artist_id varchar(6),

    primary key (artist_id)
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

create table artwork_transaction (
    customer varchar(747),
    artwork varchar(33),
    transaction_id varchar(6),

    primary key (transaction_id),
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

insert into visitor (name, sex, phone_number, bank_account, birth_date)
    select 'Nguyễn Văn A', 'Male', '0987654321', 123456789, '01/01/1990' from dual union all
    select 'Trần Thị B', 'Female', '0123456789', 987654321, '05/15/1995' from dual union all
    select 'Lê Văn C', 'Male', '0901234567', 321654987, '11/22/1988' from dual union all
    select 'Dương Thị D', 'Female', '0912345678', 456789123,'03/08/1992' from dual union all
    select 'Hoàng Văn E', 'Male', '0923456789', 789123456,'07/17/1985' from dual;

insert into artist (their_name, birthplace, style_of_art)
    select
        'Picasso',
        sdo_geo_addr(
            'Italy',
            'Province of Venezia',
            'Municipality of Venice',
            'Venice',
            'San Polo',
            '30100',
            'Rio Terrà',
            'Castello 6219',
            'Venezianamente Apartments',
            'San Palo 1225'
        ),
        'Cubism'
    from dual union all
    select
        'Monet',
        sdo_geo_addr(
            'Germany',
            'Bavaria',
            'Bavaria-Ingolstadt',
            'Ingolstadt',
            'Adam-Smith-Straße',
            '85049',
            null,
            null,
            null,
            null
         ),
         'Impressionism'
    from dual union all
    select
        'Van Gogh',
        sdo_geo_addr(
            'Netherlands',
            'North Brabant',
            'Zundert',
            'Zundert',
            null,
            '4881',
            null,
            null,
            null,
            null
        ),
        'Post-Impressionism'
    from dual union all
    select
        'Da Vinci',
        sdo_geo_addr(
            'Italy',
            'Tuscany',
            'Florence',
            'Florence',
            null,
            '50122',
            null,
            null,
            null,
            null
        ),
        'Renaissance'
    from dual union all
    select
        'Frida Kahlo',
        sdo_geo_addr(
            'Russia',
            'Leningrad Oblast',
            'Sosnovy Bor',
            'Ivangorod',
            'Ivangorodskoye Urban Settlement',
            '188490',
            null,
            null,
            null,
            null
        ),
        'Surrealism'
    from dual;

insert into artwork (artist, year_it_was_made, unique_title, type_of_art, price)
    select 'Da Vinci', 1503, 'Mona Lisa', 'Poetess', 1000000000 from dual union all
    select 'Van Gogh', 1889, 'Starry Night', 'Work of the 19th century still life', 800000000 from dual union all
    select 'Picasso', 1907, 'Les Demoiselles d', 'etc.', 700000000 from dual union all
    select 'Monet', 1878, 'La Rue Montorgueil', 'etc.', 230000000 from dual union all
    select 'Frida Kahlo', 1946, 'Frieda and Diego Rivera', 'etc.', 780000000 from dual;

insert into customer (unique_name, address, total_amount_of_money_they_spent_on_the_gallery, likes_of_customers, bank_account)
    select
        'John Doe',
        sdo_geo_addr(
            'USA',
            'California',
            'Los Angeles',
            'Los Angeles County',
            '90001',
            'Main Street',
            '123',
            '4B',
            'Apt 2',
            null
        ),
        1000,
        'Impressionism',
        123456789
    from dual union all
    select
        'Jane Smith',
        sdo_geo_addr(
            'UK',
            'England',
            'London',
            'Greater London',
            'SW1A 0AA',
            'Downing Street',
            '10',
            null,
            null,
            null
        ),
        2000,
        'Contemporary Art',
        987654321
    from dual union all
    select
        'Maria Gonzalez',
         sdo_geo_addr(
             'Spain',
             'Madrid',
             'Centro',
             '28001',
             'Gran Vía',
             '42',
             null,
             null,
             null,
             null
         ),
         800,
         'Surrealism',
         321654987
    from dual union all
    select
        'Pierre Dupont',
        sdo_geo_addr(
            'France',
            'Île-de-France',
            'Paris',
            'Paris',
            '75001',
            'Rue de Rivoli',
            null,
            null,
            null,
            null
        ),
        1200,
        'Impressionism',
        456789123
    from dual union all
    select
        'Adam Scotfield',
        sdo_geo_addr(
            'United States',
            'Washington DC',
            'Burleith',
            '20001',
            'MacArthur Boulevard NW'
            null,
            null,
            null
        ),
        3000,
        'Renaissance',
        789123456
    from dual;


    select
        ''




insert into customers_who_buy_artworks (customer, artwork)
    select 'John Doe', 'Mona Lisa' from dual union all
    select 'Jane Smith', 'Starry Night' from dual union all
    select 'Maria Gonzalez', 'Les Demoiselles d' from dual union all
    select 'Pierre Dupont', 'La Rue Montorgueil' from dual union all
    select 'Adam Scottfield', 'Frieda and Diego Rivera' from dual;

