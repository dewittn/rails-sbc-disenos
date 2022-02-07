Given /^I have no colors$/ do
  Color.delete_all
end

Then /^I should have ([0-9]+) color$/ do |count|
  Color.count.should == count.to_i
end

When /^I fill in the form$/ do
  @color = Color.plan
  @marca = Marca.plan
  When "I fill in the fields with", table(%{
  | field                | value                |
  | "color[nuevo_marca]" | "#{@marca[:nombre]}" |
  | "color[nombre]"      | "#{@color[:nombre]}" |
  | "color[codigo]"      | "#{@color[:codigo]}" |
  })
end

When /^I fill in the fields with$/ do |table|
  table.hashes.each do |hash|
    When "I fill in #{hash[:field]} with #{hash[:value]}"
  end
end