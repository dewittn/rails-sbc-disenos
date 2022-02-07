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

When /^I'm missing the "([^\"]*)"$/ do |attribute|
  @color = Color.plan(attribute.to_sym  => "")
  @marca = Marca.plan
  When "I fill in the fields with", table(%{
  | field                | value                |
  | "color[nuevo_marca]" | "#{@marca[:nombre]}" |
  | "color[nombre]"      | "#{@color[:nombre]}" |
  | "color[codigo]"      | "#{@color[:codigo]}" |
  })
end

Given /^I have ([0-9]+) color$/ do |count|
  count.to_i.times do
    @marca = Marca.make
    Color.make(:marca_id => @marca.id)
  end
end