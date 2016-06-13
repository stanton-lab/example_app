require 'rails_helper'

RSpec.describe ProjectClient, type: :model do
  it { should belong_to(:client) }
  it { should belong_to(:project) }
end
