# Steps in Creating the Application
  1. Create new Rails App
      terminal~$ rails new <app_name> or rails new <app_name> -d mysql
    
  2. Add spine-rails gem to your Gemfile. Then execute bundle install
      gem 'spine-rails'
    
  3. Add execjs and therubyracer gem to your Gemfile. Then execute bundle install
      gem 'execjs'
      gem 'therubyracer'
      
  4. Create the database if you are using mysql if not escape this step.
      terminal~$ rake db:create
      
  5. Create a scaffold for Project controller and model
      terminal~$ rails g scaffold project name:string description:string
    
  6. Migrate the Database
      terminal~$ rake db:migrate
      
  7. Create a new spine application
      terminal~$ rails g spine:new
      
  8. Check the directory for the newly created files under app/assets/javascripts/ called 'app'
     hint: you will see an index.js.coffee file inside.
     
  9. Generate a new model called 'project' in spine. It should match the model that we created in the server side.
      terminal~$ rails g spine:model project title description
      
  10. Run the Rails Server to check
      terminal~$ rails s
      
  11. Visit the Projects Page in your browser. http://localhost:3000/projects
  
  13. Create a test project via browser console.
      Enter this in your browser console.
      
      var project = App.Project.create({ name: 'Test Project', description: 'Test Project Descriptoin'});
      
  14. Create Spine Scaffolding
      Pre: add eco gem since spine scaffolding requires it.Then run 'bundle install'
      
      gem 'eco'
      
  15. Generate spine scaffolding with the name of the model in Capital first letter.
      terminal~$ rails g spine:scaffold Project name description
      
      New controller will be generated named projects.js.coffee
      
  16. Add this to your application.css file to make sure that only one controller show at a time.
  
      .stack > *:not(.active){
          display: none;
       }
       
  17. Instantiate our controller to our application. Add the code below to app/index.js.coffee
      
      @append(@projects = new App.Projects)
      
  18. Last thing is remove the scaffold view rails created. Just leave the index.html.erb and change the content
      to code below. So when the page load the application will be instantiated using the div.
      
      <div id="app"></div>

      <script type="text/javascript" charset="utf-8">
        jQuery(function(){
          new App({el: $('#app')});
        })
      </script>
  
        
            
