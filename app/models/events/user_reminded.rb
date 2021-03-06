class Events::UserReminded < Event
  include Events::Notify::InApp
  include Events::Notify::Users

  def self.publish!(model, actor, reminded_user)
    create(kind: 'user_reminded',
           eventable: model,
           custom_fields: { reminded_user_id: reminded_user.id },
           user: actor).tap { |e| EventBus.broadcast('user_reminded_event', e) }
  end

  def poll
    eventable.poll
  end

  private

  def mailer
    "#{eventable.class}Mailer".constantize
  end

  def email_recipients
    notification_recipients.where(email_when_mentioned: true)
  end

  def notification_recipients
    User.where(id: custom_fields['reminded_user_id'].to_i)
  end
end
