ad_page_contract {
This page will create an item for the todo list package
} {
item_id,
title,
description,
status
}
set context_id [ad_conn package_id]
db_exec_plsql new_task {}

permission::grant -party_id $user_id \
-object_id $item_id \
-privilege "general_comments_create"
