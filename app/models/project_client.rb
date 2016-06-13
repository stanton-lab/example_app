# == Schema Information
#
# Table name: project_clients
#
#  id         :integer          not null, primary key
#  project_id :integer
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_project_clients_on_client_id   (client_id)
#  index_project_clients_on_project_id  (project_id)
#

class ProjectClient < ActiveRecord::Base
  belongs_to :project
  belongs_to :client
end
