module Department::Form
  class Create < ::Reform::Form
    property :name

    validates :name, presence: true
  end
end