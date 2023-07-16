Requirement: 
•Microsoft Visual Studio 2019 or higher
•ASP.Net Core 3.1

Step 1: Create and Configure a new empty project

Step 2: Make sure to add these packages via NuGet Package Manager. 

Step 3: Configure the Startup.cs file 

Step 4:Create the Category Model, which will eventually be Category Table

Step 5: Create the Product Model which will eventually be the Product Table.

Step 6: Create a ProductRepository for all our operations. 

Step:7 Create an interface IProductRepository to access the ProductRepository.

Step:8Create a ProductContext to build the model for the database; this will be a Code First Database Approach

Step:9Add a ProductController to get an endpoint for the APIs

Step 10: Add the connection string settings to connect the project to the SQLSERVER database. 
Once added run add-migration command to run the migration

Step 11: Run the update-database command to reflect the model changes to the database.

Step 12: Try to run the project, you will see that a browser window opens with an empty list. 

Step 13: Using Postman try to add a product into the product table via the API call.	
Step 14: You will notice the SQL table to populate with that product. 

Step 15: Add another Product to test.

Step 16: Get all the added products using GET. 

Step 17: Delete a product using DELETE. 

Step 18: Check is product is deleted using GET again

Step 19: Update a product using the PUT

Step 20: Now create a docker container and image of the product. Right click the project and select Container Orchestrator Support and select Ok. 

Step 21: Select the target docker OS support which will be LINUX

Step 22: You can select Yes to run the Docker desktop too. 

Step 23: Run the docker commands ‘docker images’ to see the created image of your project. 

Step 24: Run the Project with the option Docker Compose on the Play. 

Step 25: Run the docker pscommand to check the running docker container. 

Step 26: Check docker desktop for the running image.

Step 27: The docker image and containers will be running in the docker desktop app.
