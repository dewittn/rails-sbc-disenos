Feature: Create and edit, colors and marcas
  In order to manage the colors used by hilos
  As a admin
  I want to be able to create and edit those values

  Scenario: Create color
    Given I have no colors
    And I am on the colors page
    When I follow "Nuevo =>"
    And I fill in the form
    And I press "Submit" 
    Then I should see "Color created"
    And I should have 1 color
  
  
  
