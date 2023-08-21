# HomeServices

This is a Django project that provides a web application with various features. The project is containerized using Docker for easy deployment and scalability.

## Features

- Register: Users can create new accounts by providing their email and password and more .
- Confirm Email: An email confirmation link is sent to the user's email address for account activation.
- Login: Registered users can log in using their credentials.
- Forget Password: Users can request a password reset email if they forget their password.
- Home Page: The application has a home page that displays relevant information and options for users.
- User Profile: Each user has a profile page where they can view and update their personal information.
- Update User Information: Users can modify their profile information such as name, profile picture, and contact details.
- Create New Service: Users can create new service listings by providing details and dinamic form for asking questions to the clients.
- Service Details: Each service has a dedicated page displaying its information, including description, price, and seller details and it's rating.
- Update Service: Sellers can modify their existing service details.
- Seller Services: Sellers have a page where they can view all their listed services and informration about fast answare and average ratings.
- Seller Rates: Sellers can view and manage the rates for their services.
- Order Service: Users can place orders for services they wish to avail.
- Sent Orders: Users can view the services they have ordered and track their status.
- Received Orders: Sellers can view and manage the orders they have received.
- Admin and Provider Login: Separate login options are available for administrators and balance providers.
- Charge Balance: Users can add funds to their account balance.
- Earnings: admin can view the earnings and transaction history.

## Class Djagram

## ER Diagram 

## Sequence Diagram




## Deployment with Docker

This project is containerized with Docker, which facilitates easy deployment and ensures consistency across different environments. To deploy the project using Docker, follow these steps:

1. Install Docker on your machine if you haven't already.
1. Clone this repository to your local machine.
1. In the project directory (that have DockerFile) , build the Docker image using the following command:
   ````
   docker build -t django-project .
   ```
1. Once the image is built, you can run the project in a Docker container:
   ````
   docker run -p 8000:8000 django-project
   ```
   This command maps port 8000 from the container to your local machine.
2. Access the application by visiting `http://localhost:8000` in your web browser.

Make sure to configure any necessary environment variables or database settings before running the Docker image.

## Testing

To run the automated tests using pytest, follow these steps:

1. Ensure that the Docker container is running.
2. Open a terminal and navigate to the project directory.
3. Run the following command to execute the tests:
   ````
   docker exec -it <container_id> pytest
   ```
   Replace `<container_id>` with the ID of the running Docker container.
Run this command to show the container_id :
   ```
   docker ps
   ```
1. The test results will be displayed in the terminal, showing any failures or errors encountered.

## Contributing

Contributions to this project are welcome. If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request.
