Feature: Search, view, create, edit and remove designs.
  In order to manage designs
  As a worker
  I want to be able to view and manipulate them.
  
  Scenario: Click on a letter to view the design
    Given I have 1 design 
    And I am on the designs page
    When I click on a design's first letter
    Then I should see the design name
  
  
  
