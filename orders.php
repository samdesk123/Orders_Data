<?php
 //create connection
 $connect=mysqli_connect('localhost','root','','test_data');
	
//check connection
 if(mysqli_connect_errno($connect))
 {
	echo 'Failed to connect to database: '.mysqli_connect_error();
}
else
	

$records = "SELECT ot.order_name,
	   cc.company_name,
       oi.product,
       c.name AS cust_name,
       ot.created_at AS order_Date, 
       ROUND(oi.price_per_unit * d.delivered_quantity,2) As Total_Amount
       from customer c
        JOIN customer_companies cc on c.company_id = cc.company_id
        join orders_test ot on ot.customer_id = c.user_id
        join orders_item oi on oi.order_id = ot.id
        join deliveries d on d.order_item_id = oi.order_id";

$result = mysqli_query($connect,$records);

?>

<!DOCTYPE html>  
 <html>  
      <head>  
          <link rel="stylesheet" type="text/css" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
           <script type="application/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
          <script type="application/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 
           <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />  
           <script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>  
           <script src="https://cdn.datatables.net/1.10.12/js/dataTables.bootstrap.min.js"></script>            
           <link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/dataTables.bootstrap.min.css" />  
         
      </head>  
      <body>  
          
           <br /><br />  
           <div class="container"> 
                <label>Start date:</label>
                <input id="startdate" class="date_range_filter" />
                <label>End date:</label>
                <input id="enddate" class="date_range_filter" />
               
                <div class="table-responsive">  
                     <table id="users" class="table table-striped table-bordered">  
                          <thead>  
                               <tr>
                                   <th>Order Name</th>
                                   <th>Customer company</th>
                                   <th>Customer name</th>
                                   <th>Order date</th>
                                   <th>Delivered amount</th>
                                   <th>Total amount</th>
                                </tr> 
                          </thead>  
                          <?php 
                            $totalam = 0;
                          while($row = mysqli_fetch_array($result))  
                          {
                              
                               // echoing the fetched data from the database per column names
                              $totalam = $totalam + $row["Total_Amount"];
                              $date=date_create($row["order_Date"]);
                               echo '  
                               <tr>
                                    <td>'.$row["order_name"].'</td>  
                                    <td>'.$row["company_name"].'</td>  
                                    <td>'.$row["product"].'</td>
                                    <td>'.$row["cust_name"].'</td>  
                                    <td>'. date_format($date,"Y/m/d").'</td> 
                                    <td>'.$row["Total_Amount"].'</td> 
                               </tr>  
                               ';  
                          } 
                      
                        
                          ?>  
                     </table>  
                </div>  
           </div>  
      </body>  
 </html>  
 <script>  
 $(document).ready(function(){ 
    
     var myDataTable = $('#users').DataTable(
     {
        "lengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]]
    } );  
      $('.datepicker').datepicker();
        // I instantiate the two datepickers here, instead of all at once like before.
        // I also changed the dateFormat to match the format of the dates in the data table.
        $("#startdate").datepicker({
          "dateFormat": "yy/mm/dd",
          "onSelect": function(date) {  // This handler kicks off the filtering.
            minDateFilter = new Date(date).getTime();
              console.log(minDateFilter);
            myDataTable.draw(); // Redraw the table with the filtered data.
          }
        }).keyup(function() {
          minDateFilter = new Date(this.value).getTime();
          myDataTable.draw();
        });

        $("#enddate").datepicker({
          "dateFormat": "yy/mm/dd",
          "onSelect": function(date) {
            maxDateFilter = new Date(date).getTime();
            myDataTable.draw();
          }
        }).keyup(function() {
          maxDateFilter = new Date(this.value).getTime();
          myDataTable.draw();
        });

        // The below code actually does the date filtering.
        minDateFilter = "";
        maxDateFilter = "";

        $.fn.dataTableExt.afnFiltering.push(
          function(oSettings, aData, iDataIndex) {
            if (typeof aData._date == 'undefined') {
              aData._date = new Date(aData[4]).getTime(); // Your date column is 4, hence aData[4].
            }

            if (minDateFilter && !isNaN(minDateFilter)) {
              if (aData._date < minDateFilter) {
                return false;
              }
            }

            if (maxDateFilter && !isNaN(maxDateFilter)) {
              if (aData._date > maxDateFilter) {
                return false;
              }
            }

            return true;
          }
        );
 }); 

 </script>
 <script>
            function converDate(d){
         const date = new Date(d);
            options = {
              month:'short',day:'2-digit', hour: 'numeric', minute: 'numeric', 
              timeZone: 'UTC',
              timeZoneName: 'short'
            };
            finaldate = new Intl.DateTimeFormat('en-AU', options).format(date);
            return finaldate;
     }
          </script>