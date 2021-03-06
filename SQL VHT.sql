--1.C.1
CREATE TABLE IF NOT EXISTS CUSTOMERS (
	CUS_ID INT NOT NULL PRIMARY KEY,
	CUS_FNAME VARCHAR(30) NOT NULL,
	CUS_LNAME VARCHAR(40) NOT NULL,
	CUS_STREET VARCHAR(255) NOT NULL,
	CUS_APTNUM VARCHAR(255),
	CUS_CITY VARCHAR(255) NOT NULL,
	CUS_STATE CHAR(2) NOT NULL,
	CUS_ZIP CHAR(5) NOT NULL,
	CUS_HOMENUM CHAR(10) NOT NULL,
	CUS_CELLNUM CHAR(10),
	CUS_OTHERNUM CHAR(10)
	);
  
CREATE TABLE IF NOT EXISTS INVOICES (
	ORDER_ID INT NOT NULL PRIMARY KEY,
	ORDER_DATE DATE NOT NULL,
	NOTES VARCHAR(255),
    CUS_ID INT NOT NULL,
	FOREIGN KEY (CUS_ID) REFERENCES CUSTOMERS(CUS_ID)
        ON UPDATE CASCADE ON DELETE RESTRICT
	);
   
CREATE TABLE IF NOT EXISTS DONUTS (
	DONUT_ID INT NOT NULL PRIMARY KEY,
	DONUT_NAME VARCHAR(255),
	DONUT_DESC VARCHAR(255),
	DONUT_PRICE DECIMAL (3,2)
	);

CREATE TABLE IF NOT EXISTS INVOICE_ITEMS (
	ORDER_ID INT NOT NULL,
	DONUT_ID INT NOT NULL,
    DONUT_QTY INT NOT NULL,
	PRIMARY KEY (ORDER_ID, DONUT_ID),
    FOREIGN KEY (ORDER_ID) REFERENCES INVOICES(ORDER_ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (DONUT_ID) REFERENCES DONUTS(DONUT_ID) ON UPDATE CASCADE ON DELETE RESTRICT
	);
--1.C.1

--1.D.1
CREATE VIEW CUSTOMER_INFO AS
SELECT CONCAT(CUS_FNAME, " ", CUS_LNAME) AS FULL_NAME, CUS_ID, CUS_STREET, CUS_APTNUM, CUS_CITY, CUS_STATE, CUS_ZIP, CUS_HOMENUM, CUS_CELLNUM, CUS_OTHERNUM
FROM CUSTOMERS;
--1.D.1

--1.E.1
CREATE UNIQUE INDEX IDXDONUT ON DONUTS(DONUT_ID);
--1.E.1                 	

--1.F.1
INSERT INTO CUSTOMERS VALUES(1, "John", "Smith", "123 Street", "Apt F", "Madeup City", "AN", "12345", "0123456789", null, null);
INSERT INTO CUSTOMERS VALUES(2, "Jane", "Doe", "123 Street", "Apt F", "Madeup City", "AN", "12345", "0123456789", null, null);
INSERT INTO CUSTOMERS VALUES(3, "Mike", "Mikey", "123 Street", "Apt F", "Madeup City", "AN", "12345", "0123456789", null, null);

INSERT INTO INVOICES VALUES(1, "2017-12-26", null, 1);
INSERT INTO INVOICES VALUES(2, "2017-12-27", "Napkins please", 2);
INSERT INTO INVOICES VALUES(3, "2017-12-30", null, 3);

INSERT INTO DONUTS VALUES(1, "Plain", "Plain Donut", 1.50);
INSERT INTO DONUTS VALUES(2, "Glazed", "Glazed Donut", 1.75);
INSERT INTO DONUTS VALUES(3, "Cinnamon", "Cinnamon Donut", 1.75);
INSERT INTO DONUTS VALUES(4, "Chocolate", "Chocolate Donut", 1.75);
INSERT INTO DONUTS VALUES(5, "Sprinkle", "Sprinkle Donut", 1.75);
INSERT INTO DONUTS VALUES(6, "Gluten-Free", "Gluten-Free Donut", 2.00);

INSERT INTO INVOICE_ITEMS VALUES(1, 3, 10);
INSERT INTO INVOICE_ITEMS VALUES(1, 4, 5);
INSERT INTO INVOICE_ITEMS VALUES(2, 1, 12);
INSERT INTO INVOICE_ITEMS VALUES(3, 6, 3);  
--1.F.1

--1.G.1
SELECT * 
FROM DONUTS;
SELECT *
FROM INVOICES;
SELECT *
FROM INVOICE_ITEMS;
SELECT *
FROM CUSTOMERS;
--1.G.1

--1.G.2
SELECT CUSTOMERS.CUS_ID, CUS_FNAME, CUS_LNAME, CUS_STREET, CUS_APTNUM, CUS_CITY, CUS_STATE, CUS_ZIP, CUS_HOMENUM,
    CUS_CELLNUM, CUS_OTHERNUM, INVOICES.ORDER_ID, ORDER_DATE, NOTES, DONUT_NAME, DONUT_DESC, DONUT_PRICE
    FROM CUSTOMERS JOIN INVOICES ON CUSTOMERS.CUS_ID = INVOICES.CUS_ID
    JOIN INVOICE_ITEMS ON INVOICES.ORDER_ID = INVOICE_ITEMS.ORDER_ID
    JOIN DONUTS ON INVOICE_ITEMS.DONUT_ID = DONUTS.DONUT_ID;
--1.G.2