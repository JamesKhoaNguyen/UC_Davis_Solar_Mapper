classdef trial
    %trial should store the data of user's location, date, time as well as
    %the raw solar data 
    %each discrete location should be it's own object, meaning that 
    %Example:
    %mondavi_center=trial
    %----Static Objects
   
    %mondavi_center.location_name='Mondavi Center'
    
    %----Possibly Irrelevant Objects
    %mondavi_center.date= some date
    %mondavi_center.coordinates= some coordinates (could be multiple
    %coordinates)
    %It would seem easier to work obj.location_name as the object to
    %reference when plotting data for graph 2 
    
    %-----How to do the time:
    
    %The user must know what to input so there should be information that
    %states that the user should only type in 'early morning','noon','late
    %afternoon'
    
    %This means that there is no actual time object, rather they input the
    %time in a text box and our program simply decides where to put the
    %data
    
    %If the user inputs 'early morning' store the data into the following
    %objects and repeat for the other times
    
    %mondavi_center.early_morning_data= some data
    %mondavi_center.noon_data= some data
    %mondavi_center.late_afternoon_data= some data 
 
    
    properties %these are the variables
        location_coordinates;
        morning_open;
        morning_load;
        noon_open;
        noon_load;
        late_afternoon_open;
        late_afternoon_load;
        date;
        location_name;
     
    end
    methods
        function obj=trial()%constructor function
            obj.location_coordinates='undefined';%will remain 'undefined' until the user enters things into the edit boxes
            obj.morning_open='undefined';
            obj.noon_open = 'undefined';
            obj.late_afternoon_open='undefined';
            obj.morning_load='undefined';
            obj.noon_load='undefined';
            obj.late_afternoon_load='undefined';
            obj.date='undefined';
            obj.location_name='undefined';
          
            
        end 
        
    end
end
        