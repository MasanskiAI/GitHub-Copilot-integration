-- Drop tables in correct order (child tables first)
DROP TABLE IF EXISTS [AM_TEST].Orders;
DROP TABLE IF EXISTS [AM_TEST].Calendar;
DROP TABLE IF EXISTS [AM_TEST].Products;
DROP TABLE IF EXISTS [AM_TEST].Customers;

-- Drop schema
DROP SCHEMA IF EXISTS [AM_TEST];