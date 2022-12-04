# frozen_string_literal: true
run 'bundle remove tzinfo-data'
run 'bundle install'

template '~/driftingruby/template/drifting_ruby.css', 'app/assets/stylesheets/drifting_ruby.css'
run 'rm public/favicon.ico'
template '~/driftingruby/template/favicon.ico', 'public/favicon.ico'
template '~/driftingruby/template/logo.png', 'app/assets/images/logo.png'
generate(:controller, 'welcome', 'index')

gsub_file 'app/views/layouts/application.html.erb', '<body>', "<body class='bg-light'>"
gsub_file 'app/views/layouts/application.html.erb', '<title>Template</title>', '<title>Drifting Ruby</title>'
gsub_file 'app/views/layouts/application.html.erb', '<%= yield %>' do
  <<~RUBY
    <div class="container bg-white border pb-3">
          <%= render 'layouts/navigation' %>
          <% flash.each do |type, msg| %>
            <% if type == 'alert' %>
              <%= content_tag :div, msg, class: "alert alert-danger", role: :alert %>
              <% else %>
              <%= content_tag :div, msg, class: "alert alert-primary", role: :alert %>
            <% end %>
          <% end %>
          <%= yield %>
        </div>
  RUBY
end

template '~/driftingruby/template/_navigation.html.erb', 'app/views/layouts/_navigation.html.erb'
template '~/driftingruby/template/_navigation_links.html.erb', 'app/views/layouts/_navigation_links.html.erb'
run 'cp -R ~/driftingruby/template/templates lib/templates'
inject_into_file 'config/application.rb', before: '  end' do
  <<-CODE
    config.generators do |g|
      g.assets            false
      g.helper            false
      g.test_framework    nil
      g.jbuilder          false
    end
  CODE
end

route "root to: 'welcome#index'"

after_bundle do
  inject_into_file 'app/assets/stylesheets/application.bootstrap.scss' do
    <<~CODE
      @import 'drifting_ruby';
    CODE
  end

  git :init
  git add: '.'
  git commit: %( -m 'base')
end
