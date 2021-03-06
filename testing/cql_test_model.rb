module CukeModeler
  class CqlTestModel

    attr_accessor :attribute_1
    attr_accessor :attribute_2
    attr_accessor :attribute_3

    def children
      @children ||= []

      @children
    end


    # For cuke_modeler 0.x compatibility
    alias_method :contains, :children

  end

end

# Just a similarly named class for testing shorthand name matching
module CukeModeler
  class CqlTestModels

    attr_accessor :attribute_1
    attr_accessor :attribute_2
    attr_accessor :attribute_3

    def children
      @children ||= []

      @children
    end


    # For cuke_modeler 0.x compatibility
    alias_method :contains, :children

  end

end
