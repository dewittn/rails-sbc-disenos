module CotoSearch
  ## Search Methods ##
  def build_sql(*arry)
    arry.each do |a| 
      @conditions = [] unless not @conditions.nil? 
      a.class == Class ? id = (a.name.downcase + "_id").to_sym : id = a
      @conditions = add_condition(@conditions,params[id],id.id2name) unless params[id].empty? unless params[id].blank? 
    end
    @conditions
  end
  
  def custom_condition(sql,condition)
    sql.empty? ? sql = [condition] : sql[0] = sql[0] + " AND #{condition}" 
    sql
  end
  
  def add_condition(c_arry,c_add,c_table)
        unless c_add.blank?
          if c_arry.empty?
            c_arry = [c_table + " = ?"]
            c_arry + [c_add]
          else
            c_arry[0] = c_arry[0] + " AND #{c_table} = ?" 
            c_arry + [c_add]
          end
        end
  end
  ## End Search Menthods ##
end

module Searches
  def search(condistions={},order='id')
    find :all, :conditions => condistions,:order => order
  end
  
  def pag_search(page,condistions={},order='id')
    paginate :per_page => 10, :conditions => condistions,:order => order, :page => page     
  end
  
  def search_xml(condistions ={})
    find(:all,:conditions => condistions,:order => 'id')
  end
  
  def sort(column='descr')
    find(:all,:order => "#{column} ASC")
  end
end

class ActiveRecord::Base
  extend Searches
end