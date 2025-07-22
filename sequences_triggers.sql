-- Customers
CREATE SEQUENCE seq_customer START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER trg_customer
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
  SELECT seq_customer.NEXTVAL INTO :NEW.customer_id FROM dual;
END;
/

-- Categories
CREATE SEQUENCE seq_category START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER trg_category
BEFORE INSERT ON categories
FOR EACH ROW
BEGIN
  SELECT seq_category.NEXTVAL INTO :NEW.category_id FROM dual;
END;
/

-- Products
CREATE SEQUENCE seq_product START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER trg_product
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  SELECT seq_product.NEXTVAL INTO :NEW.product_id FROM dual;
END;
/

-- Orders
CREATE SEQUENCE seq_order START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER trg_order
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
  SELECT seq_order.NEXTVAL INTO :NEW.order_id FROM dual;
END;
/

-- Order Items
CREATE SEQUENCE seq_order_item START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER trg_order_item
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
  SELECT seq_order_item.NEXTVAL INTO :NEW.order_item_id FROM dual;
END;
/

-- Payments
CREATE SEQUENCE seq_payment START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER trg_payment
BEFORE INSERT ON payments
FOR EACH ROW
BEGIN
  SELECT seq_payment.NEXTVAL INTO :NEW.payment_id FROM dual;
END;
/

-- Shipping
CREATE SEQUENCE seq_shipping START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER trg_shipping
BEFORE INSERT ON shipping
FOR EACH ROW
BEGIN
  SELECT seq_shipping.NEXTVAL INTO :NEW.shipping_id FROM dual;
END;
/
