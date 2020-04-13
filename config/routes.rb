Rails.application.routes.draw do
  # Routes for the Article resource:

  # CREATE
  get("/articles/new", { :controller => "articles", :action => "new_form" })
  post("/create_article", { :controller => "articles", :action => "create_row" })

  # READ
  get("/articles", { :controller => "articles", :action => "index" })
  get("/articles/:id_to_display", { :controller => "articles", :action => "show" })

  # UPDATE
  get("/articles/:prefill_with_id/edit", { :controller => "articles", :action => "edit_form" })
  post("/update_article/:id_to_modify", { :controller => "articles", :action => "update_row" })

  # DELETE
  get("/delete_article/:id_to_remove", { :controller => "articles", :action => "destroy_row" })

  #------------------------------

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
