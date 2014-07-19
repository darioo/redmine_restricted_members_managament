module RestrictedMembersManagament
  module Patches
    module ProjectsControllerPatch
      unloadable
      
      def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do
#	  alias_method_chain :safe_attributes=, :disabled_check_leafs
 #         alias_method_chain :recalculate_attributes_for, :improvements
        end
      end
      
      module InstanceMethods 
      end
      
      module ClassMethods
	
	def permitted_roles_for_user (current_user , users_by_role) 
	   # users_by_role = @project.users_by_role
	   current_user_roles = []

	   users_by_role.keys.sort.each do |role|
		users_by_role[role].sort.each do |u|
        		current_user_roles << role.id if u.id == current_user
		end
	   end

	   current_user_permitted_roles = []

      	   restricted_members = Setting["plugin_redmine_restricted_members_managament"] 

	   unless restricted_members.nil? 
		unless restricted_members[:restricted_members_table].nil?

	   current_user_roles.each do |r|
	        if restricted_members[:restricted_members_table].key?(r.to_s)
       		     restricted_members[:restricted_members_table][r.to_s].each do |k, v|
                	current_user_permitted_roles << k
           	     end
	            current_user_permitted_roles.uniq
      	        end
	    end
	    end
	    end
	    current_user_permitted_roles
	end
           
      end

    end
  end
end

require_dependency 'projects_controller'
ProjectsController.send(:include,  RestrictedMembersManagament::Patches::ProjectsControllerPatch)
