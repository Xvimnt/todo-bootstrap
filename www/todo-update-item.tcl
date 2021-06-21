ad_page_contract {
This page will update an item's status from the todo list package 
} {
item_id
new_status
}
permission::require_permission -object_id $item_id -privilege write
set user_id [ad_conn user_id]
set status_code [todo::get_status_code $new_status]
db_dml update_status "update todo_item
 set status = :status_code
 where item_id = :item_id"
