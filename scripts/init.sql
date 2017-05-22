drop table fth_auth;
drop table fth_role;
drop table fth_employee_phones;
drop table fth_canceled_foods;
drop table fth_order_foods;
drop table fth_store;
drop table fth_order;
drop table fth_ingredients;
drop table fth_product;
drop table fth_employee;
drop table fth_food;
drop table fth_image;
drop table fth_office;
drop table fth_object_types;

create table fth_role (
    role_id number primary key not null,
    name varchar2(20) not null,
    description varchar2(100)
);

create table fth_object_types (
    object_type_id number primary key not null,
    name varchar2(20) not null,
    description varchar2(100)
);

create table fth_product (
    product_id number primary key not null,
    name varchar2(20) not null
);

create table fth_office (
    office_id number primary key not null,
    parent_id number,
    phone varchar2(11),
    object_type_id number,
    address varchar2(40),
    
    constraint fk_office_parent
    foreign key (parent_id) references fth_office (office_id),
    
    constraint fk_office_object_types
    foreign key (object_type_id) references fth_object_types (object_type_id)
);

create table fth_store (
    office_id number not null,
    product_id number not null,
    count number not null,
    
    constraint fk_store_office
    foreign key (office_id) references fth_office (office_id),
    
    constraint fk_store_product
    foreign key (product_id) references fth_product (product_id)
);

create table fth_image (
    image_id number primary key not null,
    image blob
);

create table fth_food (
    food_id number primary key not null,
    name varchar2(20) not null,
    description varchar2(50),
    preparation_time number /* In minutes */,
    object_type_id number,
    image_id number,
    price number not null,
    
    constraint fk_food_object_type
    foreign key (object_type_id) references fth_object_types (object_type_id),
    
    constraint fk_food_image
    foreign key (image_id) references fth_image (image_id)
);


create table fth_ingredients (
    food_id number not null,
    product_id number not null,
    count number not null,
    
    constraint fk_ingredients_food
    foreign key (food_id) references fth_food (food_id),
    
    constraint fk_ingredients_product
    foreign key (product_id) references fth_product (product_id)
);


create table fth_employee (
    employee_id number primary key not null,
    parent_id number,
    firstname varchar2(20) not null,
    lastname varchar2(20) not null,
    object_type_id number,
    office_id number not null,
    salary number not null,
    image_id number,
    pass varchar2(50),
    
    constraint fk_employee_parent
    foreign key (parent_id) references fth_employee (employee_id),
    
    constraint fk_employee_object_types
    foreign key (object_type_id) references fth_object_types (object_type_id),
    
    constraint fk_employee_office
    foreign key (office_id) references fth_office (office_id),
    
    constraint fk_employee_image
    foreign key (image_id) references fth_image (image_id)
);


create table fth_employee_phones (
    employee_id number not null,
    phone varchar2(11) not null,
    
    constraint fk_employee_phone
    foreign key (employee_id) references fth_employee (employee_id)
);

create table fth_canceled_foods (
    food_id number not null,
    count number not null,
    coocked_time date not null,
    description varchar2(50),
    cook_employee_id number not null,
    
    constraint fk_canceled_food
    foreign key (food_id) references fth_food (food_id),
    
    constraint fk_canceled_cook
    foreign key (cook_employee_id) references fth_employee (employee_id)
);

create table fth_auth (
    employee_id number not null,
    role_id number not null,
    
    constraint fk_auth_employee
    foreign key (employee_id) references fth_employee (employee_id),
    
    constraint fk_auth_role
    foreign key (role_id) references fth_role (role_id)
);

create table fth_order (
    order_id number primary key not null,
    address varchar2(50) not null,
    phone varchar2(11) not null,
    office_id number,
    isApprove number(1),
    ordered_date date,
    manager_employee_id number,
    courier_employee_id number,
    delivered_time date,
    price number not null,
    description varchar2(50),
    
    constraint fk_order_office
    foreign key (office_id) references fth_office (office_id),
    
    constraint fk_order_manager
    foreign key (manager_employee_id) references fth_employee (employee_id),
    
    constraint fk_order_courier
    foreign key (courier_employee_id) references fth_employee (employee_id)
);

create table fth_order_foods (
    order_id number not null,
    food_id number not null,
    count number not null,
    cook_employee_id number,
    isReady number(1),
    
    constraint fk_order_food
    foreign key (order_id) references fth_order (order_id),
    
    constraint fk_food_order
    foreign key (food_id) references fth_food (food_id),
    
    constraint fk_order_food_cook
    foreign key (cook_employee_id) references fth_employee (employee_id)
);

create index object_type_name_idx on fth_object_types (name);
create index food_object_type_idx on fth_food (object_type_id);
create index order_phone_idx on fth_order (phone);
create index order_courier_idx on fth_order (courier_employee_id);
create index ingredients_food_idx on fth_ingredients (food_id);
create index canceled_food_idx on fth_canceled_foods (food_id);
create index employee_parent_idx on fth_employee (parent_id);
create index employee_office_idx on fth_employee (office_id);
create index employee_phone_idx on fth_employee_phones (employee_id);