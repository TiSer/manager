Manager::Application.routes.draw do

  resources :milestones

  controller :milestones do
    get  "project_milestone/:id/new"  => :new,    :as => "new_milestone"
    post "project_milestone/:id"      => :create, :as => "milestones"
    get  "project_milestone/bill/:id" => :milestone_bill, :as => "milestone_bill"
    get "project_milestone/:project_id/:id/edit" => :edit, :as => "edit_milestone"
    put "project_milestone/:project_id/:id" => :update, :as => "update_milestone"
  end

  resources :deals

  controller :deals do
    get  "milestone_deals/:milestone_id" => :milestone_deals, :as => "milestone_deals"
  end

  resources :month_working_days

  resources :milestones

  resources :activities

  resources :salaries

  get "wellcome/hello"

  resources :bookings

  resources :projects

  devise_for :users

  resources :employees

  resources :departments

  resources :customers

  resources :skills

  controller :projects do
    get "project_milestone/:id"  => :milestone, :as => "project_milestone"
    get "project_activity_costs/:id" => :costs, :as => "activity_costs"
  end

  controller :activity_costs do
    get "activity_edit/:id/edit" => :cost_edit, :as => "activity_edit"
#    get "project_edit_cost/:id/edit" => :cost,  :as => "activity_cost"
#    post"project_activity_costs/:project_id"     => :create_act_cost, :as => "costs"
#    get "project_activity_costs/:project_id/new" => :costs,           :as => "new_activity_cost"
#    get "project_activity_costs/:project_id/:id"  => :costs,           :as => "edit_activity_cost"
    put "project_activity_costs/:id" => :update_act_cost,              :as => "activity_cost"
  end

  controller :month_working_days do
    get "working_days_list" => :months_on_year_list, :as => "year_working_days_list"
    get "edit_month_working_days" => :edit_month_working_days, :as => "edit_month_working_days"
  end

  controller :reports do
    get "reports/employees_bookings" => :employees_bookings, :as => "report_employees_bookings"
    get "reports/employee_free_hours" => :free_hours, :as => "report_employees_free_hours"
  end

  controller :salaries do
    get "employee_salaries/:employee_id" => :employee_salary, :as => "employee_salary"
    get "edit_salary/:employee_id" => :edit_salary, :as => "edit_salary"
  end

  controller :salaries do
    get "employee_salaries/:employee_id" => :employee_salary, :as => "employee_salary"
  end

  get "project_staffing/:id" => "projects#staffing", :as => "staffing"

  get "project_add_staffing/:id" => "projects#add_staff", :as => "add_staff"

  post "project_save_participant/:id" => "projects#save_staff", :as => "save_staffing"

  delete "project_delete_participant/:project_id/employee/:employee_id" => "projects#destroy_participant", :as => "delete_pariticipant"
  delete "project_delete_milestone/:project_id/milestones/:milestone_id"  => "projects#destroy_milestone", :as => "delete_milestone"
  delete "project_delete_participant/:project_id/employee/:employee_id" => "projects#destroy_participant", :as => "delete_participant"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
    root :to => "wellcome#hello"
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

