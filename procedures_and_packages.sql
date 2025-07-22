
--------------------------------------------------------------------------------
-- PROCEDURE: Transfer stock between warehouses (hypothetical future extension)
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE transfer_stock (
    p_product_id        IN NUMBER,
    p_from_warehouse_id IN NUMBER,
    p_to_warehouse_id   IN NUMBER,
    p_quantity          IN NUMBER
) IS
BEGIN
    UPDATE warehouse_inventory
    SET stock_quantity = stock_quantity - p_quantity
    WHERE product_id = p_product_id AND warehouse_id = p_from_warehouse_id;

    UPDATE warehouse_inventory
    SET stock_quantity = stock_quantity + p_quantity
    WHERE product_id = p_product_id AND warehouse_id = p_to_warehouse_id;

    COMMIT;
END;
/

--------------------------------------------------------------------------------
-- FUNCTION: Get total spending of a customer
--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION get_customer_spending (
    p_customer_id IN NUMBER
) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT SUM(total_amount)
    INTO v_total
    FROM orders
    WHERE customer_id = p_customer_id;

    RETURN NVL(v_total, 0);
END;
/

--------------------------------------------------------------------------------
-- PACKAGE: Order Utility Functions and Procedures
--------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE order_utils_pkg AS
    FUNCTION get_customer_order_count(p_customer_id IN NUMBER) RETURN NUMBER;
    PROCEDURE cancel_order(p_order_id IN NUMBER);
END order_utils_pkg;
/

CREATE OR REPLACE PACKAGE BODY order_utils_pkg AS

    FUNCTION get_customer_order_count(p_customer_id IN NUMBER) RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM orders
        WHERE customer_id = p_customer_id;
        RETURN v_count;
    END;

    PROCEDURE cancel_order(p_order_id IN NUMBER) IS
    BEGIN
        UPDATE orders
        SET order_status = 'Cancelled'
        WHERE order_id = p_order_id;

        UPDATE payments
        SET payment_status = 'Failed'
        WHERE order_id = p_order_id;

        COMMIT;
    END;

END order_utils_pkg;
/
