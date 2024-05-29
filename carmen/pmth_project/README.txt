STEPS TO USE:  
1) create a parent folder where all the outputs will go, call it pmth_project, and save the attached files inside
2) open the excel and update columns 1 and 2 only.  You don't need to fix the backslashes (my code will do it for you, finally :) )  
3) open pmth_master and update just the first cell by adding the path to the parent folder from step 1.
4) run pmth_master like you did before.  
5) make sure that the suite2p folder paths (from step 2) all contain an npz file. 

WHAT this code does: 

1) the pmth_master will create a new output folder where all the plots will go. 
2) it will then read the excel file to find where all the suite2p files are located. 
3) for each suite2p folder that you list, it will create a subfolder in the output folder where it will save all the plots
4) it will also update the excel with key figures, so you can see them all in one place.

For the next version, I'll add as one of the outputs an excel with all of the plots in numeric form.   