module CotoHelper
  ## Default App Helpers ##
   #returns srting for the page title
   def page_title(title)
     content_for(:title) { title }
   end

   #Renders button 1 on left of Home button
   def button_1(text,path,options={})
     content_for(:button1) do
       "<td>#{link_to "<div class='three'><center>#{text}</center></div>", path, options }</td>"
   	end
   end

   #Renders button 1 on left of Home button
   def button_2(text,path,options={})
     content_for(:button2) do
       "<td>#{link_to "<div class='three'><center>#{text}</center></div>", path, options }</td>"
   	end
   end

   #Generates links accross left side of top bar
   def create_top_links(*controllers)
     controllers.each do |controller|
       content_for :top_link do
          params[:controller] == controller.downcase ? "<b>#{controller.titlecase}</b>&nbsp;" : link_to( controller.titlecase, url_for(:controller => controller.downcase, :action => 'index') ) + "&nbsp;"
        end
     end
   end

   #Create Logout on right side of top bar
   def create_logout
     content_for :logout do
       link_to "Logout", logout_path
     end
   end 
   
   #Creates searchable dropdowns from array of tables
   def searchables(*tables)
     Searchable.new(tables,self).selectors_for_search
   end
   ## End default App helpers ##
end