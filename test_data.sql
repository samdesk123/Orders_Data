-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 12, 2020 at 03:29 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test_data`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetData` ()  SELECT ot.order_name,
	   cc.company_name,
       oi.product,
       c.name AS cust_name, 
       ot.created_at AS order_Date, 
       ROUND(oi.price_per_unit * d.delivered_quantity,2) As Total_Amount
       from customer c
JOIN customer_companies cc on c.company_id = cc.company_id
join orders_test ot on ot.customer_id = c.user_id
join orders_item oi on oi.order_id = ot.id
join deliveries d on d.order_item_id = oi.order_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `user_id` varchar(50) NOT NULL,
  `login` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `company_id` int(10) NOT NULL,
  `credit_cards` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`user_id`, `login`, `password`, `name`, `company_id`, `credit_cards`) VALUES
('ivan', 'ivan', '12345', 'Ivan Ivanovich', 1, '[\"*****-4321\", \"*****-8765\"]'),
('petr', 'petr', '54321', 'Petr Petrovich', 2, '[\"*****-4321\", \"*****-8765\"]');

-- --------------------------------------------------------

--
-- Table structure for table `customer_companies`
--

CREATE TABLE `customer_companies` (
  `company_id` int(10) NOT NULL,
  `company_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer_companies`
--

INSERT INTO `customer_companies` (`company_id`, `company_name`) VALUES
(1, 'Roga & Kopyta'),
(2, 'Roga & Kopyta');

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` varchar(20) NOT NULL,
  `order_item_id` varchar(20) NOT NULL,
  `delivered_quantity` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`id`, `order_item_id`, `delivered_quantity`) VALUES
('1', '1', 5),
('10', '18', 27),
('11', '19', 28),
('12', '20', 29),
('13', '4', 5),
('14', '8', 8),
('15', '8', 6),
('2', '2', 11),
('3', '3', 12),
('4', '4', 3),
('5', '6', 15),
('6', '7', 8),
('7', '8', 3),
('8', '16', 25),
('9', '17', 26);

-- --------------------------------------------------------

--
-- Table structure for table `orders_item`
--

CREATE TABLE `orders_item` (
  `id` varchar(20) NOT NULL,
  `order_id` varchar(20) NOT NULL,
  `price_per_unit` varchar(50) NOT NULL,
  `quantity` int(50) NOT NULL,
  `product` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders_item`
--

INSERT INTO `orders_item` (`id`, `order_id`, `price_per_unit`, `quantity`, `product`) VALUES
('1', '1', '1.3454', 10, 'Corrugated Box'),
('10', '10', '110', 19, 'Corrugated Box'),
('11', '1', '45.2334', 20, 'Hand sanitizer'),
('12', '2', '', 21, 'Hand sanitizer'),
('13', '3', '273.1234', 22, 'Hand sanitiZER'),
('14', '4', '11.45', 23, 'Hand sanitizer'),
('15', '5', '12.467', 24, 'Hand sanitizer'),
('16', '6', '11', 25, 'Hand sanitizer'),
('17', '7', '123', 26, 'Hand sanitizer'),
('18', '8', '173.1234', 27, 'Hand sanitizer'),
('19', '9', '23.876', 28, 'Hand sanitizer'),
('2', '2', '23.14', 11, 'Corrugated Box'),
('20', '10', '120', 29, 'Hand sanitizer'),
('3', '3', '123.0345', 12, 'Corrugated Box'),
('4', '4', '', 13, 'Corrugated Box'),
('5', '5', '100', 14, 'Corrugated Box'),
('6', '6', '1.5454', 15, 'Corrugated Box'),
('7', '7', '25.14', 16, 'Corrugated Box'),
('8', '8', '133.0345', 17, 'Corrugated Box'),
('9', '9', '13.456', 18, 'Corrugated Box');

-- --------------------------------------------------------

--
-- Table structure for table `orders_test`
--

CREATE TABLE `orders_test` (
  `id` varchar(20) NOT NULL,
  `created_at` varchar(30) NOT NULL,
  `order_name` varchar(20) NOT NULL,
  `customer_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders_test`
--

INSERT INTO `orders_test` (`id`, `created_at`, `order_name`, `customer_id`) VALUES
('1', '2020-01-02T15:34:12Z', 'PO #001-I', 'ivan'),
('10', '2020-01-03T10:34:12Z', 'PO #005-P', 'petr'),
('2', '2020-01-15T17:34:12Z', 'PO #002-I', 'ivan'),
('3', '2020-01-05T05:34:12Z', 'PO #003-I', 'ivan'),
('4', '2020-02-02T15:34:12Z', 'PO #004-I', 'ivan'),
('5', '2020-01-03T10:34:12Z', 'PO #005-I', 'ivan'),
('6', '2020-01-02T15:34:12Z', 'PO #001-P', 'petr'),
('7', '2020-01-15T17:34:12Z', 'PO #002-P', 'petr'),
('8', '2020-01-05T05:34:12Z', 'PO #003-P', 'petr'),
('9', '2020-02-02T15:34:12Z', 'PO #004-P', 'petr');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `fk_customer_customercompanies` (`company_id`);

--
-- Indexes for table `customer_companies`
--
ALTER TABLE `customer_companies`
  ADD PRIMARY KEY (`company_id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`(5)),
  ADD KEY `fk_deliveries_orderitem` (`order_item_id`);

--
-- Indexes for table `orders_item`
--
ALTER TABLE `orders_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_orderitems_orderstest` (`order_id`);

--
-- Indexes for table `orders_test`
--
ALTER TABLE `orders_test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ordertest_customer` (`customer_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `fk_customer_customercompanies` FOREIGN KEY (`company_id`) REFERENCES `customer_companies` (`company_id`);

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `fk_deliveries_orderitem` FOREIGN KEY (`order_item_id`) REFERENCES `orders_item` (`id`);

--
-- Constraints for table `orders_item`
--
ALTER TABLE `orders_item`
  ADD CONSTRAINT `FK_orderitems_orderstest` FOREIGN KEY (`order_id`) REFERENCES `orders_test` (`id`);

--
-- Constraints for table `orders_test`
--
ALTER TABLE `orders_test`
  ADD CONSTRAINT `FK_ordertest_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
