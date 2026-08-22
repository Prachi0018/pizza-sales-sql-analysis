-- advanced queries
-- Q1 calculate the percentage contribution of each pizza type to total revenue

SELECT 
    pizza_types.category,
    ROUND(
        SUM(order_details.quantity * pizzas.price) /
        (
            SELECT SUM(order_details.quantity * pizzas.price)
            FROM order_details
            JOIN pizzas 
                ON pizzas.pizza_id = order_details.pizza_id
        ) * 100,
        2
    ) AS revenue
FROM pizza_types
JOIN pizzas
    ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
    ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;


-- Q2 analyze the cumulative revenue generated over time

select 
orders_date,
sum(revenue) over (order by orders_date)as cum_revenue
from (
select orders.orders_date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details
join pizzas on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.orders_id = order_details.order_id
group by orders.orders_date) as sales;


-- Q3 determine the top 3 most ordered pizza types based on revenue for each pizza category 


SELECT name, revenue
FROM (
    SELECT category,name,revenue,
        RANK() OVER (PARTITION BY category ORDER BY revenue DESC
        ) AS rn
FROM (
	SELECT 
		pizza_types.category,
		pizza_types.name,
            SUM(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types
	JOIN pizzas 
		ON pizza_types.pizza_type_id = pizzas.pizza_type_id
	JOIN order_details 
		ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 
	pizza_types.category,
	pizza_types.name
    ) AS a
) AS b
WHERE rn <= 3;