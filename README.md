# Company Sales App

This application processes sales data from uploaded files, calculates gross income, and provides a summary of sales reports.

## Application Dependencies

- **Ruby 3.3.6**: Programming language.
- **Rails 8.0.2**: Web application framework.
- **pg**: PostgreSQL adapter for ActiveRecord.
- **RSpec**: Testing framework.
- **SimpleCov**: Code coverage analysis tool.
- **Brakeman**: Static analysis for security vulnerabilities.
- **dotenv-rails**: Loads environment variables from `.env`.
---

## Prerequisites

- **Docker**: Ensure Docker is installed on your system. You can download it from [Docker's official website](https://www.docker.com/).
- **Docker Compose**: Comes bundled with Docker Desktop.

---

## Getting Started

### 1. Prepare the Repository

Unzip company-sales-app.zip file and enter in the directory:

```bash
cd company-sales-app
```

### 2. Configure Environment Variables
Create a `.env` file in the root directory and add the following variables:
```
DB_USERNAME=postgres
DB_PASSWORD=postgres
DB_NAME=company-sales-db-dev
```

## Running the App with Docker

### 1. Build the Docker Containers
```
docker compose build
```
### 2. Start the Services
```
docker compose up
```

This will start the following services:

- PostgreSQL Database: Runs the database container.
- Rails Web Server: Runs the Rails application.

### 3. Access the Application
Once the services are running, you can access the application in your browser at:
```
http://localhost:3000
```

## Database Setup

### 1. Create and Migrate the Database
Run the following command to create and migrate the database:
```
docker compose exec web rails db:prepare
```

This will:

Create the development and test databases.
Run all pending migrations.

## Running Tests

### 1. Run RSpec Tests
To run the test suite, use the following command:
```
docker compose exec web rspec
```

### 2. Check SimpleCov Coverage
After running the tests, SimpleCov will generate a coverage report in the coverage/ directory. To view the report:

1. Open the `coverage/index.html` file in your browser:
```
open coverage/index.html
```
2. The report will show the test coverage for your application.

### 3. Run Brakeman
To run Brakeman for static analysis of security vulnerabilities, use the following command:
```
docker compose exec web brakeman
```
This will scan the application for potential security issues and provide a detailed report.
---

## Additional Notes

- **Logs**: To view logs, use:
```
docker compose logs -f
```
- **Stopping Services**: To stop the services, run:
```
docker compose down
```

- **Rebuilding Containers**: If you make changes to the code or dependencies, rebuild the containers::

```
docker compose up --build
```
