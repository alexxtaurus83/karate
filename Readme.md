# Karate Test Framework Execution Guide
Configuring, and executing Karate API tests using pipeline. Teh benefit you can directly execute test just having KarateJAR file and feature files. No need to have any other dependencies. 

Karate is an open-source API testing tool that combines API test automation, mocks, and performance testing into a single, unified framework. It uses a Gherkin-like syntax (similar to Cucumber) but is purpose-built for API testing, making it highly efficient for testing REST, SOAP, and GraphQL services.

**Key Advantages:**
* **No Java Coding (mostly):** Tests are primarily written in a simple, readable syntax, accessible to both developers and non-technical stakeholders. JavaScript can be used for advanced logic.
* **Built-in HTTP Client:** Handles all aspects of HTTP requests and responses natively.
* **Powerful Assertions:** Rich assertion capabilities for JSON and XML payloads, including schema validation.
* **Native JSON/XML Support:** Direct manipulation and validation of JSON/XML data.
* **JavaScript Engine:** Allows for dynamic test data generation, complex logic, and integration with Java code when necessary.

## Prerequisites

Before you can run the tests, ensure you have the following installed:

* **Java Development Kit (JDK) 11 or higher:** Your `run_tests.bat` explicitly uses `openjdk-11`.
    * Verify: Open a command prompt and type `java -version`.
* **Karate Executable JAR:** The `karate-1.4.0.jar` file must be present in the same directory as your `run_tests.bat` script. This JAR contains the entire Karate framework.