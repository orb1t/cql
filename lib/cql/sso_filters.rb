require 'cql/filters'


module CQL

  # Not a part of the public API. Subject to change at any time.
  class SsoLineCountFilter < TypeCountFilter

    # Counts the numbers of steps on a test
    def type_count(test)
      test.steps.size
    end

  end

  # Not a part of the public API. Subject to change at any time.
  class LineFilter < ContentMatchFilter

    # Filters the input models so that only the desired ones are returned
    def execute(input, negate)
      method_for_filtering = negate ? :reject : :select
      method_for_text = Gem.loaded_specs['cuke_modeler'].version.version[/^0/] ? :base : :text

      input.send(method_for_filtering) do |tests|
        raw_step_lines = tests.steps.map { |step| step.send(method_for_text) }

        content_match?(raw_step_lines)
      end
    end

  end

end
