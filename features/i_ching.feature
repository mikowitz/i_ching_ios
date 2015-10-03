Feature: Launching the IChing app

  Scenario: Viewing the hexagram table screen
    When I start the app
    Then the screen should match "hexagram table screen"

  Scenario: Viewing a hexagram screen
    Given I start the app
    When I touch "Chinese Name 1"
    Then the screen should match "hexagram screen"

  Scenario: Viewing a hexagram's image text
    Given I start the app
    And I touch "Chinese Name 1"
    When I touch "THE IMAGE"
    Then the screen should match "hexagram screen showing image"
