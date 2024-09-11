-- Видалення всіх таблиць у правильному порядку 
DROP TABLE IF EXISTS products_in_shipment;
DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS products_in_request;
DROP TABLE IF EXISTS requests;
DROP TABLE IF EXISTS products_in_contract;
DROP TABLE IF EXISTS contracts;
DROP TABLE IF EXISTS receivers;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;


-- Таблиця products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,   -- Унікальний ідентифікатор товару
    code_product VARCHAR(10) NOT NULL CHECK (code_product != ''), -- Код товару
    product_name VARCHAR(255) NOT NULL CHECK (product_name != ''),-- Назва товару
    price NUMERIC(10, 2) NOT NULL,   -- Ціна товару
    CONSTRAINT unique_product_code UNIQUE (code_product) -- Унікальність коду товару
);

-- Таблиця customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,  -- Унікальний ідентифікатор замовника
    customer_name VARCHAR(255) NOT NULL CHECK (customer_name != ''), -- Ім'я замовника
    customer_address VARCHAR(255) NOT NULL CHECK (customer_address != ''), -- Адреса замовника
    customer_phone VARCHAR(20) NOT NULL CHECK (customer_phone != ''),      -- Телефон замовника
    CONSTRAINT unique_customer_phone UNIQUE (customer_phone) -- Унікальний номер телефону замовника
);

-- Таблиця contracts
CREATE TABLE contracts (
    contract_id SERIAL PRIMARY KEY,  -- Унікальний ідентифікатор договору
    customer_id INT NOT NULL,        -- Посилання на замовника
    contract_number VARCHAR(50) NOT NULL CHECK (contract_number != ''),  -- Номер договору
    contract_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата укладання договору
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT unique_contract_number UNIQUE (contract_number)  -- Унікальний номер договору
);

-- Таблиця products_in_contract
CREATE TABLE products_in_contract (
    contract_id INT NOT NULL,        -- Код договору
    product_id INT NOT NULL,         -- Код товару
    planned_quantity INT NOT NULL CHECK (planned_quantity > 0), -- Кількість товару, запланована в договорі
    PRIMARY KEY (contract_id, product_id), -- Комбінований первинний ключ
    FOREIGN KEY (contract_id) REFERENCES contracts(contract_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Таблиця requests
CREATE TABLE requests (
    request_id SERIAL PRIMARY KEY,     -- Унікальний ідентифікатор замовлення
    contract_id INT NOT NULL,        -- Посилання на договір
    FOREIGN KEY (contract_id) REFERENCES contracts(contract_id) ON DELETE CASCADE
);

-- Таблиця products_in_requests
CREATE TABLE products_in_request (
    request_id INT NOT NULL,           -- Код замовлення
    product_id INT NOT NULL,         -- Код товару
    request_quantity INT NOT NULL CHECK (request_quantity > 0),   -- Кількість товару в замовленні
    PRIMARY KEY (request_id, product_id),  -- Комбінований первинний ключ
    FOREIGN KEY (request_id) REFERENCES requests(request_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Таблиця shipments
CREATE TABLE shipments (
    shipment_id SERIAL PRIMARY KEY,    -- Унікальний ідентифікатор відвантаження
    request_id INT NOT NULL,           -- Посилання на замовлення
    shipment_date TIMESTAMP NOT NULL,  -- Дата відвантаження
    receiver_id INT NOT NULL,          -- Посилання на отримувача
    received_date TIMESTAMP NOT NULL,  -- Дата отримання
    FOREIGN KEY (request_id) REFERENCES requests(request_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES receivers(receiver_id) ON DELETE CASCADE
);

-- Таблиця products_in_shipment
CREATE TABLE products_in_shipment (
    shipment_id INT NOT NULL,        -- Код відвантаження
    product_id INT NOT NULL,         -- Код товару
    shipped_quantity INT NOT NULL CHECK (shipped_quantity > 0), -- Кількість фактично відвантаженого товару
    PRIMARY KEY (shipment_id, product_id),  -- Комбінований первинний ключ
    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Таблиця receivers
CREATE TABLE receivers (
    receiver_id SERIAL PRIMARY KEY,      -- Ідентифікатор отримувача
    receiver_name VARCHAR(255) NOT NULL CHECK (receiver_name != ''), -- Ім'я отримувача
    receiver_type VARCHAR(50) NOT NULL CHECK (receiver_type IN ('customer', 'individual', 'company')), -- Тип отримувача: замовник, індивідуальна особа або компанія
    receiver_address VARCHAR(255) NOT NULL CHECK (receiver_address != ''), -- Адреса отримувача
    receiver_phone VARCHAR(20) NOT NULL CHECK (receiver_phone != ''),      -- Телефон отримувача
    CONSTRAINT unique_receiver_name_phone UNIQUE (receiver_name, receiver_phone) -- Унікальність поєднання імені та телефону
);
