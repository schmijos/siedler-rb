# frozen_string_literal: true

module DescribeMethod
  def called_with(*arguments, &block)
    context "called with (#{arguments.join(', ')})" do
      subject do |example|
        matches = example.metadata[:full_description].match(/\#(?<method_name>[a-z_]*) /)
        if matches
          instance.send(matches[:method_name], *arguments)
        else
          raise <<~ERROR_MESSAGE
            Please describe method example groups like this (including the hash symbol):

              describe "#method_name" do
                called_with(5) { is_expected.not_to be_nil }
              end
          ERROR_MESSAGE
        end
      end

      it { instance_eval(&block) }
    end
  end
end
