-- Create the "Departments" table
CREATE TABLE Departments (
    DepartmentID INT IDENTITY PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL,
    NumberOfCounters INT NOT NULL,
    NumberOfSellers INT NOT NULL,
    HallNumber INT NOT NULL
);

-- Create the "Customers" table
CREATE TABLE Customers (
    CustomerID INT IDENTITY PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL
);

-- Create the "Suppliers" table
CREATE TABLE Suppliers (
    SupplierID INT IDENTITY PRIMARY KEY,
    SupplierName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    Country NVARCHAR(100) NOT NULL,
    TransportType NVARCHAR(50) NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL
);

-- Create the "Products" table
CREATE TABLE Products (
    ProductID INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL FOREIGN KEY REFERENCES Departments(DepartmentID),
    SupplierID INT NOT NULL FOREIGN KEY REFERENCES Suppliers(SupplierID),
    StorageConditions NVARCHAR(255) NOT NULL,
    ShelfLife NVARCHAR(50) NOT NULL
);

-- Create the "Sales" table
CREATE TABLE Sales (
    SaleID INT IDENTITY PRIMARY KEY,
    CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customers(CustomerID),
    ProductID INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID),
    SaleDate DATE NOT NULL,
    SaleTime TIME NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Total AS (Quantity * Price) PERSISTED
);
