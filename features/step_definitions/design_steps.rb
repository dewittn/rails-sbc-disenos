Given /^I have ([0-9]+) design$/ do |count|
  count.to_i.times do
    @marca = Marca.make
    @color = Color.make(:marca_id => @marca.id)
    Diseno.make do |diseno|
      diseno.hilos.make(:color_id => @color.id)
    end
  end
end

When /^I click on a design's first letter$/ do
  @diseno = Diseno.first
  When "I follow \"#{@diseno.nombre_de_orden.first.titlecase}\""
end


Then /^I should see the design name$/ do
  @diseno = Diseno.first
  Then "I should see \"#{@diseno.nombre_de_orden}\""
end