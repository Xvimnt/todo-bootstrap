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