select
    id as order_id,
    user_id as customer_id,
    order_date,
    status

from one_lake_dev.bronze.tb_eco_jaffle_shop_orders