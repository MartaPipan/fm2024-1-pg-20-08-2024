-- Видалення таблиць, якщо вони існують
DROP TABLE IF EXISTS products_in_shipments;
DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS contracts;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS receivers;

-- Таблиця products: інформація про товари
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) NOT NULL CHECK (code != ''),  -- Код товару
    name VARCHAR(255) NOT NULL CHECK (name != ''), -- Назва товару
    price NUMERIC(10, 2) NOT NULL, -- Ціна товару
    CONSTRAINT unique_product_code UNIQUE (code) -- Унікальність коду товару
);

-- Таблиця customers: інформація про замовників
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL CHECK (name != ''),  -- Ім'я замовника
    address VARCHAR(255) NOT NULL CHECK (address != ''),  -- Адреса замовника
    phone VARCHAR(20) NOT NULL CHECK (phone != ''),  -- Телефон замовника
    CONSTRAINT unique_customer_phone UNIQUE (phone) -- Унікальність телефону замовника
);

-- Таблиця contracts: інформація про договори, які також виступають як замовлення
CREATE TABLE contracts (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,  -- Ідентифікатор замовника
    number VARCHAR(50) NOT NULL CHECK (number != ''),  -- Номер договору
    date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- Дата укладення договору
    product_id INT NOT NULL,  -- Ідентифікатор товару
    planned_quantity INT NOT NULL CHECK (planned_quantity > 0),  -- Планована кількість товару за договором
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,  -- Зв'язок із замовником
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,  -- Зв'язок із товаром
    CONSTRAINT unique_contract_number UNIQUE (number)  -- Унікальність номера договору
);

-- Таблиця receivers: інформація про отримувачів
CREATE TABLE receivers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL CHECK (name != ''),  -- Ім'я отримувача
    address VARCHAR(255) NOT NULL CHECK (address != ''),  -- Адреса отримувача
    phone VARCHAR(20) NOT NULL CHECK (phone != ''),  -- Телефон отримувача
    CONSTRAINT unique_name_phone UNIQUE (name, phone)  -- Унікальність отримувача за ім'ям та телефоном
);

-- Таблиця shipments: фактичні відвантаження товарів
CREATE TABLE shipments (
    id SERIAL PRIMARY KEY,
    contract_id INT NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,  -- Посилання на контракт
    date TIMESTAMP NOT NULL,  -- Дата відвантаження
    receiver_id INT NOT NULL REFERENCES receivers(id) ON DELETE CASCADE  -- Посилання на отримувача
);

-- Таблиця products_in_shipments: товари у відвантаженнях
CREATE TABLE products_in_shipments (
    shipment_id INT NOT NULL,  -- Посилання на відвантаження
    product_id INT NOT NULL,  -- Посилання на товар
    shipped_quantity INT NOT NULL CHECK (shipped_quantity > 0),  -- Кількість відвантаженого товару
    PRIMARY KEY (shipment_id, product_id),  -- Комбінований первинний ключ
    FOREIGN KEY (shipment_id) REFERENCES shipments(id) ON DELETE CASCADE,  -- Зв'язок із відвантаженням
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE  -- Зв'язок із товаром
);
