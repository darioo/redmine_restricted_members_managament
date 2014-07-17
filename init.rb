require 'redmine'

Redmine::Plugin.register :redmine_restricted_members_managament do
  
  name 'Redmine Restricted Members Managament'
  author 'Dariusz Kowalski'
  description 'This plugin add restriction for member management'
  version '0.0.1' 
  author_url 'https://github.com/darioo'
  url "https://github.com/darioo/redmine_restricted_members_managament" if respond_to?(:url)

   settings :default => { 'restricted_members_table' => {} },
           :partial => 'settings/restricted_memebers_managament'

end

#require_dependency 'improved_subtasks/patches/issue_patch'