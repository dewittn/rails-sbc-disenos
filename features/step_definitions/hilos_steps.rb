Given /^I have no marcas$/ do
  Marca.delete_all
end

Then /^I should have ([0-9]+) marca?$/ do |count|
  Marca.count.should == count.to_i
end

Given /^I have ([0-9]+) marcas?$/ do |count|
  Given "I have no marcas"
  count.to_i.times do
    Marca.make do |marca|
      3.times { marca.colors.make }
    end
  end
end

Then /^I should see the name of the marca$/ do
  Then "I should see \"#{Marca.first.nombre}\""
end