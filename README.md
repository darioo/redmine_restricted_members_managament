Redmine Restricted Members Managament
=======

Plugin for Redmine which give additional restriction for roles with :manage_members permission

Now, you can select for each roles with that permission, which roles you are able to assign in Setting->Members site

For example, you can set:

* Project Manager can add:  Developers, Testers, Designers Tech Leads
* Tech Leads can add only Developers
* Admin can add all Roles

Installation
==============
To Install this plugin goto plugins in your redmine repository

Clone the git repository: 

`git clone git@github.com:darioo/redmine_restricted_members_managament.git`

and than restart Redmine

Configuration
==============

Go to *redmine_restricted_members_managament* plugin configuration page and set all allowed roles 
