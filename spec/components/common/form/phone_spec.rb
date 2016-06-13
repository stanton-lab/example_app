# require 'rails_helper'
#
# describe Common::Form do
#   include Common::Form::Phones
#
#   it 'will be valid' do
#     form = described_class.new(Phone.new)
#     expect(form.validate(attributes_for(:phone)))
#       .to be_truthy
#   end
#
#   it 'will be not valid if image is not present' do
#     form = described_class.new(Phone.new)
#     expect(form.validate(attributes_for(:phone, phone: 'qweqwe')))
#       .to be_falsey
#   end
#
# end