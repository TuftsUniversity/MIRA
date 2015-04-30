class PublishService < WorkflowService
  def initialize(*)
    super
    raise UnpublishableModelError unless object.publishable?
  end

  def run
    published_pid = PidUtils.to_published(object.pid)

    destroy_published_version!
    FedoraObjectCopyService.new(object.class, from: object.pid, to: published_pid).run

    published = object.class.find(published_pid)
    published!(published, user)
    published!(object, user)
    audit('Pushed to production')
    register_handle
  end

  private

    def register_handle
      return if has_handle?
      Job::RegisterHandle.create(record_id: object.id)
    end

    def has_handle?
      object.identifier.present?
    end

    # Mark that this object has been published
    def published!(obj, user)
      obj.publishing = true
      obj.save!
      obj.publishing = false
    end

end

class UnpublishableModelError < StandardError
  def message
    'Templates cannot be pushed to production'
  end
end

