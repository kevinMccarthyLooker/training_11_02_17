view: distribution_centers {
  sql_table_name: public.distribution_centers ;;
#   label: "Inventory Item"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

#   dimension: distribution_center_location {
#     type: location
#     sql_latitude: ${latitude} ;;
#     sql_longitude: ${longitude} ;;
#   }

  dimension: name {
#     label: "Distribution Center Location Name"
#     description: "Where the inventory item was produced"
    type: string
    sql: ${TABLE}.name ;;
  }

}
