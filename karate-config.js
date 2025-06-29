function fn() {

    // --- Environment Selection ---
    // Retrieve the 'env' system property. If not provided, default to 'DEV'.
    var env = karate.properties['env'];
    if (!env) {
        env = 'DEV'; // Default environment if -Denv is not provided
    }

    // Set a Java system property 'runEnvironment'. This might be used by
    // custom Java code or for logging purposes outside of Karate's direct scope.
    java.lang.System.setProperty("runEnvironment", env);

    // --- API Base URL Configuration ---
    // Retrieve the 'apiUrl' system property. If null, set an empty string.
    // This allows you to pass the base URL dynamically from the command line.
    if (karate.properties['apiUrl'] == null) {
        var apiUrl = ""; // Default empty if no apiUrl provided
    } else {
        var apiUrl = karate.properties['apiUrl']; // Use the provided apiUrl
    }

    // --- SSL/TLS Certificate Configuration ---
    // Retrieve 'certPwd' and 'certFile' system properties for keystore access.
    // These are crucial for API endpoints requiring client-side certificates.
    var certPwd = karate.properties['certPwd'];
    var certFile = karate.properties['certFile'];

    // Configure SSL for all HTTP calls made by Karate.
    // - keyStore: Path to your PKCS12 certificate file.
    // - keyStorePassword: Password for the keystore.
    // - keyStoreType: Specifies the type of keystore (e.g., 'pkcs12').
    // - trustAll: Set to 'true' to disable SSL certificate validation. Use with caution in production!
    karate.configure('ssl', {
        keyStore: 'file:' + certFile, // 'file:' prefix is important for local paths
        keyStorePassword: certPwd,
        keyStoreType: 'pkcs12',
        trustAll: true // Disables SSL certificate validation (less secure for production)
    });

    // --- Authorization Header Configuration ---
    // Check if 'bearerKey' system property is provided.
    // If a bearer token is present, configure the 'Authorization' header for all requests.
    // Otherwise, only set the 'Accept' header.
    if (karate.properties['bearerKey'] == null) {
        // No bearer token provided, set only Accept header
        karate.configure('headers', { Accept: 'application/json' });
    } else {
        // Bearer token provided, set Authorization and Accept headers
        var bearerKey = karate.properties['bearerKey'];
        karate.configure('headers', {
            Authorization: 'Bearer ' + bearerKey, // Concatenate "Bearer " prefix
            Accept: 'application/json'
        });
    }

    // --- Timeout Configuration ---
    // Set connection and read timeouts for HTTP requests in milliseconds.
    // Prevents tests from hanging indefinitely.
    karate.configure('connectTimeout', 100000); // 100 seconds
    karate.configure('readTimeout', 100000);    // 100 seconds

    // --- Reporting Configuration ---
    // Customize Karate's reporting behavior.
    // - showLog: If true, the full HTTP request/response log is included in the report.
    // - showAllSteps: If true, all steps (even successful ones) are detailed in the report.
    //   Setting this to 'false' often makes reports cleaner by only highlighting failures or key steps.
    karate.configure('report', { showLog: true, showAllSteps: false });

    // --- Global Configuration Object ---
    // Define a 'config' object that will be returned.
    // Properties of this object will be available as global variables in your feature files.
    var config = {
        apiUrl: apiUrl, // The base API URL, dynamically set
        env: env        // The active environment (e.g., 'DEV', 'QA')
    };

    // Return the 'config' object. This makes all its properties
    // accessible globally within your Karate feature files.
    return config;
}