create table SP_WESOLEKA.PRODUCTS
(
    PRODUCT_ID       NUMBER        not null
        primary key,
    PRODUCT_NAME     VARCHAR2(150) not null,
    PRODUCT_CATEGORY VARCHAR2(150) default 'zywnosc',
    PRICE            NUMBER(12, 2),
    QUANTITY         NUMBER,
    UNIT             VARCHAR2(10),
    LAST_ORDER_DATE  DATE
)
/

create table SP_WESOLEKA.CUSTOMERS
(
    PESEL        VARCHAR2(11) not null
        constraint CUSTOMERS_PK
            primary key,
    FIRST_NAME   VARCHAR2(60) not null,
    LAST_NAME    VARCHAR2(60) not null,
    PHONE_NUMBER VARCHAR2(20),
    BIRTH_DATE   DATE         not null
)
/

create table SP_WESOLEKA.SALES
(
    SALE_ID    NUMBER       not null
        primary key,
    QUANTITY   NUMBER(6)    not null,
    PRICE      FLOAT(63)    not null,
    PRODUCT_ID NUMBER       not null
        references SP_WESOLEKA.PRODUCTS,
    PESEL      VARCHAR2(11) not null
        references SP_WESOLEKA.CUSTOMERS
)
/

create table SP_WESOLEKA.REGIONS
(
    REGION_ID   NUMBER(2) not null
        primary key,
    REGION_NAME VARCHAR2(20)
)
/

create table SP_WESOLEKA.COUNTRIES
(
    COUNTRY_ID   NUMBER(2) not null
        primary key,
    COUNTRY_NAME VARCHAR2(20),
    REGION_ID    NUMBER(2)
        references SP_WESOLEKA.REGIONS
)
/

create table SP_WESOLEKA.LOCATIONS
(
    LOCATION_ID    NUMBER        not null
        primary key,
    STREET_ADDRESS VARCHAR2(150) not null,
    POSTAL_CODE    VARCHAR2(10)  not null,
    CITY           VARCHAR2(15)  not null,
    STATE_PROVINCE VARCHAR2(20)  not null,
    COUNTRY_ID     NUMBER(2)
        references SP_WESOLEKA.COUNTRIES
)
/

create table SP_WESOLEKA.DEPARTMENTS
(
    DEPARTMENT_ID NUMBER not null
        primary key,
    DEPARTMENT    VARCHAR2(50),
    MANAGER_ID    NUMBER,
    LOCATION_ID   NUMBER
        references SP_WESOLEKA.LOCATIONS
)
/

create table SP_WESOLEKA.JOBS
(
    JOB_ID     NUMBER not null
        primary key,
    JOB_TITLE  VARCHAR2(25),
    MIN_SALARY NUMBER,
    MAX_SALARY NUMBER,
    constraint SALARY_CHECK
        check (min_salary < max_salary - 2000)
)
/

create table SP_WESOLEKA.EMPLOYEES
(
    EMPLOYEE_ID    NUMBER not null
        primary key,
    FIRST_NAME     VARCHAR2(60),
    LAST_NAME      VARCHAR2(60),
    EMAIL          VARCHAR2(40),
    PHONE_NUMBER   VARCHAR2(40),
    HIRE_DATE      DATE,
    JOB_ID         NUMBER,
    SALARY         NUMBER(9, 2),
    COMMISSION_PCT VARCHAR2(20),
    MANAGER_ID     NUMBER
        references SP_WESOLEKA.EMPLOYEES,
    DEPARTMENT_ID  NUMBER
        references SP_WESOLEKA.DEPARTMENTS
)
/

alter table SP_WESOLEKA.DEPARTMENTS
    add foreign key (MANAGER_ID) references SP_WESOLEKA.EMPLOYEES
/

create table SP_WESOLEKA.JOB_HISTORY
(
    EMPLOYEE_ID   NUMBER not null
        references SP_WESOLEKA.EMPLOYEES,
    START_DATE    DATE   not null,
    END_DATE      DATE,
    JOB_ID        NUMBER
        references SP_WESOLEKA.JOBS,
    DEPARTMENT_ID NUMBER
        references SP_WESOLEKA.DEPARTMENTS,
    primary key (EMPLOYEE_ID, START_DATE)
)
/

