# Exercise 5

class LaunchDiscussionWorkflow

  def initialize(discussion, host, participants)
    @discussion = discussion
    @host = host
    @participants = generate_users(participants)

    self.run
  end

  # Expects @participants array to be filled with User objects
  def run
    return unless valid?
    run_callbacks(:create) do
      ActiveRecord::Base.transaction do
        discussion.save!
        create_discussion_roles!
        @successful = true
      end
    end
  end

  def generate_users(string_array)
    return if @string_array.blank?
    @string_array.each do |email_address|
      User.create(email: email_address.downcase, password: Devise.friendly_token)
    end
  end
end


discussion = Discussion.new(title: "fake", ...)
host = User.find(uid: 42)
participants = "fake1@example.com\nfake2@example.com\nfake3@example.com"
participants = participants.split("\n")

workflow = LaunchDiscussionWorkflow.new(discussion, host, participants)
