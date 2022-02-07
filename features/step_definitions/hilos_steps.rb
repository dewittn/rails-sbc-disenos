Given /^I have no marcas$/ do
  Marca.delete_all
end

Then /^I should have ([0-9]+) marca?$/ do |count|
  Marca.count.should == count.to_i
end
