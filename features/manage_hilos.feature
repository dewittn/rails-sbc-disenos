Feature: Create and edit, colors and marcas
  In order to manage the colors used by hilos
  As a admin
  I want to be able to create and edit those values
  
  Scenario: Create hilo
    Given I have no marcas
    And I have no colors 
    And I am on the hilos page
    When I follow "Nuevo =>"
    And I fill in "marca_nombre" with "Ra"
    And I fill in "marca_colors_attributes_0_nombre" with "Rojo"
    And I fill in "marca_colors_attributes_0_codigo" with "AB12"
    And I fill in "marca_colors_attributes_1_nombre" with "Rojo"
    And I fill in "marca_colors_attributes_1_codigo" with "AB12"
    And I fill in "marca_colors_attributes_2_nombre" with "Rojo"
    And I fill in "marca_colors_attributes_2_codigo" with "AB12"
    And I press "Crear =>"
    Then I should see "Nos se pudo guardar..." 
    And I should have 1 marca
    And I should have 3 color
  
  Scenario: View hilos
    Given I have 1 marcas 
    And I am on the hilos page
    Then I should see the name of the marca
    
  Scenario: Edit a hilo
    Given I have 1 marca
    And I am on the hilos page
    When I follow the marca's name
    And I fill in "marca_colors_attributes_0_nombre" with "Rojo"
    And I press "Guadar"
    Then I should see "Actualizado..."
  
  
  