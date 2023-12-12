/* 1+ Рассчитайте кол-во транзакций по дням */

SELECT 
	(STRFTIME('%Y', date(transaction_date))) AS date_year,
	(STRFTIME('%m', date(transaction_date))) AS date_month,
	(STRFTIME('%d', date(transaction_date))) AS date_day,
	(COUNT(transaction_id )) AS sale_qty
FROM sales_reciepts
GROUP BY 1, 2, 3;


/* 2+ Рассчитать сумму заказов (line_item_amount) в каждом городе
(store_city) и магазине. В запросе выведите город, адрес магазина и
сумму заказов. Сумму округлите с помощью функции ROUND().
Отсортировать результат в порядке убывания сумм заказов */ 

SELECT 
	store_city,
	store_address,
	ROUND(SUM(line_item_amount)) AS sale_amount
FROM sales_outlet
	JOIN sales_reciepts USING (sales_outlet_id)
GROUP BY 1, 2
ORDER BY 3 DESC; -- (?) в примере в PDF по возрастанию отображено вроде... 


/* 3+ Выведите только те названия регионов (neighborhood), где продавался
продукт “Columbian Medium Roast” с последней датой продажи в регионе. */

SELECT 
	neighborhood,
	MAX(transaction_date) AS last_transaction
 FROM sales_reciepts
	JOIN sales_outlet USING (sales_outlet_id)
	JOIN product USING (product_id)
WHERE product_name = 'Columbian Medium Roast' 
GROUP BY 1


/* 4+ Вывести электронные адреса клиентов и определить их домены с
помощью функций работы со строками */

SELECT 
	email,
	SUBSTR(email, (INSTR(email, '@')+1)) AS email_domain
FROM customer


/* 5+- Разделить имя клиентов на имя и фамилию, отредактировать номер
карты лояльности, убрав пробелы. Вывести количество транзакций
(transaction_id) для каждого клиента, отсортировать по убыванию. */

SELECT 
	customer_name,
	CASE
		WHEN INSTR(customer_name, ' ') = 0 THEN customer_name
		ELSE SUBSTR(customer_name, 0, INSTR(customer_name, ' '))
	END first_name,
	CASE 
		WHEN INSTR(customer_name, ' ') = 0 THEN ''
		ELSE SUBSTR(customer_name, INSTR(customer_name, ' ')+1)
	END last_name,	
	loyalty_card_number,
	REPLACE(loyalty_card_number, '-', '') AS loyalty_card_number_new_format,
	COUNT(transaction_id) AS transaction_qty
FROM customer
	JOIN sales_reciepts USING (customer_id)
GROUP BY customer_name, loyalty_card_number
ORDER BY 6 DESC


/* 6+- Собрать витрину данных из нужных таблиц с выводом атрибутов как
на картинке ниже. Для поля gender изменить значения по условию:
Если gender = ‘M’, заменить на ‘Male’,
Если gender = ‘F’, заменить на ‘Female’,
В других случаях проставить ‘Not Defined’ */

DROP VIEW some_view_1;

CREATE VIEW some_view_1 AS 
SELECT 
	transaction_date,
	sales_outlet_id,
	store_address,
	product_id,
	product_name,
	customer_id,
	customer_name,
		CASE 
			WHEN gender = 'M' THEN 'Male'
			WHEN gender = 'F' THEN 'Female'
			ELSE 'Not Defined'
		END gender,
	unit_price,
	quantity,
	line_item_amount
FROM sales_reciepts
	JOIN sales_outlet USING (sales_outlet_id)
	JOIN product USING (product_id)
	LEFT JOIN customer USING (customer_id)
	
	
/* 7 Используя витрину в качестве табличного выражения или подзапроса,
посчитайте количество транзакций по полю gender */

SELECT 
	gender,
	COUNT(line_item_amount) AS count
FROM some_view_1
GROUP BY gender 


/* 8+  Рассчитайте количество проданных и пропавших продуктов на дату */

SELECT 
	transaction_date,
	SUM(quantity_sold ) AS quantity_sold,
	SUM(waste) AS quantity_wasted
FROM pastry_inventory
GROUP BY transaction_date


/* 9+ Посчитать количество клиентов по поколениям */

SELECT 
	generation,
	COUNT(birth_year) AS customers_count
FROM generations
	JOIN customer USING (birth_year)
GROUP BY generation


/* 10+ Найдите топ 10 самых продаваемых товаров каждый день и
проранжируйте их по дням и кол-ву проданных штук */

SELECT 
	transaction_date, 
	product_name, 
	quantity_sold_per_day,
	rating
FROM (
	SELECT 
		transaction_date, 
		product_name, 
		SUM(quantity) AS quantity_sold_per_day,
		ROW_NUMBER () OVER (PARTITION BY transaction_date ORDER BY SUM(quantity) DESC) AS rating
	FROM sales_reciepts
		JOIN product USING (product_id)
	GROUP BY 1, 2
	ORDER BY 1 ASC, 3 DESC
)
WHERE rating < 11
GROUP BY 1, 2
ORDER BY 1 ASC, 3 DESC


/* 11+ Найдите разницу между выручкой в текущий и предыдущий день */

SELECT 
	transaction_date,
	SUM(line_item_amount) AS sales_amount,
	LAG(SUM(line_item_amount)) OVER w AS prev_sales_amount,
	(SUM(line_item_amount) - LAG(SUM(line_item_amount)) OVER w) AS difference_sales_amount,
	ROUND((SUM(line_item_amount) - LAG(SUM(line_item_amount)) OVER w) / LAG(SUM(line_item_amount)) OVER w * 100) AS percent_difference
FROM sales_reciepts
GROUP BY transaction_date 
WINDOW w AS (ORDER BY transaction_date)


/* 12+ Посчитать кумулятивное число проданных продуктов по дням */

SELECT 
	transaction_date,
	quantity,
	SUM(quantity) OVER (PARTITION BY transaction_date ORDER BY transaction_id) AS com_quantity
FROM sales_reciepts
	
-- вроде так же выходит...
SELECT 
	transaction_date,
	quantity,
	SUM(quantity) OVER (PARTITION BY transaction_date ORDER BY transaction_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS com_quantity
FROM sales_reciepts


/* 13+- Найдите разницу между максимальной и минимальной ценой товара в категории */

/*UPDATE product 
SET current_retail_price = REPLACE(current_retail_price,'$','')

/*SELECT 
	product_category,
	product_type,
	product_name,
	current_retail_price AS retail_price,
	MAX(current_retail_price) OVER w AS max_price_category,
	MIN(current_retail_price) OVER w AS min_price_category,
	MAX(current_retail_price) OVER w - MIN(current_retail_price) OVER w AS diff
FROM product
WINDOW w AS (PARTITION BY product_category)*/

/* 13 (решение 2) Найдите разницу между максимальной и минимальной ценой товара в категории */
SELECT 
	product_category,
	product_type,
	product_name,
	current_retail_price AS retail_price,
	MAX(current_retail_price) OVER w AS max_price_category,
	MIN(current_retail_price) OVER w AS min_price_category,
	max(SUBSTR(current_retail_price, 2)) OVER w - min(SUBSTR(current_retail_price, 2)) OVER w as difference
FROM product
WINDOW w AS (PARTITION BY product_category)


/* 14+  Напишите запрос для сравнения общей суммы транзакций на каждый 
день в сравнении с днями предыдущей недели*/

SELECT 
	transaction_date,
	ROUND(SUM(line_item_amount)) AS trans_amount,
	LAG(ROUND(SUM(line_item_amount)),7) OVER (ORDER BY transaction_date) AS trans_amount_prev_week
FROM sales_reciepts
GROUP BY transaction_date


/* 15+ 
 * 15.1 Сделайте рейтинг работников кофейни по количеству обработанных заказов (транзакций) 
по каждому дню. */

SELECT 
	transaction_date,
	staff_id,
	first_name || ' ' || last_name AS concat,
	COUNT(transaction_id) AS trans_count,
	DENSE_RANK() OVER (PARTITION BY transaction_date ORDER BY COUNT(transaction_date) DESC) AS rating
FROM sales_reciepts
	JOIN staff USING (staff_id)
GROUP BY 1, 2;

-- 15.2 Кто из работников обработал максимальное кол-во заказов 2019-04-05? 

SELECT 
	transaction_date,
	staff_id,
	first_name || ' ' || last_name AS concat,
	COUNT(transaction_id) AS trans_count,
	DENSE_RANK() OVER (PARTITION BY transaction_date ORDER BY COUNT(transaction_date) DESC) AS rating
FROM sales_reciepts
	JOIN staff USING (staff_id)
GROUP BY 1, 2
HAVING transaction_date = '2019-04-05'
LIMIT 1
