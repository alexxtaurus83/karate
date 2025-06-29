@generic_api @sample
Feature: Generic API Interaction Examples

  This feature demonstrates common API testing patterns in Karate,
  using generic paths and data to illustrate concepts from your files.

  Background:
    # Uses 'apiUrl' which is configured in karate-config.js
    * url apiUrl
    # A generic helper function, similar to 'random_string' in your files
    * def generateRandomString =
    """
    function(length) {
        var result = '';
        var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var charactersLength = characters.length;
        for (var i = 0; i < length; i++) {
            result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
    }
    """

  @read_operations @get_data
  Scenario Outline: Retrieve a list of generic resources    
    Given path <resource_path>
    When method GET
    * print 'GET Response:' response
    * print 'GET Status:' responseStatus
    Then status 200
    And match response == '#array' # Expect an array response

    Examples:
      | resource_path       |
      | '/items'            |
      | '/users'            |

  @create_operations @post_data
  Scenario: Create a new generic entry    
    * def newEntryId = 'ENT-' + generateRandomString(10) # Dynamic ID using the helper function
    * def entryDescription = 'Description for ' + newEntryId

    Given path '/entries'
    And request
      """
      {
        "id": "#(newEntryId)",
        "name": "New Generic Entry",
        "description": "#(entryDescription)",
        "status": "active",
        "tags": ["alpha", "beta"]
      }
      """
    When method POST
    * print 'POST Response:' response
    * print 'POST Status:' responseStatus
    Then status 201 # Typically 201 for resource creation
    And match response.id == newEntryId
    And match response.status == 'active'

  @update_operations @patch_data
  Scenario: Update an existing generic entry        
    * def existingEntryId = 'ENT-XYZ1234567' # Placeholder, replace with actual ID if chaining

    Given path '/entries', existingEntryId
    And request { "status": "updated", "notes": "Updated by automated test" }
    When method PATCH
    * print 'PATCH Response:' response
    * print 'PATCH Status:' responseStatus
    Then status 200
    And match response.status == 'updated'

  @query_with_params @get_data
  Scenario Outline: Retrieve data using query parameters    
    Given path <base_path>
    And param user_id = <user_id>
    When method GET
    * print 'Query Params Response:' response
    Then status 200
    And match response.version == '#string' # Example assertion on expected field
    And assert response.version.length() > 0 # Example for a more complex assertion

    Examples:
      | base_path           | user_id |
      | '/app/version'      | 'U123'  |
      | '/config/settings'  | 'U456'  |

  @dynamic_path_segment @get_data
  Scenario Outline: Retrieve data using dynamic path segments    
    Given path <base_path>, <dynamic_id>
    When method GET
    * print 'Dynamic Path Response:' response
    Then status 200
    And match response.id == <dynamic_id>

    Examples:
      | base_path  | dynamic_id |
      | '/orders'  | 'ORD-001'  |
      | '/products'| 'PROD-X'   |