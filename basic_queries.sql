use pizzahut;

-- basic queries 
-- Q1 Retrieve the total number of orders placed

SELECT 
    count(orders_id) AS total_orders
FROM
    orders;


-- Q2 caculate the total revenue generated from pizzas sales

SELECT 
    ROUND(SUM(order_details.quantity*pizzas.price), 2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
    

--  Q3 identify the highest priced pizza
   
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
   
-- Q4 identify the most comman pizza size ordered

SELECT 
    pizzas.size,
    COUNT(order_details.order_detalis_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;



-- Q5 list the top most ordered pizza types anlong with their quqntity

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;
