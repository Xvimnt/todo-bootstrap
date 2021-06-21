<?xml version="1.0"?>
<queryset>
   <fullquery name="new_task">
      <querytext>
        select todo_item__new (
            :item_id,
            :title,
            :description,
            :status,
            :user_id,
            to_date(:due_date, 'YYYY MM DD'),
            :ip_address,
            :context_id
        );
      </querytext>
   </fullquery>
   <fullquery name="select_task">
      <querytext>
        select todo.title,
        todo.description,
        to_char(todo.due_date, 'YYYY-MM-DD') as due_date,
        todo.status
        from todo_item todo,
        acs_objects obj
        where todo.item_id = :item_id
        and obj.object_id = todo.item_id
        and obj.creation_user = :user_id
        and obj.context_id = :package_id
      </querytext>
   </fullquery>
   <fullquery name="update_task">
      <querytext>
        update todo_item
        set title= :title,
        description = :description,
        status = :status,
        due_date = to_date(:due_date, 'YYYY MM DD')
        where item_id = :item_id
      </querytext>
   </fullquery>
</queryset>