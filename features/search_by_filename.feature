Feature: Search by filename
  
  Background:
    Given I start the app with "-c gedit features/support/assets"
  
  Scenario: Matching full filename
    Given I enter ":f foo"
    Then I should see
    """
       1: foo.rb
    """
  
  Scenario: Partial case-insensitive match
    Given I enter ":f cap"
    Then I should see
    """
       1: Capfile
    """
  
  Scenario: Fuzzy filename match
    Given I enter ":f testfile"
    Then I should see
    """
       1: test_file.txt
    """
  
  Scenario: Files appear listed alphabetically
    Given I enter ":f file"
    Then I should see
    """
       1: Capfile
       2: test_file.txt
    """

