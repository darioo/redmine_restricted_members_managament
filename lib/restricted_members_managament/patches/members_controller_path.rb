module RestrictedMembersManagament
  module Patches
    module MembersControllerPatch
      unloadable
      
      def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do
	  alias_method_chain :create, :restrictions
          alias_method_chain :update, :restrictions
        end
      end
      
      module InstanceMethods 
	def create_with_restrictions
		clean_params
		create_without_restrictions
	end


	def update_with_restrictions
		unless User.current.admin?
			clean_params

			current_user_permitted_roles = ProjectsController.permitted_roles_for_user(User.current.id ,  @project.users_by_role)		
			@member.roles.each do |role|
  			 params[:membership][:role_ids].push(role.id.to_s) unless current_user_permitted_roles.include?(role.id.to_s)
			end
		end
		update_without_restrictions
	end

	def clean_params 
	   unless User.current.admin?
		current_user_permitted_roles = ProjectsController.permitted_roles_for_user(User.current.id ,  @project.users_by_role)



                position=0
                array_to_delete = []
                for r in params[:membership][:role_ids]
                        to_del =  !current_user_permitted_roles.include?(r.to_s)
                        array_to_delete << position if to_del
                        position = position + 1
                end

                j = 0
                array_to_delete.each do |i|
                        params[:membership][:role_ids].delete_at(i-j)
                        j = j + 1
                end
	    end
	end

      end
      
      module ClassMethods
	
      end

    end
  end
end

require_dependency 'members_controller'
MembersController.send(:include,  RestrictedMembersManagament::Patches::MembersControllerPatch)
