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
    birthplace clob,
    age number(3, 0),
    style_of_art clob,
    artist_id varchar(6),

    primary key (artist_id)
);

create table artwork (
    artist varchar(6),
    year_it_was_made number(38, 0),
    unique_title varchar(33),
    type_of_art varchar(35) not null,
    price number,

    primary key (unique_title),
    foreign key (artist) references artist (artist_id)
    on delete set null,

    constraint classified_into_various_kinds check (type_of_art in ('Poetess', 'Work of the 19th century still life', 'etc.'))
);

create table customer (
    unique_name varchar(747),
    address clob,
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
    select 'Dương Thị D', 'Female', '0912345678', 456789123, '03/08/1992' from dual union all
    select 'Hoàng Văn E', 'Male', '0923456789', 789123456, '07/17/1985' from dual;

insert into artist (their_name, birthplace, age, style_of_art, artist_id)
    select 'Picasso', '20 Holmes Street, London, United Kingdom', 78, 'Cubism', '786567' from dual union all
    select 'Monet', '100 Valmes Street, Seattle, USA', 67, 'Impressionism', '908096' from dual union all
    select 'Van Gogh', '250 Lourve Street, Paris, France', 56, 'Post-Impressionism', '763457' from dual union all
    select 'Da Vinci', '147 Milan Street, Milan, Italy', 80, 'Renaissance', '890234' from dual union all
    select 'Frida Kahlo', '890 Olmec Street, Mexico City, Mexico', 76, 'Surrealism', '236547' from dual;

insert into artwork (artist, year_it_was_made, unique_title, type_of_art, price)
    select '890234', 1503, 'Mona Lisa', 'Poetess', 1000000000 from dual union all
    select '763457', 1889, 'Starry Night', 'Work of the 19th century still life', 800000000 from dual union all
    select '786567', 1907, 'Les Demoiselles d', 'etc.', 700000000 from dual union all
    select '908096', 1878, 'La Rue Montorgueil', 'etc.', 230000000 from dual union all
    select '236547', 1946, 'Frieda and Diego Rivera', 'etc.', 780000000 from dual;

insert into customer (unique_name, address, total_amount_of_money_they_spent_on_the_gallery, likes_of_customers, bank_account)
    select 'John Doe', '200 Main Street, Los Angeles, USA', 1000, 'Impressionism', 123456789 from dual union all
    select 'Jane Smith', '20 Downing Street, London, United Kingdom', 2000, 'Contemporary Art', 987654321 from dual union all
    select 'Maria Gonzalez', '305 Grand Via Street, Madrid, Spain', 800, 'Surrealism', 321654987 from dual union all
    select 'Pierre Dupont', '500 Marseilles Street, Paris, France', 1200, 'Impressionism', 456789123 from dual union all
    select 'Adam Scottfield', '10 MacArthur Boulevard Street, Washington DC, United States', 3000, 'Renaissance', 789123456 from dual;

insert into artwork_transaction (customer, artwork, transaction_id)
    select 'John Doe', 'Mona Lisa', '788678' from dual union all
    select 'Jane Smith', 'Starry Night', '909890' from dual union all
    select 'Maria Gonzalez', 'Les Demoiselles d','656454'  from dual union all
    select 'Pierre Dupont', 'La Rue Montorgueil', '345678' from dual union all
    select 'Adam Scottfield', 'Frieda and Diego Rivera', '190874' from dual;

insert into staff (staff_id, name, position, salary)
    select 'S001', 'Sherlock Holmes', 'Manager', 5000 from dual union all
    select 'S002', 'James Moriarity', 'Salesperson', 3000 from dual union all
    select 'S003', 'Michael Johnson', 'Engineer', 4500 from dual union all
    select 'S004', 'Emily Davis', 'Accountant', 3500 from dual union all
    select 'S005', 'David Lee', 'Designer', 4000 from dual;

insert into exhibition (exhibition_id, exhibition_name, start_date, end_date)
    select '6789', 'Surrealism Art Room', '03/13/2023', '05/17/2023' from dual union all
    select '3425', 'Art of the Renaissance', '11/01/2023', '12/31/2023' from dual union all
    select '9834', 'Modern Masters', '01/15/2024', '03/15/2024' from dual union all
    select '7328', 'Impressionism', '01/04/2024', '05/31/2024' from dual union all
    select '3453', 'Abstract Expressionism', '09/01/2024', '10/31/2024' from dual;

insert into ticket (ticket_id, price, exhibition_id, purchase_date)
    select '41556345', 20, '6789', '03/15/2023' from dual union all
    select '89089087', 25, '3425', '07/01/2023' from dual union all
    select '34242534', 25, '9834', '01/17/2024' from dual union all
    select '78906783', 25, '7328', '02/24/2024' from dual union all
    select '34523458', 20, '3453', '04/14/2024' from dual;

insert into artworks_featured (artwork, exhibition, location_in_gallery)
    select 'Mona Lisa', '3425', 'North Gallery' from dual union all
    select 'Starry Night', '9834', 'South Gallery' from dual union all
    select 'Les Demoiselles d', '6789', 'Central Room' from dual union all
    select 'La Rue Montorgueil', '7328', 'East Wing' from dual union all
    select 'Frieda and Diego Rivera', '3453', 'West Gate' from dual;

 insert into visitor_bank_details (visitor_id, bank_number, bank)
    select '34567345', 123456789, 'West Bank' from dual union all
    select '90907895', 987654321, 'Westfield Bank' from dual union all
    select '32134548', 321654987, 'MSBNC Bank' from dual union all
    select '34824852', 456789123, 'VCB Bank' from dual union all
    select '78906785', 789123456, 'Bank of America' from dual;