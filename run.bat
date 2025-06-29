@echo off
REM --- run_tests.bat ---
REM This batch file executes Karate tests directly using the Karate JAR.
REM It passes various configuration parameters as Java system properties.

REM The command below executes the Karate JAR with specific parameters:
REM
REM 'C:\Program Files\Java\openjdk-11\bin\java.exe'
REM   - Specifies the full path to the Java executable.
REM
REM -DcertFile="certificate.p12"
REM   - Sets the 'certFile' system property, which is read by karate-config.js
REM     to locate your client certificate (PKCS12 format).
REM     Ensure 'certificate.p12' is in the same directory as the .bat file,
REM     or provide its full path.
REM
REM -DapiUrl=https://apiurl.net
REM   - Sets the 'apiUrl' system property, used in karate-config.js as the base URL
REM     for your API calls.
REM
REM -Denv=dev
REM   - Sets the 'env' system property, used in karate-config.js to determine
REM     the execution environment (e.g., 'dev', 'qa', 'prod').
REM
REM -DcertPwd=PWD
REM   - Sets the 'certPwd' system property, the password for your 'certificate.p12'.
REM     CAUTION: Hardcoding passwords in scripts is generally not recommended for security.
REM     Consider environment variables or secure Jenkins credentials for production.
REM
REM -DbearerKey=BearerKey
REM   - Sets the 'bearerKey' system property, which karate-config.js uses to
REM     construct the Authorization Bearer token header.
REM     CAUTION: Hardcoding tokens is not recommended. Use secure methods.
REM
REM -jar .\karate-1.4.0.jar
REM   - Specifies that a JAR file should be executed. '.\karate-1.4.0.jar'
REM     points to the Karate executable JAR. Ensure this file is present
REM     in the same directory as the .bat file.
REM
REM smoke-test2.feature smoke-test1.feature
REM   - These are the specific feature files that Karate will execute.
REM     You can list multiple feature files separated by spaces.
REM     Karate will look for these files relative to the current directory.
REM
REM -t '@Smoke'
REM   - This is a tag expression. Karate will only execute scenarios or features
REM     within the specified feature files that have the '@Smoke' tag.
REM     This is useful for running subsets of tests (e.g., smoke tests, regression tests).
REM
REM --output report
REM   - Specifies the output directory for test reports. Reports (HTML, JUnit XML)
REM     will be generated in a folder named 'report' (or the default 'target/karate-reports'
REM     if not specified, depending on how Karate is set up internally for standalone JAR).

REM Execute the command
& 'C:\Program Files\Java\openjdk-11\bin\java.exe' -DcertFile="certificate.p12" -DapiUrl=https://apiurl.net -Denv=dev -DcertPwd=PWD -DbearerKey=BearerKey -jar .\karate-1.4.0.jar smoke-test2.feature smoke-test1.feature -t '@Smoke' --output report

echo.
echo Karate test execution finished.
echo.

pause