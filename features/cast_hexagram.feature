Feature: Casting a hexagram

  Scenario: Opening the casting menu
    Given I start the app
    When I touch "Cast hexagram"
    Then the screen should match "casting menu open"

  Scenario: Opening the cast screen
    Given I start the app
    When I touch "Cast hexagram"
    And I touch "Yarrow"
    Then the screen should match "casting screen"

  Scenario: Viewing the stabilized hexagram
    Given I start the app
    When I touch "Cast hexagram"
    And I touch "Yarrow"
    And I page left
    Then the screen should match "stabilized hexagram"

  Scenario: Viewing the changed hexagram
    Given I start the app
    When I touch "Cast hexagram"
    And I touch "Yarrow"
    And I page right
    Then the screen should match "changed hexagram"
