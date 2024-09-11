-- Спочатку видаляємо таблиці, якщо вони існують
DROP TABLE IF EXISTS receivers;
DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS requests;
DROP TABLE IF EXISTS contracts; 
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- Таблиця products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,   
    code_product VARCHAR(10) NOT NULL CHECK (code_product != ''), 
    product_name VARCHAR(255) NOT NULL CHECK (product_name != ''),
    price NUMERIC(10, 2) NOT NULL, 
    CONSTRAINT unique_product_code UNIQUE (code_product) 
);

-- Таблиця customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,  
    customer_name VARCHAR(255) NOT NULL CHECK (customer_name != ''), 
    customer_address VARCHAR(255) NOT NULL CHECK (customer_address != ''),
    customer_phone VARCHAR(20) NOT NULL CHECK (customer_phone != ''), 
    CONSTRAINT unique_customer_phone UNIQUE (customer_phone) 
);

-- Об'єднана таблиця contracts з продуктами в контракті
CREATE TABLE contracts (
    contract_id SERIAL PRIMARY KEY,  
    customer_id INT NOT NULL,        
    contract_number VARCHAR(50) NOT NULL CHECK (contract_number != ''),  
    contract_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    product_id INT NOT NULL,         
    planned_quantity INT NOT NULL CHECK (planned_quantity > 0), -- Кількість товару в контракті
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    CONSTRAINT unique_contract_number UNIQUE (contract_number)  
);

-- Об'єднана таблиця requests з продуктами в замовленні
CREATE TABLE requests (
    request_id SERIAL PRIMARY KEY,   
    contract_id INT NOT NULL,        
    product_id INT NOT NULL,         
    request_quantity INT NOT NULL CHECK (request_quantity > 0),
    FOREIGN KEY (contract_id) REFERENCES contracts(contract_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Таблиця receivers
CREATE TABLE receivers (
    receiver_id SERIAL PRIMARY KEY,      
    receiver_name VARCHAR(255) NOT NULL CHECK (receiver_name != ''),
    receiver_type VARCHAR(50) NOT NULL CHECK (receiver_type IN ('customer', 'individual', 'company')),
    receiver_address VARCHAR(255) NOT NULL CHECK (receiver_address != ''),
    receiver_phone VARCHAR(20) NOT NULL CHECK (receiver_phone != ''),
    CONSTRAINT unique_receiver_name_phone UNIQUE (receiver_name, receiver_phone) 
);

-- Об'єднана таблиця shipments з продуктами в замовленні
CREATE TABLE shipments (
    shipment_id SERIAL PRIMARY KEY,   
    request_id INT NOT NULL,          
    shipment_date TIMESTAMP NOT NULL, 
    receiver_id INT NOT NULL,         
    received_date TIMESTAMP NOT NULL, 
    FOREIGN KEY (request_id) REFERENCES requests(request_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES receivers(receiver_id) ON DELETE CASCADE
);

