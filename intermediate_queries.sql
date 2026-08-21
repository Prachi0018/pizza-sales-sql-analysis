-- intermediate queries

-- Q1 join the necessary tabel to find the total quantity of each pizza category ordered

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC; 


-- Q2 determine the distribution of orders by hour of the day

SELECT 
    HOUR(orders_time) AS hour, COUNT(orders_id) AS order_count
FROM
    orders
GROUP BY HOUR(orders_time);



-- Q3 join relevent tables to find the category- wise distribution of pizzas

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;


-- Q4 group the orders by date and calculate the average number of pizzas ordered per day

select 
	round(avg(quantity),0)as avg_pizza_ordered_per_day
from(
	select orders_date,sum(order_details.quantity)as quantity
from 
	orders
join 
	order_details on orders.orders_id = order_details.order_id
group by orders.orders_date) as order_quantity;





-- Q5 determine the top 3 most ordered pizza type based on revenue


select 
	pizza_types.name,
sum(order_details.quantity*pizzas.price) as revenue
from
pizza_types
join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by revenue desc limit 3;