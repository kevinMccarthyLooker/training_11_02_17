view: inventory_items {
  sql_table_name: public.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}.product_distribution_center_id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
    value_format_name: usd
  }

#   dimension: cost_tier {
#     type: tier
#     tiers: [10,20,50,100,200]
#     style: relational
#     sql: ${cost} ;;
#   }

  dimension_group: created {
    type: time
    timeframes: [raw,date,month,year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_brand {
    label: "Brand"
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_category {
    label: "Category"
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: product_department {
    label: "Department"
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name;;
#     sql: ${TABLE}.product_name || '(' || ${product_sku} ||')';;
  }

  dimension: product_retail_price {
    label: "Retail Price"
    type: number
    sql: ${TABLE}.product_retail_price ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
  }


  dimension_group: sold {
    type: time
    timeframes: [raw,date,month,year]
    sql: ${TABLE}.sold_at ;;
  }

#   dimension: is_sold {
#     type: yesno
#     sql: ${sold_raw} is not null ;;
#   }

  measure: count {
    type: count
    drill_fields: [id, product_name, products.id, products.name, order_items.count]
  }

#   measure: count_sold {
#     type: count
#     filters: {
#       field: is_sold
#       value: "Yes"
#     }
#   }

}
