# HomeImprovementTrackerDB

Spring Boot application for managing the database schema of the Home Improvement Tracker using PostgreSQL and Flyway migrations.

## Prerequisites

- Java 17 or higher
- Maven 3.6+
- PostgreSQL database running on localhost:5432

## Database Setup

Ensure you have PostgreSQL running and create the database:

```sql
CREATE DATABASE HomeImprovementTracker;
CREATE USER hitadmin WITH PASSWORD 'hitadmin';
GRANT ALL PRIVILEGES ON DATABASE HomeImprovementTracker TO hitadmin;
```

## Project Structure

```
HomeImprovementTrackerDB/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/com/homeimprovement/tracker/
│   │   │   └── HomeImprovementTrackerApplication.java
│   │   └── resources/
│   │       ├── application.properties
│   │       └── db/migration/
│   │           └── V1__Create_initial_schema.sql
```

## Configuration

The application is configured in `src/main/resources/application.properties`:

- **Database URL**: `jdbc:postgresql://localhost:5432/HomeImprovementTracker`
- **Username**: `hitadmin`
- **Password**: `hitadmin`
- **Flyway**: Enabled for automatic schema migrations

## Running the Application

### Using Maven

```bash
mvn spring-boot:run
```

### Using Maven Package

```bash
mvn clean package
java -jar target/home-improvement-tracker-1.0.0.jar
```

## Flyway Migrations

Flyway will automatically run migrations on application startup. Migrations are located in `src/main/resources/db/migration/`.

To add new schema changes:
1. Create a new SQL file in the migration directory following the naming convention: `V{version}__{description}.sql`
2. Example: `V2__Add_audit_tables.sql`
3. Restart the application to apply the migration

## Initial Schema

The initial migration (V1) creates the following tables:
- **users**: User accounts with authentication information
- **homes**: Home properties linked to users (foreign key to users)
- **room_types**: Standardized room type classifications (e.g., bedroom, bathroom, kitchen)
- **rooms**: Individual rooms within homes (foreign key to homes and room_types)
- **paint_colors**: Paint color information including color code, brand, and base name
- **painting_instructions**: Junction table for many-to-many relationship between rooms and paint colors

## Development

To run the application in development mode with SQL logging enabled, the configuration is already set in `application.properties`:
- `spring.jpa.show-sql=true`

## Testing

Run tests using Maven:

```bash
mvn test
```
