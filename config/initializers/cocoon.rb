module Cocoon
  module ViewHelpers
    def create_object_on_association(f, association, instance, force_non_association_create)
      if instance.class.name == "Mongoid::Relations::Metadata" || force_non_association_create
        create_object_with_conditions(instance)
      else
        assoc_obj = nil

        if instance.collection?

          if f.object.respond_to?(:model) && f.object.send(association).is_a?(Disposable::Twin::Collection)
            # HACK! Add Disposable::Twin::Collection support
            assoc_obj = f.object.model.send(association).build
            f.object.model.send(association).delete(assoc_obj)

          else
            # assume ActiveRecord or compatible
            assoc_obj = f.object.send(association).build
            f.object.send(association).delete(assoc_obj)
          end
        else
          assoc_obj = f.object.send("build_#{association}")
          f.object.send(association).delete
        end

        assoc_obj = assoc_obj.dup if assoc_obj.frozen?

        assoc_obj
      end
    end
  end
end