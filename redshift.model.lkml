connection: "redshift"

# include all the views
include: "*.view"

datagroup: redshift_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: redshift_default_datagroup

explore: all_types {}

explore: order_items {
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders1 {
  from:  orders
  join: users {
    type: left_outer
    sql_on: ${orders1.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {

}


explore: pdt {}

explore: orders_pdt {}


explore: orders {
  fields: [ALL_FIELDS*, -orders.full_TAT, -orders.full_TAT_buckets]
}
