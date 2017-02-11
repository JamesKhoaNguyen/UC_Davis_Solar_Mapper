
Solar_Gather_GUI.m
1.) Enter your serial port. For windows, refer to the LAB_7.pdf on how to find your serial port.
2.) Click on the “Map of UC Davis” button. Once that map pops up, you can zoom on in the map using a single left click on the mouse, double left click for zooming out, and single right click for selecting that location. The way that it zooms out and zooms in is by using the function ginput2, which is one of the mfiles located in the directory. The map will close itself to indicate that you have already chosen that location. DO NOT close the map figure of UC Davis without inputting coordinates. Otherwise, an error will appear that will force you to shut down MATLAB.
3.) The next thing to do is to indicate that time of day. You can indicate your time of day by choosing morning, noon, or late afternoon. The time of day that you choose will be up to the discretion of you, the user. Once you’ve indicated the time of day, go ahead and click on the “Collect Sunlight” button.
4.) You will notice that your status box is changing. The first thing you will see is, “Data Acquisition in Progress…” Wait a couple of seconds, and it will display, “Remove the open circuit jumper and click here to continue.” Remove the open circuit jumper when prompted in the status box as shown in LAB_7.pdf.  Do not click anywhere else other than the status box. Afterwards, the status box will say, “Data acquisition complete! Choose next time of day.” 
5.) After you have finished collecting sunlight at your current location during your specified time of day, input the date in the box under “Date” and your approximate location in the box under “Approximate Location.” The date must be inputted in MM/DD/YY. Note that when you input Approximate Location, you need to use underscores (‘_’) instead of spaces. 
6.) After all of this, you must specify what trial you are saving this data as by typing in any integer from 1 to infinity into the “Trial Number” box. When “Store trial” is pressed, that specific instance of trial is made up of a class called “trial,” which is located in the “trial.m” file. While they are recording different trials, do not shut down the GUI, MATLAB, or the computer. We suggest that you write down what trial number is to what location. For example, if you recorded data at the Mondavi Center and that data is saved under trial number 1, write down something that will help you remember that trial number 1 is the Mondavi Center. 
7.) If the user clicks on the “Plot interface” button, “GUI_Plots.fig” will open, which is the GUI used to plot all the user’s data points. Along with the “GUI_Plots.fig” there is also the “GUI_Plots.m” associated with it in the directory.
Note: There must be AT LEAST three points recorded on the map in order to interpolate the data.
GUI_Plots.m
1.) Click on the “Plot interface” button on the solar gather GUI. The plot GUI will pop up.
2.) Using the radio buttons, select whether you want to plot voltage or the max calculated power, and select whether to plot the averages, or the raw data. The raw data uses the average of morning, the average of noon, and the average of afternoon as the data inputs. The average button takes the average of al 3 averages as the input data.
3.) If the raw data is selected, three windows will pop up, one for morning, one for noon, and one for afternoon. The plots will be titled up top. If average data is selected, one window will pop up with the average of morning, noon, and afternoon as the data.
4.) You can close the windows as you wish and change the radio buttons and click update to plot different contour plots.
Note: There must be AT LEAST three points recorded on the map in order to interpolate the data.



