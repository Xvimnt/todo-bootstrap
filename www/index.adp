<master src="master">

<div class="row">
    <div class="col-md-12">
        <table class="table" id="myTable" style="width: 100%;">
            <thead class="bg-warning">
                <tr>
                    <td scope="col" >Task Title</td>
                    <td scope="col">Status</td>
                    <td scope="col">Due Date</td>
                    <td scope="col">Options</td>
                </tr>
            </thead>
            <tbody>
                <multiple name="todo_list_mr">
                        <tr scope="row">
                            <td>@todo_list_mr.title@</td>
                            <td>
                                <switch @todo_list_mr.status@>
                                    <case value="p">
                                            Pending
                                    </case>
                                    <case value="c">
                                            Completed
                                    </case>
                                    <case value="x">
                                            Canceled
                                    </case>
                                    <default>
                                            Unknow
                                    </default>
                                </switch>
                            </td>
                            <td>@todo_list_mr.due_date@</td>
                            <td width="50px">
                                <div class="btn-group" role="group" aria-label="Options">
                                    @todo_list_mr.delete_button;noquote@
                                    @todo_list_mr.complete_button;noquote@
                                    @todo_list_mr.cancel_button;noquote@
                                </div>
                            </td>
                        </tr>  
                </multiple>
            </tbody>    
        </table>
    </div>
</div>
<div class="row"> 
    <div class="col-md-12 text-center">
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#staticBackdrop">
          Add New Task
        </button>
    </div>
</div>
<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">Add new task</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <formtemplate id="todo_item_form">
            <div class="row">
                <div class="col-md-6">
                    <label for="title">Task Title: </label>
                    <formwidget id="title" class="form-control">
                    <formerror id="title" type="no_special_characters">
                        The title may not not contain special characters such as 
                        @, $, !, %, & or #.
                    </formerror>
                </div>
                <div class="col-md-6">
                    <label for="status">Status: </label>
                    <formwidget id="status" class="form-control">
                    <formerror id="status" type="no_special_characters">
                        The title may not not contain special characters such as 
                        @, $, !, %, & or #.
                    </formerror>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <label for="description">Description: </label>
                    <formwidget id="description" class="form-control">
                    <formerror id="description" type="no_special_characters">
                        The description may not not contain special characters such as 
                        @, $, !, %, & or #.
                    </formerror>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <label for="due_date">Due Date: </label>
                    <formwidget id="due_date" class="form-control">
                    <formerror id="due_date" type="no_special_characters">
                        The description may not not contain special characters such as 
                        @, $, !, %, & or #.
                    </formerror>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-md-12 text-center">
                    <button class="btn btn-warning" onclick="save_task()">Save</button>
                </div>
            </div>
        </formtemplate>
      </div>
    </div>
  </div>
</div>
<blockquote>
  <slave>
</blockquote>
<script>
    $(document).ready(function() {
        $('#myTable').DataTable({
            responsive: true
        });
    });

    function delete_item( item_id ) {
        Swal.fire({
            title: 'Do you want to delete this item?',
            showCancelButton: true,
            confirmButtonText: `Yes`,
            icon: 'warning',
            }).then((result) => {
                if (result.isConfirmed) {
                   post_delete(item_id);
                }
            })  
    }

    function post_delete(item_id) {
        $.ajax({
            type: "POST",
            url: "todo-delete.tcl",
            data: {item_id: item_id},
            success: function (data, textStatus, jqXHR) {
                setTimeout(function() { 
                    Swal.fire("success","success","success")
                    window.location.reload();
                }, 1000);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error Loading: "+errorThrown)
            }
        });
    }

    function save_task() {
        $.ajax({
            type: "POST",
            url: "todo-create.tcl",
            data: {
                status: $("#status").val(),
                description: $("#description").val(),
                item_id: "@item_id@",
                due_date: $("#due_date").val(),
            },
            success: function (data, textStatus, jqXHR) {
                setTimeout(function(){
                    Swal.fire("success","success","success")
                    window.location.reload();
                }, 1000);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Error Loading: "+errorThrown)
            }
        });
    }
</script>