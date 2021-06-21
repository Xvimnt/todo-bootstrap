<master src="index">
<!-- Modal -->
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
        <if @form_mode@ eq "display">
        <a href="@comment_add_url@">Add a comment</a>
        <p>
        @comments_html;noquote@
        </if>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
    function save_task(){
        alert($("#status").val() + "," + $("#description").val()+ "," +$("#due_date").day.val() + "," + "@item_id@");
        $.ajax({
            type: "POST",
            url: "todo-ae.tcl",
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
