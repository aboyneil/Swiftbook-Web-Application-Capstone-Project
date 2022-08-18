
var tempList = [];
var list = [];
var counter;
var companyName;
function clearAll(){
    tempList = [];
    list = [];
    counter = null;
    companyName = null;
}
function listPushClear(){
    list.push(tempList);
    tempList = [];
}

function getCounter(dataCounter){
    counter = dataCounter;
}
function getList(dataList){
    tempList[counter] = dataList;
}

function printData(){
    for(var i = 0; i < list.length; i++){
        for(var j = 0; j<list[i].length; j++){
            console.log(list[i][j]);
        }
    }

}
function getCompany(varCompanyName){
    companyName = varCompanyName;
}

function downloadBusDetails (){
    

       
         //define the heading for each row of the data  
         var csv = 'Bus Code,Bus Plate Number,Bus Class,Bus Type,Bus Seat Capacity,Bus Status\n';  
           
         //merge the data with CSV  
        list.forEach(function(row) {  
                 csv += row.join(',');  
                 csv += "\n";  
         });  
        
         //display the created CSV data on the web browser   
         //document.write(csv);  
       
          
         var hiddenElement = document.createElement('a');  
         hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);  
         hiddenElement.target = '_blank';  
           
         //provide the name for the CSV file to be downloaded  
         hiddenElement.download = companyName+'_Bus_Details.csv';  
         hiddenElement.click();  

}

function downloadTripDetails (){
    
     
       
    //define the heading for each row of the data  
    var csv = 'Company Name,Terminal,Bus Class,Bus Code,Bus Driver,Bus Seat Capacity,Bus Availability Seat,Bus Type,Departure Date,Departure Time,Origin Route,Destination Route,Price Details,Travel Status,Trip Status\n';  
      
    //merge the data with CSV  
   list.forEach(function(row) {  
            csv += row.join(',');  
            csv += "\n";  
    });  
   
    //display the created CSV data on the web browser   
    //document.write(csv);  
  
     
    var hiddenElement = document.createElement('a');  
    hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);  
    hiddenElement.target = '_blank';  
      
    //provide the name for the CSV file to be downloaded  
    hiddenElement.download = companyName+'_Trip_Details.csv';  
    hiddenElement.click();  

}

function downloadReservationDetails (){
    
     
       
    //define the heading for each row of the data  
    var csv = 'Company Name,Terminal Name,Fullname,Email,Mobile Num,Passenger Category,ID,Seat Number,Percentage Disccount,Discount,Bus Code,Bus Class,Bus Plate Number,Bus Type,Origin Route,Destination Route,Departure Date,Departure Time,Total Price\n';  
      
    //merge the data with CSV  
   list.forEach(function(row) {  
            csv += row.join(',');  
            csv += "\n";  
    });  
   
    //display the created CSV data on the web browser   
    //document.write(csv);  
  
     
    var hiddenElement = document.createElement('a');  
    hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);  
    hiddenElement.target = '_blank';  
      
    //provide the name for the CSV file to be downloaded  
    hiddenElement.download = companyName+'_Reservation_Details.csv';  
    hiddenElement.click();  

}



function downloadAnnualSales (){



    //define the heading for each row of the data
    var csv = 'Month,Sales\n';

    //merge the data with CSV
   list.forEach(function(row) {
            csv += row.join(',');
            csv += "\n";
    });

    //display the created CSV data on the web browser
    //document.write(csv);


    var hiddenElement = document.createElement('a');
    hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
    hiddenElement.target = '_blank';

    //provide the name for the CSV file to be downloaded
    hiddenElement.download = companyName+'_Sales_2022.csv';
    hiddenElement.click();

}


