Feature: Create and edit, colors and marcas
  In order to manage the colors used by hilos
  As a admin
  I want to be able to create and edit those values
  
  Scenario: Create hilo
    Given I am on the hilos page
    When I follow "Nuevo =>"
    And I fill in "marca_nombre" with "Ra"
    And I fill in "marca_colors_attributes_0_nombre" with "Rojo"
    And I fill in "marca_colors_attributes_0_codigo" with "AB12"
    And I press "Crear =>"
    Then I should see "Nos se pudo guardar..." 
    And I should have 1 marca and 1 color
  
