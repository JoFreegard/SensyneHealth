# SensyneHealth
Sensyne Health Technical Test

1. Save the csv file "Assignment Senior Data Engn- agaricus-lepiota - send" to C:\Sensyne 
2. Create the database in localhost\SQLExpress using the script
3. Add the dtsx package to an SSIS solution and execute it to populate the mushrooms table
4. The script called 'Queries' attempts to answer the three questions

Notes:
I decided that keeping as much of the source data as possible is important. Although several columns included values that we do not have lookup values for I do load them int ot he table. It would be easy to update the lookup tables with the missing values at a later stage. If I had enforced referential integrity during the load I would have lost all of the data because we do not have lookup values for the cap shape codes in the source data.
Data profiling revealed that the Time column had some invalid time values in it - the data goes through a cleansing step in the dtsx package. In the cases where the value is not a valid time I decided to set the time to NULL rather than lose the data as none of the queries are related to time.
