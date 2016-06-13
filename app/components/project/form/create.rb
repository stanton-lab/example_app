module Project::Form
  class Create < ::Reform::Form
    property :name
    property :manager_id
    property :clients,
             prepopulator: :prepopulate_clients!,
             populator: :populate_clients!, reject_if: :all_bank?

    validates :name, presence: true, length: 2..36
    validates :clients, presence: true
    validates :manager_id, presence: true

    private
    def populate_clients!(options)
      options[:fragment].reject { |id| id.blank? }.each do |id|
        self.clients << Client.find(id)
      end
    end

    def prepopulate_clients!(options)
      self.clients = model.project_clients.map(&:client_id) if model.project_clients.present?
    end
  end
end