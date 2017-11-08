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
#     group_label: "cost fields"
    type: number
    sql: ${TABLE}.cost ;;
    value_format_name: usd
  }

  dimension: cost_tier {
#     group_label: "cost fields"
    type: tier
    tiers: [10,20,50,100,200]
    style: relational
    sql: ${cost} ;;
  }

  dimension_group: created {
    type: time
    timeframes: [raw,date,month,year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension: product_name {
    type: string
#     sql: ${TABLE}.product_name;;
    sql: ${TABLE}.product_name || '(' || ${product_sku} ||')';;
  }

  dimension: product_retail_price {
    type: number
    sql: ${TABLE}.product_retail_price ;;
    value_format_name: usd_0
  }

  dimension: product_retail_price_tier {
    type: tier
    tiers: [10,20,50,100]
    style: integer
    sql: ${product_retail_price} ;;
  }

#   dimension: product_retail_price_tier_manual {
#     type: string
#     sql:
#     case when ${product_retail_price} <10 then 'less than ten'
#     else '10 or more'
#     end
#     ;;
#   }


  dimension_group: sold {
    type: time
    timeframes: [raw,date,month,quarter,week_of_year,year]
    sql: ${TABLE}.sold_at ;;
  }

  dimension: is_sold {
    type: yesno
    sql: ${sold_raw} is not null;;
  }

  measure: count {
    type: count
#     drill_fields: [basic_drill_fields_for_inventory_items*]
  }

  measure: count_sold {
    type: count
    filters: {
      field: is_sold
      value: "Yes"
    }
  }

#   measure: total_cost {
#     type: sum
#     sql: ${cost} ;;
#   }

  measure: max_cost {
    type: max
    sql: ${cost} ;;
  }



  set: basic_drill_fields_for_inventory_items{
    fields: [id, product_name, products.id, products.name, order_items.count]
  }

}
