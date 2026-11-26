CREATE TABLE `payrolls` (
  `id` integer PRIMARY KEY,
  `employee_id` integer NOT NULL,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `gross_salary` decimal(12,2) NOT NULL,
  `net_salary` decimal(12,2) NOT NULL
);

CREATE TABLE `sales_order_items` (
  `id` integer PRIMARY KEY,
  `sales_order_id` integer NOT NULL,
  `product_id` integer NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `discount` decimal(5,2) NOT NULL
);

CREATE TABLE `journal_items` (
  `id` integer PRIMARY KEY,
  `journal_entry_id` integer NOT NULL,
  `account_id` integer NOT NULL,
  `debit` decimal(12,2) NOT NULL,
  `credit` decimal(12,2) NOT NULL
);

CREATE TABLE `inventory_transactions` (
  `id` integer PRIMARY KEY,
  `warehouse_id` integer NOT NULL,
  `product_id` integer NOT NULL,
  `transaction_type` varchar(50) NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `transaction_date` timestamp NOT NULL
);

CREATE TABLE `sales_opportunities` (
  `id` integer PRIMARY KEY,
  `lead_id` integer NOT NULL,
  `title` varchar(150) NOT NULL,
  `stage` varchar(50) NOT NULL,
  `close_date` date NOT NULL
);

CREATE TABLE `production_routing` (
  `id` integer PRIMARY KEY,
  `production_order_id` integer NOT NULL,
  `work_center_id` integer NOT NULL,
  `sequence` integer NOT NULL,
  `setup_time` decimal(8,2) NOT NULL,
  `run_time` decimal(8,2) NOT NULL
);

CREATE TABLE `work_centers` (
  `id` integer PRIMARY KEY,
  `name` varchar(100) NOT NULL,
  `hourly_cost` decimal(12,2) NOT NULL
);

CREATE TABLE `journals` (
  `id` integer PRIMARY KEY,
  `name` varchar(100) NOT NULL,
  `code` varchar(10) NOT NULL
);

CREATE TABLE `attendance` (
  `id` integer PRIMARY KEY,
  `employee_id` integer NOT NULL,
  `work_date` date NOT NULL,
  `check_in` timestamp NOT NULL,
  `check_out` timestamp NOT NULL
);

CREATE TABLE `invoices` (
  `id` integer PRIMARY KEY,
  `customer_id` integer NOT NULL,
  `sales_order_id` integer NOT NULL,
  `invoice_date` date NOT NULL,
  `due_date` date NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `status` varchar(50) NOT NULL
);

CREATE TABLE `users` (
  `id` integer PRIMARY KEY,
  `department_id` integer NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` varchar(50) NOT NULL
);

CREATE TABLE `purchase_orders` (
  `id` integer PRIMARY KEY,
  `vendor_id` integer NOT NULL,
  `branch_id` integer NOT NULL,
  `order_date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL
);

CREATE TABLE `bill_payments` (
  `id` integer PRIMARY KEY,
  `bill_id` integer NOT NULL,
  `account_id` integer NOT NULL,
  `payment_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL
);

CREATE TABLE `bom_items` (
  `id` integer PRIMARY KEY,
  `bom_id` integer NOT NULL,
  `component_product_id` integer NOT NULL,
  `quantity` decimal(12,4) NOT NULL
);

CREATE TABLE `journal_entries` (
  `id` integer PRIMARY KEY,
  `journal_id` integer NOT NULL,
  `entry_date` date NOT NULL,
  `description` varchar(255) NOT NULL,
  `reference` varchar(100) NOT NULL
);

CREATE TABLE `product_categories` (
  `id` integer PRIMARY KEY,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL
);

CREATE TABLE `sales_orders` (
  `id` integer PRIMARY KEY,
  `customer_id` integer NOT NULL,
  `branch_id` integer NOT NULL,
  `order_date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL
);

CREATE TABLE `chart_of_accounts` (
  `id` integer PRIMARY KEY,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL
);

CREATE TABLE `warehouses` (
  `id` integer PRIMARY KEY,
  `branch_id` integer NOT NULL,
  `name` varchar(100) NOT NULL,
  `location` varchar(255) NOT NULL
);

CREATE TABLE `bills` (
  `id` integer PRIMARY KEY,
  `vendor_id` integer NOT NULL,
  `purchase_order_id` integer NOT NULL,
  `bill_date` date NOT NULL,
  `due_date` date NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `status` varchar(50) NOT NULL
);

CREATE TABLE `customers` (
  `id` integer PRIMARY KEY,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL
);

CREATE TABLE `vendors` (
  `id` integer PRIMARY KEY,
  `name` varchar(100) NOT NULL,
  `contact_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL
);

CREATE TABLE `leads` (
  `id` integer PRIMARY KEY,
  `customer_id` integer NOT NULL,
  `source` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `estimated_value` decimal(12,2) NOT NULL
);

CREATE TABLE `purchase_order_items` (
  `id` integer PRIMARY KEY,
  `purchase_order_id` integer NOT NULL,
  `product_id` integer NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_cost` decimal(12,2) NOT NULL
);

CREATE TABLE `branches` (
  `id` integer PRIMARY KEY,
  `company_id` integer NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(50) NOT NULL
);

CREATE TABLE `employees` (
  `id` integer PRIMARY KEY,
  `user_id` integer NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `hire_date` date NOT NULL,
  `salary` decimal(12,2) NOT NULL
);

CREATE TABLE `companies` (
  `id` integer PRIMARY KEY,
  `name` varchar(100) NOT NULL,
  `tax_number` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL
);

CREATE TABLE `departments` (
  `id` integer PRIMARY KEY,
  `branch_id` integer NOT NULL,
  `name` varchar(100) NOT NULL
);

CREATE TABLE `production_orders` (
  `id` integer PRIMARY KEY,
  `product_id` integer NOT NULL,
  `warehouse_id` integer NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` varchar(50) NOT NULL
);

CREATE TABLE `products` (
  `id` integer PRIMARY KEY,
  `category_id` integer NOT NULL,
  `name` varchar(150) NOT NULL,
  `sku` varchar(50) NOT NULL,
  `barcode` varchar(50) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `cost` decimal(12,2) NOT NULL
);

CREATE TABLE `bills_of_materials` (
  `id` integer PRIMARY KEY,
  `product_id` integer NOT NULL,
  `quantity` decimal(12,4) NOT NULL
);

CREATE TABLE `payments` (
  `id` integer PRIMARY KEY,
  `invoice_id` integer NOT NULL,
  `account_id` integer NOT NULL,
  `payment_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL
);

CREATE TABLE `inventory_stocks` (
  `id` integer PRIMARY KEY,
  `warehouse_id` integer NOT NULL,
  `product_id` integer NOT NULL,
  `quantity` decimal(12,4) NOT NULL
);

ALTER TABLE `invoices` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

ALTER TABLE `attendance` ADD FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

ALTER TABLE `purchase_orders` ADD FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`);

ALTER TABLE `invoices` ADD FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`);

ALTER TABLE `inventory_transactions` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `payrolls` ADD FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

ALTER TABLE `sales_orders` ADD FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`account_id`) REFERENCES `chart_of_accounts` (`id`);

ALTER TABLE `warehouses` ADD FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`);

ALTER TABLE `sales_opportunities` ADD FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`);

ALTER TABLE `bill_payments` ADD FOREIGN KEY (`bill_id`) REFERENCES `bills` (`id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`);

ALTER TABLE `bills` ADD FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`);

ALTER TABLE `production_orders` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `sales_orders` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

ALTER TABLE `sales_order_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `products` ADD FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`);

ALTER TABLE `leads` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

ALTER TABLE `bills_of_materials` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `branches` ADD FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

ALTER TABLE `bom_items` ADD FOREIGN KEY (`bom_id`) REFERENCES `bills_of_materials` (`id`);

ALTER TABLE `sales_order_items` ADD FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`);

ALTER TABLE `purchase_order_items` ADD FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`);

ALTER TABLE `purchase_order_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `bills` ADD FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`);

ALTER TABLE `journal_items` ADD FOREIGN KEY (`journal_entry_id`) REFERENCES `journal_entries` (`id`);

ALTER TABLE `inventory_transactions` ADD FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

ALTER TABLE `purchase_orders` ADD FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`);

ALTER TABLE `production_routing` ADD FOREIGN KEY (`production_order_id`) REFERENCES `production_orders` (`id`);

ALTER TABLE `departments` ADD FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`);

ALTER TABLE `inventory_stocks` ADD FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

ALTER TABLE `production_orders` ADD FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

ALTER TABLE `journal_entries` ADD FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`);

ALTER TABLE `journal_items` ADD FOREIGN KEY (`account_id`) REFERENCES `chart_of_accounts` (`id`);

ALTER TABLE `users` ADD FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);

ALTER TABLE `bill_payments` ADD FOREIGN KEY (`account_id`) REFERENCES `chart_of_accounts` (`id`);

ALTER TABLE `bom_items` ADD FOREIGN KEY (`component_product_id`) REFERENCES `products` (`id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `production_routing` ADD FOREIGN KEY (`work_center_id`) REFERENCES `work_centers` (`id`);

ALTER TABLE `inventory_stocks` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);