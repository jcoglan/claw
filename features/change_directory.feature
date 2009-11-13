Feature: Change directories
  
  Background:
    Given I start the app with "lib -c gedit"
  
  Scenario: Changing directory affects search output
    Given I enter ":d ../features"
    And I enter ":f feature"
    Then I should see
    """
       1: change_directory.feature
       2: open_files.feature
       3: search_by_content.feature
       4: search_by_filename.feature
    """
    When I enter "2"
    Then "features/open_files.feature" should be open in "gedit"
  
  Scenario: The correct file is opened after changing directories
    Given I enter ":d ../features"
    And I enter ":f feature"
    And I enter ":d ../bin"
    And I enter "3"
    Then "features/search_by_content.feature" should be open in "gedit"

