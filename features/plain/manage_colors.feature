Feature: Create and edit, colors and marcas
  In order to manage the colors used by hilos
  As a admin
  I want to be able to create and edit those values

  Scenario: View existing colors
    Given I have 1 color
    And I am on the colors page
    Then I should see the important field
    And I should see the color's info
    

  Scenario Outline: Create a valid color
    Given I have no colors
    And I am on the colors page
    When I follow "Nuevo =>"
    And <action>
    And I press "Crear =>"
    Then I should see <text>
    And I should have <count> color

  Examples:
    | action                   | text                | count |
    | I fill in the form       | "Nos se pudo guardar..."     | 1     |
    | I'm missing the "nombre" | "No se pudo crear..." | 0     |

  Scenario Outline: Edit color
    Given I have 1 color
    And I am on the colors page
    When I follow "edit"
    And I fill in <field> with <text>
    And I press "Guadar =>"
    Then I should see <text>
  
  Examples:
    | field           | text    |
    | "color[nombre]" | "Red"   |
    | "color[codigo]" | "ASJD1" |