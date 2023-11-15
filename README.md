# Решение домашнего задания по модулю SQL. 
### База сети кофеен содержит таблицы:
- **sales_reciepts** – транзакции покупок

- **sales_goals** – цели продаж по разным кофейням в разных категориях товаров
- **sales_outlet** – справочник кофеен
- **product** – справочник продуктов
- **pastry_inventory** – инвентаризация кондитерских изделий (остатки как испортившиеся товары) 
- **generations** – справочник поколений по годам
- **dates** – справочник дат
- **customer** – справочник клиентов

Атрибуты таблиц представлены в файле ```Описание_таблиц_и_атрибутов_БД_coffe_shop_practice.pdf```

### Задания:
1.	Рассчитать количество транзакций по дням. 
2.	Рассчитать сумму заказов (line_item_amount) в каждом городе (store_city) и магазине. В запросе выведите город, адрес магазина и сумму заказов. Сумму округлить с помощью функции ROUND(). Отсортировать результат в порядке убывания сумм заказов.
3.	Вывести только те названия регионов (neighborhood), где продавался продукт “Columbian Medium Roast” с последней датой продажи в регионе.
4.	Вывести электронные адреса клиентов и определить их домены с помощью функций работы со строками.
5.	Разделить имя клиентов на имя и фамилию, отредактировать номер карты лояльности, убрав пробелы. Вывести количество транзакций (transaction_id) для каждого клиента, отсортировать по убыванию.
6.	Собрать витрину данных из нужных таблиц с выводом атрибутов как на картинке ниже. Для поля gender изменить значения по условию:
Если gender = ‘M’, заменить на ‘Male’,
Если gender = ‘F’, заменить на ‘Female’,
В других случаях проставить ‘Not Defined’.
7.	Используя витрину в качестве табличного выражения или подзапроса, посчитать количество транзакций по полю gender.
8.	Рассчитать количество проданных и пропавших продуктов на дату.
9.	Посчитать количество клиентов по поколениям.
10.	Найти топ 10 самых продаваемых товаров каждый день и проранжировать их по дням и кол-ву проданных штук.
11.	Найти разницу между выручкой в текущий и предыдущий день.
12.	Посчитать кумулятивное число проданных продуктов по дням.
13.	Найти разницу между максимальной и минимальной ценой товара в категории.
14.	Написать запрос для сравнения общей суммы транзакций на каждый день в сравнении с днями предыдущей недели.
15.	Вывести рейтинг работников кофейни по количеству обработанных заказов (транзакций) по каждому дню. Кто из работников обработал максимальное кол-во заказов 2019-04-05?