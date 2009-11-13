Feature: Open files
  
  Background:
    Given I start the app with "-c gedit features/support/assets"
  
  Scenario: Opening a file by its index
    Given I enter ":f foo"
    And I enter "1"
    Then features/support/assets/foo.rb should be open in gedit
  
  Scenario: Selecting from more than one choice
    Given I enter ":f file"
    And I enter "2"
    Then features/support/assets/test_file.txt should be open in gedit
  
  Scenario: Openning all files
    Given I enter ":f file"
    And I enter ":a"
    Then features/support/assets/Capfile should be open in gedit
    And features/support/assets/test_file.txt should be open in gedit
  
  Scenario: Changing the program used to open files
    Given I enter ":f file"
    And I enter ":c firefox"
    And I enter "2"
    Then features/support/assets/test_file.txt should be open in firefox

