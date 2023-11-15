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

Атрибуты таблиц представлены в файле [Описание_таблиц_и_атрибутов_БД_coffe_shop_practice.pdf](https://github.com/Satura/SQL_HW/blob/main/%D0%9E%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5_%D1%82%D0%B0%D0%B1%D0%BB%D0%B8%D1%86_%D0%B8_%D0%B0%D1%82%D1%80%D0%B8%D0%B1%D1%83%D1%82%D0%BE%D0%B2_%D0%91%D0%94_coffe_shop_practice.pdf)

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
  
8.	Используя витрину в качестве табличного выражения или подзапроса, посчитать количество транзакций по полю gender.
9.	Рассчитать количество проданных и пропавших продуктов на дату.
10.	Посчитать количество клиентов по поколениям.
11.	Найти топ 10 самых продаваемых товаров каждый день и проранжировать их по дням и кол-ву проданных штук.
12.	Найти разницу между выручкой в текущий и предыдущий день.
13.	Посчитать кумулятивное число проданных продуктов по дням.
14.	Найти разницу между максимальной и минимальной ценой товара в категории.
15.	Написать запрос для сравнения общей суммы транзакций на каждый день в сравнении с днями предыдущей недели.
16.	Вывести рейтинг работников кофейни по количеству обработанных заказов (транзакций) по каждому дню. Кто из работников обработал максимальное кол-во заказов 2019-04-05?
