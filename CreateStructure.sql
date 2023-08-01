-- 2.1 dbo.SKU
CREATE TABLE dbo.SKU (
    ID INT IDENTITY PRIMARY KEY,
    Code AS 's' + CAST(ID AS VARCHAR(50)) PERSISTED UNIQUE, -- Вычисляемое поле "Code"
    Name VARCHAR(255) NOT NULL
);

-- 2.2 dbo.Family
CREATE TABLE dbo.Family (
    ID INT IDENTITY PRIMARY KEY,
    SurName VARCHAR(100) NOT NULL,
    BudgetValue DECIMAL(18, 2) NOT NULL
);

-- 2.3 dbo.Basket
CREATE TABLE dbo.Basket (
    ID INT IDENTITY PRIMARY KEY,
    ID_SKU INT FOREIGN KEY REFERENCES dbo.SKU(ID),
    ID_Family INT FOREIGN KEY REFERENCES dbo.Family(ID),
    Quantity INT NOT NULL CHECK (Quantity >= 0), -- Ограничение, что поле Quantity и Value не могут быть меньше 0
    Value DECIMAL(18, 2) NOT NULL CHECK (Value >= 0),
    PurchaseDate DATE DEFAULT GETDATE() -- значение по умолчанию для поля PurchaseDate: дата добавления записи (текущая дата) 
);
