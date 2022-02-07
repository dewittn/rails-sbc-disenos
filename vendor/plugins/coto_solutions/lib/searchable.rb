class Searchable
  ## Search Selectors ##
  def initialize(tables,template)
    @tables = tables
    @template = template
  end
  
  def selectors_for_search()
    @tables.each do  |table|
      content_for :searchable_label do
        "<th>#{table.name}</th>"
      end
      content_for :searchable do
        "<td>#{select_for_search_from_table(table)}</td>"
      end
    end
  end
  
  def selectors_for_edit
    
  end
  
  def select_for_search_from_table(table)
    id = (table.name.downcase + "_id").to_sym
    select_tag id, options_for_select(values(table),params[id].to_i)
  end
  
  #def select_for_edit_from_table(table)
  #  id = (table.name.downcase + "_id").to_sym
  #  select_tag id, options_for_select(values(table))
  #end
  
  def select_for_search_from_collection(id,collection)
    selected = params[id].to_i unless params[id].blank?
    select_tag id, options_for_select(collection,selected)
  end
  
  def values(selected_model)
    [["Cualquiera",""]] + selected_model.all_cached.collect {|p| [ p['descr'], p['id'] ]}.sort{ |a,b| a <=> b }
  end
  
  def method_missing(*args,&block)
    @template.send(*args,&block)
  end
  ## End Search Selectors ##
end