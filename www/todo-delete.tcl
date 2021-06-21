ad_page_contract {
This page will delete an item from the todo list package and then return the user
to the specified return URL.
} {
item_id
}
permission::require_permission -object_id $item_id -privilege delete
set user_id [ad_conn user_id]

db_dml delete_item "delete from todo_item where item_id = :item_id"
