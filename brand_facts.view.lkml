view: brand_facts {
  derived_table: {
    sql: SELECT
        inventory_items.product_brand  AS "inventory_items.product_brand",
        MAX(inventory_items.cost ) AS "inventory_items.max_cost"
      FROM public.inventory_items  AS inventory_items
      GROUP BY 1
       ;;
  }

  dimension: inventory_items_product_brand {
    primary_key: yes
    type: string
    sql: ${TABLE}."inventory_items.product_brand" ;;
  }

  dimension: inventory_items_max_cost {
    type: string
    sql: ${TABLE}."inventory_items.max_cost" ;;
  }

  dimension: inventory_items_max_cost_tier {
    type: tier
    tiers: [50,100,500]
    sql: ${inventory_items_max_cost} ;;
  }

}
