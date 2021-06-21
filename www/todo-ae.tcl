if { [exists_and_not_null item_id] && [acs_object::object_p -id $item_id]} {
if {[string equal $form_mode "edit"]} {
permission::require_permission -object_id $item_id -privilege write
} else {
permission::require_permission -object_id $item_id -privilege read
}
}
ad_page_contract {
This page allows the users to add new items to their to do list or edit existing items.
} {
item_id:optional
{form_mode "edit" }
}
set page_title "Add/Edit Todo Item"
set user_id [ad_conn user_id]
set package_id [ad_conn package_id]
set ip_address [ad_conn peeraddr]
set context_id [ad_conn package_id] 

ad_form -name todo_item_form -export {user_id package_id} -mode $form_mode -form {
item_id:key
{title:text {label "Task Title"} }
{description:text(textarea),optional {label "Description"}}
{due_date:date(date) {label "Due Date: "} {format {MONTH DD YYYY} } }
{status:text(select) {label "Status"}
 {options { {"Pending" "p"}
 {"Complete" "c"}
 {"Canceled" "x" }
 } }
}
} -select_query_name select_task \
-new_data {
    set context_id [ad_conn package_id]
    db_exec_plsql new_task {}

    permission::grant -party_id $user_id \
    -object_id $item_id \
    -privilege "general_comments_create"
    
} -edit_data {
 # update the information on our table
 db_dml update_task {}
 # update the last modified information on the object
 db_exec_plsql to_do_list_obj_item_object_update {
 select acs_object__update_last_modified(:item_id,:user_id,:ip_address)
 }
} -after_submit {
    ad_returnredirect index
    ad_script_abort
}
if {
    [string equal $form_mode "display"]
} {
    set comment_add_url "[general_comments_package_url]comment-add?[export_vars {
        {
            object_id $item_id
        } {
            return_url [util_get_current_url]}
            }]"
            set comments_html [general_comments_get_comments -print_content_p 1 $item_id [util_get_current_url]]
        }