module CotoHelper
  ## Default App Helpers ##
  def page_title(title=APP_CONFIG['page_title'])
    content_for(:title) { title }
  end
  
  def app_title(title=APP_CONFIG['app_title'])
    content_for(:app_title) { title }
  end
  
  def defualt_title
   APP_CONFIG['page_title']
  end
  
   #Renders button 1 on left of Home button
    def button_1(text,path,options={})
        content_for(:button1) || "<td>#{link_to "<div class='three'><center>#{text}</center></div>", path, options }</td>"
    end

   #Renders button 1 on left of Home button
    def button(id,text,path,options={})
        content_for(id) do 
            link_to(path, options) do
                capture_haml do
                  haml_tag "div", {:class => 'three'} do
                    haml_tag "p", text
                  end
                end
            end
        end
    end

   #Generates controller links accross left side of top bar
   def create_top_links_for_controllers(*controllers)
     controllers.each do |controller|
       content_for :top_link do
          if params[:controller] == controller.downcase then 
            capture_haml do
              haml_tag "b", controller.titlecase + " "
            end
          else
           link_to(controller.titlecase, url_for(:controller => controller.downcase, :action => 'index') ) + " "
          end
        end
     end
   end
   
   #Generate action links accross left side of top bar
   def create_top_links_for_path(title,path)
     content_for :top_link do
       link_to title,path
      end
   end

   #Create Logout on right side of top bar
   def create_logout
     if logged_in?
       content_for :logout do
         link_to "Logout", logout_path
       end
     else
       content_for :logout do
         link_to "Login", login_path
       end
    end
   end 
   
   def javascripts(*file)
    content_for :javascripts do
      javascript_include_tag file
    end
   end
   
   def stylesheets(*file)
     content_for :stylesheets do
       stylesheet_link_tag file
     end
   end
   
   #Creates searchable dropdowns from array of tables
   def searchables(*tables)
     Searchable.new(tables,self).selectors_for_search
   end
   ## End default App helpers ##
end