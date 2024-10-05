                                      /* QUESTION AND ANSWERS FOR MYSQL */

/* 1. Find the Number of the Genre Name in the Genre Table */
SELECT
    COUNT(name) 'No of Genre Name'
FROM
    genre;


/* 2. Find the SUM of invoice */
SELECT 
    ROUND(SUM(total), 0) AS Total_Invoice_Price
FROM
    invoice;


/* 3. Find the Latest Name of the Media from the MediaType */
SELECT 
    MediaTypeId, name AS Media_Name
FROM
    mediatype
ORDER BY MediaTypeId DESC
LIMIT 1;


/* 4. Find the Billing Countries and the Total Sales of it. */
SELECT 
    billingcountry AS Billing_Country,
    ROUND(SUM(total), 0) AS Total_Sales
FROM
    invoice
GROUP BY billingcountry;


/* 5. find the largest Track in the Database */
SELECT 
    trackid, name, milliseconds / 1000
FROM
    track
ORDER BY milliseconds DESC
LIMIT 1;


/* 6. Find the Top 5 most Bytes in Track */
SELECT 
    name, Bytes, unitprice
FROM
    track
ORDER BY bytes DESC
LIMIT 5;


/* 7. Find the Number of Quantity are Bill for an State */
SELECT 
    COUNT(quantity) AS No_of, billingstate
FROM
    invoiceline
        JOIN
    invoice ON invoiceline.invoiceid = invoice.invoiceid
GROUP BY billingstate;


/* 8. Write a Query to Display Total Number of the unique ID for Artist */
SELECT 
    SUM(DISTINCT (artistid)) AS Unique_ID
FROM
    artist;


/* 9. Write a Query to Display Name and MediaType_ID for the MediaType */
SELECT 
    MediatypeID, Name
FROM
    mediatype;


/* 10. Write a Query to Display Employees with Customers */
SELECT 
    CONCAT(employee.firstname,
            ' ',
            employee.lastname) AS Employee_Name,
    CONCAT(customer.firstname,
            ' ',
            customer.lastname) AS Customer_Name
FROM
    employee
        JOIN
    customer ON employee.employeeId = customer.customerId; 


/* 11. Write a Query to Display all Billing Detail from Invoice Table and the Customers from Customer table and also Price
 from the Invoiceline table */
SELECT 
    customer.customerId,
    CONCAT(customer.firstname,
            ' ',
            customer.lastname) AS Customer_Name,
    billingaddress,
    billingcity,
    billingstate,
    billingcountry,
    quantity,
    ROUND(SUM(invoiceline.unitprice)) AS Price
FROM
    customer
        RIGHT JOIN
    invoice ON Customer.customerid = invoice.customerid
        JOIN
    invoiceline ON invoice.invoiceid = invoiceline.invoicelineid
GROUP BY customer.customerid , CONCAT(customer.firstname,
        ' ',
        customer.lastname) , billingaddress , billingcity , billingstate , billingcountry , quantity;


/* 12. Write a Query to create an Views from Track Name and */
create View Genre_details as
select genreid, Name from Genre;
 SELECT 
    *
FROM
    genre_details;


/* 13. Write a Query to Display*/
DELIMITER //
CREATE TRIGGER after_invoice_insert
AFTER INSERT ON Invoice
FOR EACH ROW
BEGIN
INSERT INTO InvoiceLog (InvoiceId, LogDate)
VALUES (NEW.InvoiceId, NOW());
END //
DELIMITER ;


/* 14. Write a Query to Display*/
DELIMITER //
CREATE TRIGGER before_invoice_insert
BEFORE INSERT ON Invoice
FOR EACH ROW
BEGIN
    -- Example: Set a default value for a column
    IF NEW.Total IS NULL THEN
        SET NEW.Total = 0;
    END IF;
END //


/* 15. find the Top 5 Customers Who Spend the Most Money in the Store */
SELECT 
    customer.customerid,
    customer.FirstName,
    customer.lastname,
    invoice.Total
FROM
    customer
        JOIN
    invoice ON customer.CustomerId = invoice.CustomerId
ORDER BY invoice.total DESC
LIMIT 5;
