# frozen_string_literal: true

class NotificationRspec
  attr_accessor :failed_examples, :pending_examples, :duration, :passed_examples

  def examples
    [failed_examples, passed_examples, pending_examples].flatten
  end

  def rerun_argument_for(_)
    'path_to_spec'
  end
end
