Feature: Search by content
  
  Background:
    Given I start the app with "-c gedit features/support/assets"
  
  Scenario: Find matching method definition
    Given I enter ":t def something"
    Then I should see
    """
       1: Capfile
       2: foo.rb
    """
  
  Scenario: Find matching method definition with arguments
    Given I enter ":t def something(one, two)"
    Then I should see
    """
       1: Capfile
    """

