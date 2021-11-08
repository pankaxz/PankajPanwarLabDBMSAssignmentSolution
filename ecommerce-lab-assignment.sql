-- QuestiON 1 : 
/*
 You are required to create tables for 
 supplier,customer,category,product,productDetails,order,ratINg to store the data for 
 the E-commerce with the schema defINitiON given below.
 */
Create DatabASe if not exists `order-directory`;

use `order-directory`;

CREATE TABLE IF NOT EXISTS `supplier`(
  `SUPP_ID` INT PRIMARY KEY,
  `SUPP_NAME` VARCHAR(50),
  `SUPP_CITY` VARCHAR(50),
  `SUPP_PHONE` VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS `customer` (
  `CUS_ID` INT NOT NULL,
  `CUS_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `CUS_PHONE` VARCHAR(10),
  `CUS_CITY` VARCHAR(30),
  `CUS_GENDER` CHAR,
  PRIMARY KEY (`CUS_ID`)
);

CREATE TABLE IF NOT EXISTS `category` (
  `CAT_ID` INT NOT NULL,
  `CAT_NAME` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`CAT_ID`)
);

CREATE TABLE IF NOT EXISTS `product` (
  `PRO_ID` INT NOT NULL,
  `PRO_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `PRO_DESC` VARCHAR(60) NULL DEFAULT NULL,
  `CAT_ID` INT NOT NULL,
  PRIMARY KEY (`PRO_ID`),
  FOREIGN KEY (`CAT_ID`) REFERENCES category (`CAT_ID`)
);

CREATE TABLE IF NOT EXISTS `product_details` (
  `PROD_ID` INT NOT NULL,
  `PRO_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `PROD_PRICE` INT NOT NULL,
  PRIMARY KEY (`PROD_ID`),
  FOREIGN KEY (`PRO_ID`) REFERENCES product (`PRO_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES supplier(`SUPP_ID`)
);

CREATE TABLE IF NOT EXISTS `order` (
  `ORD_ID` INT NOT NULL,
  `ORD_AMOUNT` INT NOT NULL,
  `ORD_DATE` DATE,
  `CUS_ID` INT NOT NULL,
  `PROD_ID` INT NOT NULL,
  PRIMARY KEY (`ORD_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES customer(`CUS_ID`),
  FOREIGN KEY (`PROD_ID`) REFERENCES product_details(`PROD_ID`)
);

CREATE TABLE IF NOT EXISTS `ratINg` (
  `RAT_ID` INT NOT NULL,
  `CUS_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `RAT_RATSTARS` INT NOT NULL,
  PRIMARY KEY (`RAT_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES supplier (`SUPP_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES customer(`CUS_ID`)
);

-- QuestiON 2 : INsert the followINg data IN the table created above
-- Supplier Table
insert into `supplier` values(1,"Rajesh Retails","Delhi",'1234567890');
insert into `supplier` values(2,"Appario Ltd.","Mumbai",'2589631470');
insert into `supplier` values(3,"Knome products","Banglore",'9785462315');
insert into `supplier` values(4,"Bansal Retails","Kochi",'8975463285');
insert into `supplier` values(5,"Mittal Ltd.","Lucknow",'7898456532');

-- Customer Table
INSERT INTO `CUSTOMER` VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO `CUSTOMER` VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO `CUSTOMER` VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO `CUSTOMER` VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO `CUSTOMER` VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');

-- Category Table
INSERT INTO `CATEGORY` VALUES( 1,"BOOKS");
INSERT INTO `CATEGORY` VALUES(2,"GAMES");
INSERT INTO `CATEGORY` VALUES(3,"GROCERIES");
INSERT INTO `CATEGORY` VALUES (4,"ELECTRONICS");
INSERT INTO `CATEGORY` VALUES(5,"CLOTHES");
  
-- Product Table
INSERT INTO `PRODUCT` VALUES(1,"GTA V","DFJDJFDJFDJFDJFJF",2);
INSERT INTO `PRODUCT` VALUES(2,"TSHIRT","DFDFJDFJDKFD",5);
INSERT INTO `PRODUCT` VALUES(3,"ROG LAPTOP","DFNTTNTNTERND",4);
INSERT INTO `PRODUCT` VALUES(4,"OATS","REURENTBTOTH",3);
INSERT INTO `PRODUCT` VALUES(5,"HARRY POTTER","NBEMCTHTJTH",1);

-- Prodcut_Details Table
INSERT INTO PRODUCT_DETAILS VALUES(1,1,2,1500);
INSERT INTO PRODUCT_DETAILS VALUES(2,3,5,30000);
INSERT INTO PRODUCT_DETAILS VALUES(3,5,1,3000);
INSERT INTO PRODUCT_DETAILS VALUES(4,2,3,2500);
INSERT INTO PRODUCT_DETAILS VALUES(5,4,1,1000);

-- Order Table
INSERT INTO `ORDER` VALUES (50,2000,"2021-10-06",2,1);
INSERT INTO `ORDER` VALUES(20,1500,"2021-10-12",3,5);
INSERT INTO `ORDER` VALUES(25,30500,"2021-09-16",5,2);
INSERT INTO `ORDER` VALUES(26,2000,"2021-10-05",1,1);
INSERT INTO `ORDER` VALUES(30,3500,"2021-08-16",4,3);

-- Rating table
INSERT INTO `RATING` VALUES(1,2,2,4);
INSERT INTO `RATING` VALUES(2,3,4,3);
INSERT INTO `RATING` VALUES(3,5,1,5);
INSERT INTO `RATING` VALUES(4,1,3,2);
INSERT INTO `RATING` VALUES(5,4,5,4);

-- QuestiON 3:
/*
 Display the number of the customer GROUP BY their gENDers who have placed any order 
 of amount greater than or equal to Rs.3000
 */
select C.CUS_GENDER,count(C.CUS_GENDER) as COUNT from `order` O inner join customer C on O.CUS_ID=C.CUS_ID where O.ord_amount>=3000 group by C.CUS_GENDER;

-- QuestiON 4: 
/*
 Display all the orders alONg with the product name ordered by a customer having 
 Customer_Id=2.
 */
select O.*,J.PRO_ID,J.PRO_NAME from `order` O inner join product_details P on O.prod_id=P.prod_id inner join product J on J.pro_id=P.pro_id where O.cus_id = 2;

-- QuestiON 5: Display the Supplier details who can supply more than ONe product
select * from supplier where supp_id in (select supp_id from product_details group by supp_id having count(supp_id) > 1);

-- QuestiON 6: FINd the category of the product whose order amount is mINimum.
select c.cat_name from category c inner join (select product.CAT_ID from product inner join (select P.pro_id from product_details P inner join `order` O on O.prod_id = P.prod_id where O.ord_amount = (select min(ord_amount) from `order`)) as j on product.pro_id = j.pro_id) as k on c.cat_id = k.cat_id;

-- QuestiON 7: Display the Id and Name of the Product ordered after “2021-10-05”.
select j.pro_name,j.pro_id from `order` o inner join product_details p on p.prod_id = o.prod_id inner join product j on p.pro_id=j.pro_id where o.ord_date > '2021-10-5';

-- QuestiON 8:     
/*
 PrINt the top 3 supplier name and id and their ratINg ON the bASis of their ratINg alONg 
 with the customer name who hAS given the ratINg.
 */
select s.SUPP_ID,s.SUPP_NAME,r.RAT_RATSTARS,c.CUS_NAME from supplier s inner join rating r on s.SUPP_ID=r.SUPP_ID inner join customer C on c.CUS_ID=r.CUS_ID order by r.RAT_RATSTARS desc limit 3;

-- QuestiON 9: Display customer name and gENDer whose names start or END with character 'A'.
select c.CUS_NAME,c.CUS_GENDER from customer C where c.CUS_NAME like 'A%' or c.CUS_NAME like '%A';

-- QuestiON 10: Display the total order amount of the male customers
select sum(o.ORD_AMOUNT) as TOTAL_AMOUNT from `order` o inner join customer c on o.CUS_ID = c.CUS_ID where c.CUS_GENDER='M';

-- QuestiON 11: Display all the Customers LEFT OUTER JOIN with the orders
select * from customer c left outer join `order` o on  o.CUS_ID = c.CUS_ID;

-- QuestiON 12:
/*
 Create a stored procedure to display the RatINg for a Supplier if any alONg with the
 Verdict ON that ratINg if any LIKE if ratINg >4 THEN “GenuINe Supplier” if ratINg >2 “Average
 Supplier” ELSE “Supplier should not be cONsidered”.
 */
call supplier_rating();

CREATE DEFINER=`root`@`localhost` PROCEDURE `supplier_rating`()
BEGIN
select s.supp_id,s.supp_name,r.rat_ratstars, 
case
when r.rat_ratstars > 4 then 'Genuine Supplier'
when r.rat_ratstars > 2 then 'Average Supplier'
else 'Supplier should not be considered'
end
as verdict from supplier s inner join rating r on s.supp_id = r.supp_id;
END