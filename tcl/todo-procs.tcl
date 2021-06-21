ad_library {
 Procs for the To Do list package.
}
namespace eval todo {}
ad_proc -public todo::get_status_label { status } { 
This procedure receives a status code and returns the corresponding label.
@param status is the status code received.
@return Label corresponding to the status code or Unknown if the status code is not valid
} {
switch $status {
 p {
 set status_text "Pending"
 }
 c {
 set status_text "Completed"
 } 
 x {
 set status_text "Canceled"
 }
 default {
 set status_text "Unknown"
 }
}
return $status_text
}
ad_proc -public todo::get_status_code { status_text } { 
This procedure returns the status code of the task by the label it has.
@param status_text is the status’s label.
@return One character status code.
} {
set status_text [string tolower $status_text]
switch $status_text {
 "pending" {
 set status_code p
 }
 "completed" {
 set status_code c
 } 
 "canceled" {
 set status_code x 
 }
 default {
 set status_code p 
 }
 }
return $status_code
}