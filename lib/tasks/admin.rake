require 'highline/import'
namespace :manager do
  namespace :admin do
    task create: :environment do
      I18n.locale = :en
      email = ask('Enter you email: ') do |q|
        q.validate = -> (email) do
          if EmailValidator.valid? email
            return true
          end
          q.responses[:not_valid] = 'Email is not valid'
          false
        end
      end
      pass = ask('Enter you password:  ') do |q|
        q.echo = '*'
        q.verify_match = true
        q.gather = {password: '', password_confirm: ''}
      end

      manager = Manager.new email: email, password: pass
      if manager.save(validate: false)
        puts 'Register successful'
        manager.add_role Role::ADMIN
      else
        puts 'Some error registration'
      end
    end
  end
end
