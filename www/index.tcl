ad_page_contract {
This page will display a list of to do items belonging to the current user.
} {
orderby:optional
}
set page_title "My To Do List"
set user_id [ad_conn user_id]
set package_id [ad_conn package_id]
template::list::create -name todo_list \
-multirow todo_list_mr \
-elements {
 title {
 label "Task"
 link_url_col item_url
 link_html {title "Click to view this item details" }
}
 due_date_pretty {
 label "Due Date"
 
}
 status_text {
 label "Status"
 
}
 creation_date_pretty {
 label "Creation Date"
 
}
 view {
 display_template "View"
 link_url_col item_url
 
}
 completed {
 display_template "Mark Completed"
 link_url_col completed_url
}
 cancel {
 display_template "Cancel"
 link_url_col cancel_url
}
} -orderby {
title {orderby todo.title}
due_date_pretty {orderby todo.due_date}
status_text {orderby todo.status}
creation_date_pretty {orderby obj.creation_date}
} -actions {
"Add New Task" "todo-ae" "Click here to add a new item to the list"
}
if {[exists_and_not_null orderby]} {
 set orderby_clause "ORDER BY [template::list::orderby_clause -name todo_list]"
} else {
 set orderby_clause "ORDER BY due_date asc"
}
db_multirow -extend { item_url cancel_url delete_url completed_url status_text delete_button complete_button cancel_button} todo_list_mr get_tasks {} {
    set form_mode display
    set item_url "todo-ae?[export_vars -url { item_id form_mode }]"
    set status_text [todo::get_status_label $status ]
    set return_url [util_get_current_url]
    set delete_button "<button type='button' class='btn btn-danger' onclick='delete_item($item_id)'>Delete</button>"
    set complete_button "<button type='button' class='btn btn-success' onclick='complete_item($item_id)'>Complete</button>"
    set cancel_button "<button type='button' class='btn btn-warning' onclick='cancel_item($item_id)'>Cancel</button>"
    if { $status != "c" } {
    set new_status completed
    set completed_url "todo-update-item?[export_vars -url {item_id new_status return_url}]"
    set delete_url "todo-delete?[export_vars -url {item_id return_url}]"
    }
    if { $status != "x" } {
    set new_status canceled
    set cancel_url "todo-update-item?[export_vars -url {item_id new_status return_url}]"
    }
}

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
